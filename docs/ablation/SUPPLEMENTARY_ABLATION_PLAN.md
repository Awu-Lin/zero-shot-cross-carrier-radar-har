# Supplementary Ablation Plan (SPL submission)
_Goal: NOT more scattered experiments — the 4–6 ablations a reviewer WILL ask, that rule
out alternative explanations for our two contributions (DAS, ACR) + the ensemble fairness.
SPL = Letter: ≤4 pages technical + 1 page refs + supplementary allowed._

System under test (verified): frozen DINOv3 ViT-L/16 + LoRA r2 + ArcFace/LogitAdjust +
SupCon + MIRO + EMA + **DAS** (physics carrier aug) + **ACR** (adversarial carrier-residual
GRL). Protocol = 100 ep, final-EMA, full-418 77GHz, 3 seeds (42/1234/31415), no target/
source-val selection. Anchors: A_REF(DAS only)=0.767±0.076, A_V13_GRL(DAS+ACR)=0.832±0.034,
ensemble=0.857/0.859, E1_noDAS=0.302.

> **KEY CORRECTION (affects accounting).** `USE_HFT` and `USE_SPEC_AUGMENT` gate HFT/
> SpecAugment independently of DAS (both default ON). So **E1_noDAS (0.302) = "radar-aug
> only (HFT+SpecAug), NO Doppler stretch"**, NOT true ERM. It already serves as the P0-B
> "radar aug only" row. A *true* ERM (no DAS, no HFT, no SpecAug) and a *stretch-only*
> (DAS, no HFT/SpecAug) are the genuinely-new rows.

Status legend: **[HAVE]** = checkpoints on disk, eval-only; **[TRAIN]** = new 100-ep×3-seed
run; **[EVAL]** = no training, reuse existing predictions; **[CODE]** = needs a small,
env-gated code change first.

---

## P0-A — ACR internal mechanism (the most-missing ablation)
Fix backbone / DAS / optimizer / seeds / selection; vary ONLY the ACR sub-parts. Our
contribution is "adversarial carrier-residual head" = z_freq **residual regression** +
z_cls **continuous-log-carrier GRL**; both must be separated.

| Row | Knobs | Status |
|---|---|---|
| DAS only | `V13_FREQ_WEIGHT=0 V13_GRL_WEIGHT=0` (=A_REF) | **[HAVE]** 0.767 |
| DAS + L_freq only (no GRL) | `V13_FREQ_WEIGHT=0.05 V13_GRL_WEIGHT=0` | **[TRAIN]** |
| DAS + GRL only (no residual branch) | `V13_FREQ_WEIGHT=0 V13_GRL_WEIGHT=0.3` | **[TRAIN]** |
| DAS + discrete carrier adversary | GRL as a 10/24/virtual-**bin classifier** (vs our continuous log-carrier regressor) | **[TRAIN] [CODE]** |
| DAS + full ACR | `V13_FREQ_WEIGHT=0.05 V13_GRL_WEIGHT=0.3` (=A_V13_GRL) | **[HAVE]** 0.832 |

CODE: add a discrete variant to `CarrierAdversary` (Linear→hidden→**K-way logits**, CE on a
carrier bin index instead of SmoothL1 on `log f_eff`); env knob e.g. `V13_GRL_DISCRETE=1`,
`V13_GRL_BINS`. → **3 new train configs (×3 seeds = 9 runs)**.

## P0-B — DAS body: separate Doppler-stretch from HFT/SpecAugment
Core claim is "micro-Doppler scales with carrier → Doppler-axis stretch works", so stretch
must contribute independently of generic radar augmentation.

| Row | Knobs | Status |
|---|---|---|
| ERM (truly no aug) | `V921_USE_DAS=0 V921_USE_HFT=0 V921_USE_SPEC_AUGMENT=0` | **[TRAIN] [CODE]** |
| radar-aug only (HFT+SpecAug, no stretch) | `V921_USE_DAS=0` (HFT/SpecAug on) = E1_noDAS | **[HAVE]** 0.302 |
| Doppler-stretch only (no HFT/SpecAug) | `V921_USE_DAS=1 V921_USE_HFT=0 V921_USE_SPEC_AUGMENT=0` | **[TRAIN] [CODE]** |
| full DAS (stretch+radar aug) | `V921_USE_DAS=1` (=A_REF) | **[HAVE]** 0.767 |
| jitter + same HFT/SpecAug | `V921_DAS_MODE=jitter` (=E1_jitter) | **[HAVE]** 0.518 |

