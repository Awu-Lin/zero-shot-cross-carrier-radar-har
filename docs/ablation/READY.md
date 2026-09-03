# Supplementary Ablation — READY (prepared + smoke-tested; NOT formally trained)

Prepared 2026-06-09 on the local box (Windows, RTX 5090, env `Lider_5090`,
torch 2.11+cu128). Implements + smoke-tests the supplementary ablations defined in
`SUPPLEMENTARY_ABLATION_PLAN.md`. **No 100-epoch / 3-seed formal training has been
launched.** Say **"begin"** to launch formal training (exact commands in §4).

System under test = frozen DINOv3 ViT-L/16 + LoRA r2 + ArcFace/LogitAdjust + SupCon
+ MIRO + EMA + **DAS** (physics carrier aug) + **ACR** (residual + continuous-log-carrier
GRL). Protocol = 100 ep, final-EMA, full-418 77GHz, 3 seeds (42/1234/31415), no
target/source-val selection. Reported metric = **EMA weights at the final epoch
(ep100)** on full-418, via `aggregate_ablation_finalema.py` reading
`epoch_ckpts/ep100.pt` (guaranteed by `DUMP_EPOCH_CKPTS=1`) or `pool_ep100_ema.pt`.

---

## 1. Code changes (env-gated, defaults reproduce current behaviour byte-identically)
Backups of every edited file are at `<file>.bak`; full unified diff in
[`CODE_CHANGES.diff`](CODE_CHANGES.diff). All files `py_compile`-clean.

| File | Change | Default-OFF reproduces? |
|---|---|---|
| `baseline_v20/config.py` | `USE_HFT`/`USE_SPEC_AUGMENT` now env-gated (`V921_USE_HFT`/`V921_USE_SPEC_AUGMENT`, default `"1"`) | yes — both `True` by default |
| `baseline_v20/config.py` | added `V13_GRL_DISCRETE` (default `"0"`) and `V13_GRL_BINS` (default `3`) | yes — discrete OFF |
| `baseline_v20/v9_2_1lib.py` | `CarrierAdversary` gains `out_dim` (default `1`); added `das_log_carrier_range()` helper | yes — `out_dim=1` ⇒ identical layer shapes/init, so continuous mode is byte-identical |
| `EXPERIMENTSRESULT/v15_v18_common_train.py` | discrete GRL branch: build `out_dim=bins`, bin `log f_eff` over the DAS log-carrier range, train K-way head with **cross-entropy** through the *same* `grad_reverse(z_cls, λ)` / `V13_GRL_WEIGHT`; logs bin edges; added one inert `aug_flags:` provenance log line | yes — when `V13_GRL_DISCRETE=0` the loss path is the original `smooth_l1_loss(adv_out.squeeze(-1), log_f_eff)` |
| `baseline_v20/aggregate_ablation_finalema.py` | added `SUPP_CONFIGS` + `resolve_ckpt()` (pool→epoch_ckpts fallback) + `AGG_INCLUDE_SUPP` env switch + missing-seed skip + key-guarded summary | yes — default run (no `AGG_INCLUDE_SUPP`) is unchanged; resolver finds `pool_ep100_ema.pt` for all anchors |

**Discrete adversary bin edges (documented).** `log f_eff = log f_src + r` (= `log f_virt`)
is bucketed into `V13_GRL_BINS` equal-width bins over the DAS log-carrier range
(union of curriculum stage bands = **[10, 95] GHz**). For `BINS=3` the edges are
**[10.0, 21.18, 44.86, 95.0] GHz** (logged at trainer setup). `fixed_full`→[15,140],
`fixed_narrow`→[10,30]. Source-band carriers (no-DAS samples) fall inside the range.

---

## 2. New configs (7 train types) — all map to the intended knobs (dry-run verified)
Base recipe for every new run (`scripts/_base_env.sh`): `SOURCE_QUALIFIED_MIN_F1=0.0
POOL_THRESHOLD=0.90 POOL_PERIOD=10 V921_FAST_GPU=1 V921_SKIP_ORACLE=1
V921_SKIP_LAST_CKPT=1 V921_NUM_WORKERS=0 V921_SOURCE_BATCH_SIZE=16 V921_USE_DAS=1
V921_DAS_MODE=curriculum V921_USE_DANN=0 V13_FREQ_WEIGHT=0.05 V13_DECORR_WEIGHT=0
V13_GRL_WEIGHT=0.3 V13_GRL_TARGET=shown V15_*=0 DUMP_EPOCH_CKPTS=1`
(plus `SOURCE_QUALIFIED_METRIC=acc` to match the anchors).

