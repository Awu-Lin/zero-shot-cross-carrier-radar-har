#!/usr/bin/env python
"""One-command reproduction of every paper number that can be recomputed from the shipped
final-EMA checkpoints (no training).

Runs, in order, from the repo root:

  (a) baseline_v20/aggregate_ablation_finalema.py      (AGG_INCLUDE_SUPP=1)
        Table II rows recomputable from checkpoints: proposed, ACR residual-only, ACR GRL-only,
        ACR discrete-bin, ERM, Doppler-stretch-only, plus the two schedule controls of Sec. III-C
        (fixed-narrow + ACR, fixed-full + ACR). Prints the harness cross-check against each run's
        history.json (must be 0.0000).
  (b) baseline_v20/ensemble_rules.py
        Table I rows 10-11: single-model 0.832 +/- 0.034 and the three ensemble rules
        (majority 0.851 / logit-average 0.857 / posterior-average 0.856).
  (c) baseline_v20/paired_bootstrap_ci.py  +  baseline_v20/bootstrap_discrete.py
        Paired class-stratified bootstrap CIs: ensemble vs single (+2.40 pp) and
        continuous vs discrete carrier adversary (+3.57 pp, 95% CI [+1.91, +5.31]).
  (d) EXPERIMENTSRESULT/REVISION_5090/public_baseline/pb_eval_unified.py --only A_V13_GRL
        The same proposed numbers through the unified public-baseline harness (Table I
        columns: macro-F1, accuracy, source-val F1, generalization gap, params, bootstrap CI).

Expected wall-clock: a few minutes on one CUDA GPU. On the very first run timm downloads the
DINOv3 ViT-L/16 backbone (vit_large_patch16_dinov3.lvd1689m, ~1.2 GB) into ./weights/hub.

Usage:
    python reproduce.py                 # all steps
    python reproduce.py --step a b      # a subset of steps
    python reproduce.py --n-boot 10000  # bootstrap resamples for step (d) (published: 2000)
"""
from __future__ import annotations

import argparse
import os
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent
REV = ROOT / "EXPERIMENTSRESULT" / "REVISION_5090"
PB = REV / "public_baseline"

EXPECTED = """
  Published values (paper Tables I-II, Sec. III), full-418 77 GHz, final-EMA, seeds 42/1234/31415
    proposed single macro-F1 .......... 0.832 +/- 0.034   (per seed 0.791 / 0.832 / 0.874)
    proposed accuracy ................. 0.836 +/- 0.032   source-val F1 0.967, gap +0.135
    ensemble majority / logit / post .. 0.851 / 0.857 / 0.856   (paper reports posterior: 0.856)
    ensemble bootstrap 95% CI ......... [0.821, 0.889]
    ensemble - single ................. +2.40 pp, 95% CI ~[+0.9, +4.0], P(>0) = 0.999
    continuous - discrete adversary ... +3.57 pp, 95% CI [+1.91, +5.31], P(>0) = 1.000
    ACR residual only / GRL only ...... 0.814 +/- 0.021 / 0.826 +/- 0.016
    ACR discrete-bin adversary ........ 0.796 +/- 0.034
    ERM / Doppler stretch only ........ 0.146 +/- 0.034 / 0.704 +/- 0.089
    fixed-narrow + ACR / fixed-full ... 0.800 +/- 0.057 / 0.626 +/- 0.058
"""

BACKBONE_CACHE = ROOT / "weights" / "hub" / "models--timm--vit_large_patch16_dinov3.lvd1689m"


def build_env() -> dict:
    """baseline_v8/v8lib.py points HF_HOME at ./weights and defaults HF_HUB_OFFLINE=1.
    If the backbone is not cached yet, release the offline latch so timm can download it."""
    env = os.environ.copy()
    env["PYTHONUNBUFFERED"] = "1"
    if BACKBONE_CACHE.is_dir():
        env.setdefault("HF_HUB_OFFLINE", "1")
        print(f"[env] cached DINOv3 backbone found -> offline ({BACKBONE_CACHE.relative_to(ROOT)})")
    else:
        env["HF_HUB_OFFLINE"] = "0"
        env["TRANSFORMERS_OFFLINE"] = "0"
        print("[env] backbone not cached -> timm will download vit_large_patch16_dinov3.lvd1689m "
              "(~1.2 GB) into ./weights/hub on first use")
    return env