CODE: env-gate the two currently-hardcoded flags in `baseline_v20/config.py`
(`USE_HFT = os.environ.get("V921_USE_HFT","1")=="1"`, same for `USE_SPEC_AUGMENT`).
→ **2 new train configs (×3 = 6 runs)**. (Already supported: full DAS 0.767 ≫ radar-aug-only
0.302 = +46.5 pp already shows stretch ≫ radar aug; the 2 new rows pin the floor and isolate
stretch-alone.)

## P0-C — Ensemble fairness (no training)
| Row | How | Status |
|---|---|---|
| DAS-only single | A_REF mean | **[HAVE]** 0.767 |
| DAS-only 3-seed posterior ensemble | average A_REF's 3 seeds | **[EVAL]** |
| DAS+ACR single | A_V13_GRL mean | **[HAVE]** 0.832 |
| DAS+ACR 3-seed ensemble | average A_V13_GRL's 3 seeds | **[HAVE]** 0.857 |
| DAS+ACR ensemble rules (majority / logit-avg / posterior-avg) | 3 rules on A_V13_GRL | **[EVAL]** |
Shows the +2.5 pp is not ACR-specific magic, and posterior-avg is not a target-tuned trick.
→ **eval-only, run locally.**

---

## P1 — schedule ablation UNDER ACR (resolves the fixed-narrow contradiction)
Current schedule table (no ACR) has fixed-narrow 0.804 > curriculum 0.767 → "trades mean vs
variance" is weak. Re-run the schedule WITH ACR on.

| Row | Knobs | Status |
|---|---|---|
| curriculum + ACR | `V921_DAS_MODE=curriculum` + ACR (=A_V13_GRL) | **[HAVE]** 0.832 |
| fixed-full + ACR | `V921_DAS_MODE=fixed_full` + ACR | **[TRAIN]** |
| fixed-narrow + ACR | `V921_DAS_MODE=fixed_narrow` + ACR | **[TRAIN]** |
| no-curriculum same-final-band + ACR | `V921_DAS_MODE=fixed_full` (matches stage-3 band) + ACR | **[TRAIN]** |
→ **3 new train configs (×3 = 9 runs)**, no code. If curriculum wins under ACR, keep a 1-line
claim; else move schedule to supplement (option B).

## P1 — statistical stability (no training)
Paired stratified bootstrap (95% CI over the 418 target clips) for the deltas that carry the
story: DAS+ACR single − DAS only; DAS − jitter; ensemble − single; Proposed − best external
baseline. Needs only saved per-clip predictions. → **[EVAL]**, local.

## P1 — external / domain baselines (NOT ablation, but decisive)
See PUBLIC_BASELINE_DESIGN.md (separate). Generic backbones + DANN/CORAL/MMD + radar-specific
(RadMamba/SelaFD) + DINOv3-LoRA control. Bulk is the public-baseline effort.

## P2 — only if claimed important (supplement)
SupCon / MIRO / ArcFace-LA / LoRA-rank small ablations; full per-class / confusion / probe
tables; full-FT capacity collapse (0.481, already have). All supplement.

---

## Minimum viable submission (the 6 rows + CI)
| # | Row | Status | Runs |
|---|---|---|---|
| 1 | DAS + L_freq only | [TRAIN] | 3 |
| 2 | DAS + GRL only | [TRAIN] | 3 |
| 3 | DAS + discrete carrier adversary | [TRAIN][CODE] | 3 |
| 4 | radar-aug only, no stretch | **[HAVE]** (=E1_noDAS) | 0 |
| 5 | Doppler-stretch only, no HFT/SpecAug | [TRAIN][CODE] | 3 |
| 6 | DAS-only 3-seed posterior ensemble | [EVAL] | 0 |
| + | paired bootstrap CI | [EVAL] | 0 |