| # | Config | Phase | Override vs base |
|---|---|---|---|
| 1 | `ACR_Lfreq_only` | P0-A | `V13_GRL_WEIGHT=0` (residual branch only) |
| 2 | `ACR_GRL_only` | P0-A | `V13_FREQ_WEIGHT=0` (GRL only) |
| 3 | `ACR_discrete` | P0-A | `V13_GRL_DISCRETE=1 V13_GRL_BINS=3` (full ACR, discrete adversary) |
| 4 | `DAS_ERM` | P0-B | `V921_USE_DAS=0 V921_USE_HFT=0 V921_USE_SPEC_AUGMENT=0 V13_FREQ_WEIGHT=0 V13_GRL_WEIGHT=0` |
| 5 | `DAS_stretch_only` | P0-B | `V921_USE_HFT=0 V921_USE_SPEC_AUGMENT=0 V13_FREQ_WEIGHT=0 V13_GRL_WEIGHT=0` |
| 6 | `SCHED_fixedfull_ACR` | P1 | `V921_DAS_MODE=fixed_full` (full ACR) |
| 7 | `SCHED_fixednarrow_ACR` | P1 | `V921_DAS_MODE=fixed_narrow` (full ACR) |

Already on disk (do NOT retrain): `A_REF` (DAS only = P0-B "full DAS" + P0-A "DAS only"),
`A_V13_GRL` (DAS+full-ACR), `E1_noDAS` (P0-B "radar-aug only"), `E1_jitter`, `E2_full`,
`E2_narrow` (the no-ACR schedule rows).

---

## 3. Smoke-test results — **ALL 7 PASS** (1 seed=42, 6 epochs, throwaway dirs, since deleted)
Each: started+finished exit 0, no NaN/error/traceback, EMA eval ran at ep≥5,
`epoch_ckpts/ep006.pt` produced, and the [CODE] path verified from the log.

| Config | exit | EMA eval @ep5/6 | ckpt | [CODE]-path validating log line |
|---|---|---|---|---|
| `ACR_Lfreq_only` | 0 | ✓ (val_ema 0.204) | ✓ | `trainable=…+v13_residual_split` (no GRL head) |
| `ACR_GRL_only` | 0 | ✓ (val_ema 0.191) | ✓ | `…+v13_grl_carrier_adv`; continuous `grl=2.05→1.58` (SmoothL1) |
| `ACR_discrete` | 0 | ✓ (val_ema 0.216) | ✓ | `V13_GRL_DISCRETE=1 bins=3 CE-on-carrier-bin … bin edges (GHz)=[10.0, 21.18, 44.86, 95.0]`; CE `grl=1.006→0.659` (≈ln3 init, decreasing); `…+v13_residual_split+v13_grl_carrier_adv` |
| `DAS_ERM` | 0 | ✓ (val_ema 0.222) | ✓ | `aug_flags: USE_HFT=False USE_SPEC_AUGMENT=False`; `use_das=False` |
| `DAS_stretch_only` | 0 | ✓ (val_ema 0.216) | ✓ | `aug_flags: USE_HFT=False USE_SPEC_AUGMENT=False`; `use_das=True das_mode=curriculum` |
| `SCHED_fixedfull_ACR` | 0 | ✓ (val_ema 0.191) | ✓ | `das_mode=fixed_full initial_stage={…f_low:15.0, f_high:140.0, p:1.0}` |
| `SCHED_fixednarrow_ACR` | 0 | ✓ (val_ema 0.213) | ✓ | `das_mode=fixed_narrow initial_stage={…f_low:10.0, f_high:30.0, p:1.0}` |

Param counts confirm the wiring: continuous adversary (`out_dim=1`) = 2,444,546 trainable;
discrete (`out_dim=3`) = 2,444,804 (Δ=258 = 2×(128+1)); residual-only = 2,378,753.
**Note:** the ep6 `test77_diag_ema≈0.035` values are meaningless (EMA only started at ep5,
not warmed up) — they are NOT results, only proof the eval path runs.

---

## 4. ▶ EXACT formal-launch commands (run only after "begin")
All 7 configs × 3 seeds (42/1234/31415) × 100 ep, sequential on the single RTX 5090
(same box/env as the anchors → deltas internally consistent; harness reproduces the
anchors exactly, see §6):

```bash
cd "G:/zhanghe/Letter journal"
bash EXPERIMENTSRESULT/REVISION_5090/SUPP_ABLATION/scripts/run_all_formal.sh \
  > EXPERIMENTSRESULT/REVISION_5090/SUPP_ABLATION/formal_all.log 2>&1
# (launch via the Bash tool with run_in_background=true)
```
Output → `EXPERIMENTSRESULT/REVISION_5090/SUPP_ABLATION/<config>/seed<seed>/`
(`epoch_ckpts/ep100.pt` is the reported final-EMA; ~7 MB trainable-only EMA each).

