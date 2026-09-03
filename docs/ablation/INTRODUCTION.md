# Introduction — 05 Supplementary Ablation

This directory holds the complete reproduction material for the paper's (Letter/SPL)
**supplementary ablation study**: code, run scripts, training logs, per-run checkpoints
(final EMA `ep100.pt` only), and all result tables. The system under study is our method
**frozen DINOv3 ViT-L/16 + LoRA r2 + ArcFace/LogitAdjust + SupCon + MIRO + EMA + DAS
(physics carrier augmentation) + ACR (carrier-residual + continuous-log-carrier GRL adversary)**.

Protocol: train 100 epochs, take the **EMA weights at the final epoch (ep100)**, evaluate on
the **full 418-clip 77 GHz** zero-shot test set, 3 seeds (42/1234/31415), with **no
target/source-val selection**.

## 7 new configs x 3 seeds = 21 training runs (all complete)
- **P0-A (ACR internal mechanism):** `ACR_Lfreq_only` (residual branch only),
  `ACR_GRL_only` (GRL adversary only), `ACR_discrete` (full ACR but with a discrete K-bin
  carrier adversary, i.e. the ordinary discrete-domain-adversary control).
- **P0-B (DAS body):** `DAS_ERM` (true no-augmentation floor), `DAS_stretch_only`
  (Doppler-stretch only).
- **P1 (schedule under ACR):** `SCHED_fixedfull_ACR`, `SCHED_fixednarrow_ACR`.

> The remaining comparison points (DAS only = A_REF, DAS+ACR = A_V13_GRL, radar-aug only =
> E1_noDAS, jitter = E1_jitter, fixed-full/narrow without ACR = E2_full/E2_narrow, etc.) are
> **existing anchors** archived under `02_proposed_*` and `04_all_logs`; they are not
> retrained here.

## Directory layout
- `analysis_scripts/`   — evaluation / aggregation code (generates all result tables; each file
  begins with an Introduction header).
- `run_scripts/`        — training launch scripts (the exact ones that produced
  `exact_result_runs/`; each file begins with an Introduction header).
- `modified_core_code/` — the **core code changes** made for this ablation (config / v9_2_1lib /
  trainer / pool_protocol) plus `CODE_CHANGES.diff`; each file begins with an Introduction
  header stating what changed. All changes are env-gated; defaults reproduce the original
  behaviour byte-for-byte.
- `exact_result_runs/`  — the **authoritative record** of the 21 runs: under
  `<config>/seed<seed>/` are `train.log`, `reports/` (incl. `history.json`), `manifests/`, and
  `epoch_ckpts/ep100.pt` (the final-EMA weights used for the reported numbers).
- `exact_result_reports/` — all result tables: `RESULTS_SUPP.md` (interpretation),
  `ablation_finalEMA_3seed.{md,json}` (main table), `ensemble_rules.{md,json}`,
  `paired_bootstrap_ci.{md,json}`, `bootstrap_continuous_vs_discrete.md`,
  `SUPPLEMENTARY_ABLATION_PLAN.md`, `READY.md`, `CODE_CHANGES.diff`.
- `orchestration_logs/` — orchestration / aggregation logs: `formal_all.log` (start/stop and
  exit code of every run), `aggregate_run.log`, `ensemble_run.log`, `bootstrap_run.log`,
  `bootstrap_discrete_run.log`, `gpu_wait.log`.

## Reproduction
See **`REPRODUCE.md`**: Mode A (re-evaluate the result tables directly from the `ep100.pt`
checkpoints in this directory — minutes, **exact**) and Mode B (full retrain from scratch, ~6 h;
under GPU non-determinism numbers drift by ~0.05/seed). The eval-harness cross-check is
`max |diff| vs history.json = 0.0000` (the evaluation pipeline is validated).

## Key findings (full detail in `exact_result_reports/RESULTS_SUPP.md`)
- The continuous log-carrier regressor **beats** the ordinary discrete domain adversary by
  **+3.6 pp** (0.832 vs 0.796; paired bootstrap +3.57 pp, 95% CI [+1.91, +5.31], P>0=1.000).
- Carrier-matched Doppler-stretch is the dominant driver: stretch-only vs ERM **+55.8 pp**;
  vs physics-free jitter **+18.6 pp**.
- ACR helps **only under the curriculum schedule** (curriculum+ACR 0.832; fixed-full+ACR
  collapses to 0.626).
- Paired bootstrap 95% CI: ACR +6.55 pp [4.69, 8.37]; DAS vs jitter +24.90 pp; ensemble
  +2.40 pp [0.89, 3.96] — all significant.