**Minimum NEW training = 4 configs × 3 seeds = 12 runs (~11 s/ep × 100 ep ≈ 18 min/run ≈
3.6 h on one GPU; the 3×3080 remote can run 3 in parallel ≈ 1.2–1.5 h).** Plus 2 tiny code
gates (HFT/SpecAug env flags) + 1 small code add (discrete adversary).
Full P0+P1 training (incl. schedule) = ~24 runs ≈ 7 h on one GPU.

---

## Paper layout (SPL: 1 method figure + 2 main tables + 1 small diagnostic)
- **Fig 1**: compact pipeline — spectrogram → DAS stretch (ρ=f_v/f_s) → frozen DINO+LoRA →
  z_cls/z_freq → ArcFace HAR + ACR (residual + GRL) → 77 GHz zero-shot. Draw only DAS + ACR.
- **Table I** (main result + external baselines): ERM / radar-aug / jitter / DANN / best
  external / DAS only / DAS+ACR single / DAS+ACR ensemble. Columns: Physics? Adversarial?
  Ensemble? Macro-F1, Acc.
- **Table II** (core ablation, ≤8 rows): ERM → radar-aug-only → stretch-only → full DAS →
  +L_freq only → +GRL only → +discrete adversary → +full ACR.
- **Table III / Fig 2** (tiny): hardest-class improvement (Sit .46→.72→.76, Bend, Towards).
- **Main text says "single 0.832; 3-seed ensemble further 0.857"** — single is the headline,
  ensemble is a deployment variant. Reframe "gap-aware" → "3-seed posterior averaging".
- **Do NOT put in main text**: "rejected", V15/falsification/decorrelation variants, sensor-
  head-inert, the no-ACR schedule table, full per-class/confusion. → supplement.

## Supplement: full method spec; all historical variants (decorr/falsify/rejected); schedule;
LoRA-vs-full-FT capacity collapse; SupCon/MIRO/ArcFace; HFT/SpecAug split; ensemble rules;
per-class/confusion/probe diagnostics; reproducibility (splits, carriers, 418 test, seeds,
metric, selection rule, hyperparams, hardware, no-target-leakage, bootstrap setup).

---

## Remote-SSH data transfer (minimum)
To run the [TRAIN] experiments on a remote box you need ONLY:

| Item | Path | Size |
|---|---|---|
| Dataset images (10/24 train+val, 77 test) | `tasks/known_people_unknown_freq/dataset/` | **97 MB** |
| Manifests | `tasks/known_people_unknown_freq/manifest/` | 0.46 MB |
| Code (full import chain) | `baseline_v20/` + `baseline_v9/v9lib.py` + `baseline_v8/v8lib.py` + `EXPERIMENTSRESULT/{v15_v18_common_train.py, pool_protocol.py}` | **< 1 MB** |
| DINOv3 ViT-L/16 weights | HF cache `models--timm--vit_large_patch16_dinov3.lvd1689m` | **1.2 GB** — *only if the remote has no internet* |

- **Remote HAS internet → transfer ≈ 98 MB** (timm auto-downloads the backbone; the
  timm-hosted DINOv3 weights are not gated).
- **Air-gapped remote → ≈ 1.3 GB** (add the 1.2 GB backbone cache).
- NOT needed on the remote: existing checkpoints (the [EVAL] ensemble/bootstrap runs use LOCAL
  checkpoints), the conda env (recreate it: torch ≥2.x + timm), any output/ folders.
- New checkpoints come back at **7.2 MB each** (trainable-only EMA) → ~90 MB for all 12 runs.
- Env note: recreate the GPU env on the remote (torch + timm + numpy/pandas/PIL). GPU-DAS uses
  `grid_sample` → absolute numbers can drift slightly across envs; keep ALL remote runs in the
  same env so the ablation deltas stay internally consistent, and re-anchor one known config
  (A_REF or A_V13_GRL) on the remote before trusting absolute values.