Per-config (to run a subset or distribute across machines) — each does 3 seeds:
```bash
bash EXPERIMENTSRESULT/REVISION_5090/SUPP_ABLATION/scripts/run_ACR_Lfreq_only.sh
bash …/run_ACR_GRL_only.sh   …/run_ACR_discrete.sh   …/run_DAS_ERM.sh
bash …/run_DAS_stretch_only.sh   …/run_SCHED_fixedfull_ACR.sh   …/run_SCHED_fixednarrow_ACR.sh
```
Override seeds/epochs/output via env, e.g. `SEEDS="42" EPOCHS="100" bash …/run_ACR_discrete.sh`.

### Estimated wall-clock
Smoke = 6 ep ≈ 9.9 s/ep + ~15 s setup. Formal 100 ep ≈ **~17–18 min/run**
(matches the plan's ~18 min/run). **7 configs × 3 seeds = 21 runs ≈ 6.0–6.3 h**
sequential on one 5090. (Minimum-viable subset = 4 configs ×3 = 12 runs ≈ 3.5–3.6 h:
configs 1,2,3,5 — the schedule P1 rows 6,7 can move to supplement.)

---

## 5. Eval / aggregation commands (produce the final tables)
After the formal runs finish (all from project root `G:/zhanghe/Letter journal`):

```bash
PY="C:/Users/Zirui Lin/anaconda3/envs/Lider_5090/python.exe"
# (a) Core ablation table — anchors + SUPP rows, final-EMA, full-418, 3 seeds.
#     Writes EXPERIMENTSRESULT/CKPT_SELECTION_DIAG/ablation_finalEMA_3seed.{json,md}
#     and prints the eval-harness cross-check (max |diff| vs history.json must be ~0).
AGG_INCLUDE_SUPP=1 "$PY" baseline_v20/aggregate_ablation_finalema.py
# (b) P0-C ensemble fairness (eval-only). -> SUPP_ABLATION/eval_out/ensemble_rules.{md,json}
"$PY" baseline_v20/ensemble_rules.py
# (c) P1 paired stratified bootstrap 95% CI (eval-only, reuses (b)'s logits cache).
#     -> SUPP_ABLATION/eval_out/paired_bootstrap_ci.{md,json}
"$PY" baseline_v20/paired_bootstrap_ci.py
```
`(b)` and `(c)` use only existing checkpoints, so they can run now (already validated, §6).
For the "Proposed − best external baseline" bootstrap delta, drop the baseline's per-clip
argmax preds (aligned to the 418 manifest order) at `eval_out/ext_baseline_preds.npy`.

---

## 6. Preliminary eval-only results (existing checkpoints — VALIDATES the harness)
Labelled **PRELIMINARY**; these reuse the A_REF/A_V13_GRL/E1_jitter anchors (no training).
The single-model numbers reproduce the published anchors **exactly**, validating the eval path:

P0-C ensemble rules (full-418 macro-F1) — `eval_out/ensemble_rules.md`:
| Config | Single (mean±std) | Ens majority | Ens logit-avg | Ens posterior |
|---|---|---|---|---|
| DAS only (A_REF) | 0.767 ± 0.076 | 0.817 | 0.827 | 0.822 |
| DAS+ACR (A_V13_GRL) | 0.832 ± 0.034 | 0.851 | 0.857 | 0.856 |
| DAS jitter (E1_jitter) | 0.518 ± 0.030 | 0.537 | 0.537 | 0.543 |

→ single matches anchors (0.767±0.076 / 0.832±0.034 / 0.518); all three ensemble rules land
together (~0.851–0.857), and DAS-only also gains ~+5 pp from ensembling ⇒ the ensemble gain
is not ACR-specific and posterior-avg is not a target-tuned trick.

P1 paired stratified bootstrap, B=10000, 95% CI — `eval_out/paired_bootstrap_ci.md`:
| Delta (macro-F1) | Observed | 95% CI | P(Δ>0) |
|---|---|---|---|
| DAS+ACR single − DAS single | +6.55 pp | [+4.69, +8.37] | 1.000 |
| DAS single − jitter single | +24.90 pp | [+21.47, +28.32] | 1.000 |
| DAS+ACR ensemble − DAS+ACR single | +2.40 pp | [+0.89, +3.96] | 0.999 |

---

## 7. Hard-rule compliance
- ✅ No formal 100-ep/3-seed training launched. Smoke = 6 ep, single seed, throwaway dirs (deleted).
- ✅ All code env-gated; defaults reproduce current behaviour; every edited file backed up `*.bak`; `py_compile` clean.
- ✅ No fabricated metrics — every number here is copied from actual tool output.
- ✅ Eval-harness cross-check: single-model anchors reproduced exactly (0.832 etc.); aggregate's
  278-subset cross-check (`max |diff| vs history.json`) will be re-confirmed ~0 on the formal run.
- ✅ All runs in the same `Lider_5090` env as the anchors (no machine mixing).