def run(script: Path, args: list[str], env: dict) -> int:
    cmd = [sys.executable, str(script), *args]
    print(f"\n{'=' * 78}\n$ {' '.join(cmd)}\n{'=' * 78}", flush=True)
    return subprocess.call(cmd, cwd=str(ROOT), env=env)   # cwd matters: scripts use repo-relative paths


def preflight() -> None:
    missing = []
    for seed in (42, 1234, 31415):
        ck = REV / "A_V13_GRL" / f"seed{seed}" / "checkpoints" / "pool_ep100_ema.pt"
        if not ck.exists():
            missing.append(str(ck.relative_to(ROOT)))
    for cfg in ("ACR_Lfreq_only", "ACR_GRL_only", "ACR_discrete", "DAS_ERM", "DAS_stretch_only",
                "SCHED_fixedfull_ACR", "SCHED_fixednarrow_ACR"):
        for seed in (42, 1234, 31415):
            ck = REV / "SUPP_ABLATION" / cfg / f"seed{seed}" / "epoch_ckpts" / "ep100.pt"
            if not ck.exists():
                missing.append(str(ck.relative_to(ROOT)))
    if not (ROOT / "tasks" / "known_people_unknown_freq" / "manifest" / "test.csv").exists():
        missing.append("tasks/known_people_unknown_freq/manifest/test.csv")
    if missing:
        print("[FATAL] missing required files:", file=sys.stderr)
        for m in missing:
            print(f"  - {m}", file=sys.stderr)
        sys.exit(2)
    try:
        import torch
    except Exception as exc:                                  # noqa: BLE001
        print(f"[FATAL] cannot import torch: {exc}\n        pip install -r requirements.txt", file=sys.stderr)
        sys.exit(2)
    if torch.cuda.is_available():
        print(f"[env] torch {torch.__version__}  |  GPU {torch.cuda.get_device_name(0)}")
    else:
        print("[WARN] no CUDA device visible; scripts fall back to CPU and are very slow.")


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--step", nargs="*", choices=("a", "b", "c", "d"), default=None)
    ap.add_argument("--n-boot", type=int, default=2000)
    args = ap.parse_args()
    steps = set(args.step or "abcd")

    print(__doc__.split("Usage:")[0].rstrip())
    print(EXPECTED)
    preflight()
    env = build_env()
    rc = 0

    if "a" in steps:
        env_a = dict(env, AGG_INCLUDE_SUPP="1")
        rc |= run(ROOT / "baseline_v20" / "aggregate_ablation_finalema.py", [], env_a)
        print("\n[a] wrote EXPERIMENTSRESULT/CKPT_SELECTION_DIAG/ablation_finalEMA_3seed.{md,json}")
        print("[a] note: A_V20/A_V13/A_V15/A_REF/E1_*/E2_* print [skip]: their checkpoints are not "
              "available (see README, 'What can and cannot be recomputed').")
    if "b" in steps:
        rc |= run(ROOT / "baseline_v20" / "ensemble_rules.py", [], env)
        print("\n[b] wrote EXPERIMENTSRESULT/REVISION_5090/SUPP_ABLATION/eval_out/ensemble_rules.{md,json}")
    if "c" in steps:
        rc |= run(ROOT / "baseline_v20" / "paired_bootstrap_ci.py", [], env)
        rc |= run(ROOT / "baseline_v20" / "bootstrap_discrete.py", [], env)
        print("\n[c] wrote EXPERIMENTSRESULT/REVISION_5090/SUPP_ABLATION/eval_out/paired_bootstrap_ci.{md,json}")
    if "d" in steps:
        rc |= run(PB / "pb_eval_unified.py",
                  ["--only", "A_V13_GRL", "--n-boot", str(args.n_boot),
                   "--runs-root", str(PB / "runs_strong"), "--out-prefix", "pb_results_strong_repro"], env)
        print("\n[d] wrote EXPERIMENTSRESULT/REVISION_5090/public_baseline/pb_results_strong_repro{.json,_auto.md}")
        print("[d] note: rows #1-#9 print NOT RUN (baseline checkpoints are not shipped); their "
              "published values are in docs/public_baseline/pb_results_strong_auto.md.")

    print("\nPublished values, again, for comparison:")
    print(EXPECTED)
    print("Reference outputs of this exact script: docs/reproduction_2026-09-04/")
    return rc


if __name__ == "__main__":
    raise SystemExit(main())
