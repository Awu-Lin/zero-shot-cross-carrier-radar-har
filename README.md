# Zero-Shot Cross-Carrier Transfer for Radar Micro-Doppler Human Activity Recognition

Code, data, training logs, final-EMA checkpoints, and result tables for the paper

> Z. Lin, H. Zhang, Z. Liu, L. Bai, and G. Xiao, "Zero-Shot Cross-Carrier Transfer for Radar
> Micro-Doppler Human Activity Recognition," submitted to *IEEE Signal Processing Letters*, 2026.
> PDF: [`paper/Lin2026_ZeroShot_CrossCarrier_SPL.pdf`](paper/Lin2026_ZeroShot_CrossCarrier_SPL.pdf)

**Task.** Seven-class human activity recognition from radar micro-Doppler spectrograms. Train on
10 GHz + 24 GHz recordings, test **zero-shot on an unseen 77 GHz sensor** (418 clips). The 77 GHz
data is never used for training, hyperparameter tuning, or checkpoint selection.

**Method.** Frozen DINOv3 ViT-L/16 + rank-2 LoRA, plus two contributions:
**DAS** (Doppler-axis stretch: physics-driven virtual-carrier rendering on a widening curriculum)
and **ACR** (adversarial carrier-residual head: residual carrier branch + gradient-reversal
adversary on the continuous log-carrier). The adversary is discarded at inference.

**Protocol.** 100 epochs, the EMA weights of the **final** epoch are reported for every method
(no early stopping, no source-validation gate, no target peeking), three seeds (42 / 1234 / 31415),
metric = macro-F1 on the full 418-clip 77 GHz test set.

| Headline (paper Table I) | macro-F1 | acc. | gap |
|---|---|---|---|
| Best baseline (DINOv3-L + LoRA, no DAS/ACR) | 0.302 ± 0.031 | 0.413 | +0.668 |
| **Proposed single model (DAS + ACR)** | **0.832 ± 0.034** | 0.836 | +0.135 |
| Proposed, 3-seed posterior ensemble (deployment variant) | 0.856 | 0.859 | --- |

---

## 1. Quick start: recompute the paper numbers (no training, a few minutes)

```bash
git clone https://github.com/Awu-Lin/zero-shot-cross-carrier-radar-har.git
cd zero-shot-cross-carrier-radar-har

conda create -n xcarrier python=3.10 -y && conda activate xcarrier
# 1) PyTorch for your GPU (the pinned cu128 build is what the paper used, RTX 5090 / sm_120;
#    any torch >= 2.1 with a matching CUDA build works on older GPUs)
pip install torch==2.11.0 torchvision==0.26.0 --index-url https://download.pytorch.org/whl/cu128
# 2) everything else
pip install -r requirements.txt

python reproduce.py
```

Windows note: run `git config --global core.longpaths true` before cloning, or clone into a short path such as `C:\work\`, because some run-record paths exceed the default 260-character limit when the clone location itself is long.

`reproduce.py` runs four eval-only steps over the shipped checkpoints (see Section 3 for what
each step recomputes). On the first run `timm` downloads the DINOv3 backbone
`vit_large_patch16_dinov3.lvd1689m` (~1.2 GB, not gated) into `./weights/hub`; every later run
is offline. GPU memory needed: about 6-8 GB.

Expected console output (abridged; the full reference transcript of this exact command is in
[`docs/reproduction_2026-09-04/`](docs/reproduction_2026-09-04/)):

```
# step (a): Table II rows recomputable from checkpoints
| V13-as-GRL (shown w0.3)  | 0.836 ± 0.032 | 0.832 ± 0.034 |   <- proposed (DAS + full ACR)
| ACR L_freq only          | 0.819 ± 0.021 | 0.814 ± 0.021 |
| ACR GRL only             | 0.832 ± 0.016 | 0.826 ± 0.016 |
| ACR discrete adversary   | 0.802 ± 0.032 | 0.796 ± 0.034 |
| DAS ERM (no aug)         | 0.271 ± 0.029 | 0.146 ± 0.034 |
| DAS stretch only         | 0.727 ± 0.075 | 0.704 ± 0.089 |
| DAS fixed-full + ACR     | 0.640 ± 0.067 | 0.626 ± 0.058 |
| DAS fixed-narrow + ACR   | 0.822 ± 0.038 | 0.800 ± 0.057 |
max |diff| vs history.json = 0.0000

# step (b): Table I rows 10-11
DAS+ACR (A_V13_GRL)  single=0.8322+/-0.0337  maj=0.8512  logit-avg=0.8566  posterior=0.8562

# step (c): paired class-stratified bootstrap (B = 10 000, N = 418)
DAS+ACR ensemble - DAS+ACR single   obs=+2.40pp  95%CI=[+0.86,+3.98]pp  P(>0)=0.999
continuous - discrete (full ACR):   observed = +3.57 pp  95% CI = [+1.91, +5.31] pp  P(>0) = 1.000

# step (d): unified public-baseline harness
#10 proposed  f1=0.8322+/-0.0337 acc=0.8357 src_f1=0.9670 gap=+0.1348 ci95=[0.751,0.826] params=1.85M seeds=[0.791, 0.8322, 0.8735]
#11 ensemble  f1=0.8562 acc=0.8589 ci95=[0.821,0.889]
[xcheck] proposed-family 278 vs history max|diff| = 0.0000
```

The `max |diff| = 0.0000` lines are the harness self-check: the macro-F1 recomputed now from each
checkpoint equals, to four decimals, the value the trainer logged in that run's `history.json`
at epoch 100. Bootstrap CI end-points can move by a few hundredths of a pp between machines
(GPU non-determinism in the logits); the observed deltas do not.

---

## 2. Repository layout

```
.
├── README.md, LICENSE, CITATION.cff, requirements.txt
├── reproduce.py                     one-command reproduction (Section 1)
├── paper/                           submitted PDF + Fig. 1 source
├── tasks/known_people_unknown_freq/ the dataset actually used (1 930 spectrograms, 224x224, jet)
│   ├── manifest/{train,val,test}.csv   deterministic split (10/24 GHz -> train/val; 77 GHz -> test)
│   └── dataset/{train,val,test}/<band>/<class>/*.png
├── baseline_v20/                    method + evaluation code
│   ├── config.py                        every switch of the method (env-var driven, see Section 4)
│   ├── v9_2_1lib.py                     DAS operator, ACR head, LoRA/ArcFace/SupCon/MIRO model
│   ├── train.py                         training entry point (final-EMA protocol)
│   ├── aggregate_ablation_finalema.py   step (a)   ensemble_rules.py       step (b)
│   ├── paired_bootstrap_ci.py           step (c)   bootstrap_discrete.py   step (c)
│   └── (other *.py: development-time analysis / feasibility scripts, not needed for the paper)
├── baseline_v9/v9lib.py, baseline_v8/v8lib.py, pool_protocol.py   lower-level libraries
├── EXPERIMENTSRESULT/
│   ├── v15_v18_common_train.py      shared training loop
│   └── REVISION_5090/
│       ├── A_V13_GRL/seed{42,1234,31415}/          PROPOSED: checkpoints/pool_ep100_ema.pt (final-EMA),
│       │                                            reports/history.json, manifests/, train.log
│       ├── A_V13_GRL/run_scripts/                   the scripts that trained it
│       ├── SUPP_ABLATION/<config>/seed*/            7 ablation configs x 3 seeds: epoch_ckpts/ep100.pt,
│       │                                            reports/history.json, manifests/, train.log
│       ├── SUPP_ABLATION/scripts/                   their launch scripts (run_all_formal.sh)
│       └── public_baseline/                         Table I rows 1-9: harness, recipes, runs_strong/ histories
├── logs/REVISION_5090/              train.log of every other run referenced by the paper (Section 3.2)
└── docs/
    ├── reproduction_2026-09-04/     reference outputs of `python reproduce.py` on the authors' machine
    ├── ablation/                    archived ablation tables, plan, code diff, bootstrap reports
    ├── public_baseline/             baseline protocol, per-class tables, design notes
    ├── proposed/                    method reports (GRL/ACR analysis, mechanism findings)
    ├── DATA_SOURCES.md              dataset composition and provenance
    └── PACKAGE_AUDIT_REPORT.md      integrity audit of the archived package this repo was built from
```

Paths inside the code are resolved relative to each file's location, so the tree above must be
kept intact (do not move `tasks/`, `weights/`, or `EXPERIMENTSRESULT/` individually).

---

## 3. What can and cannot be recomputed here

### 3.1 Recomputed exactly from shipped checkpoints (`python reproduce.py`)

| Paper number | Where | Checkpoints | Script |
|---|---|---|---|
| Proposed 0.832 ± 0.034, acc 0.836, gap +0.135, per-seed 0.791/0.832/0.874 | Tab. I #10, Tab. II last row, Sec. III | `A_V13_GRL/seed*/checkpoints/pool_ep100_ema.pt` | (a), (b), (d) |
| Ensemble 0.856 (posterior), 0.851 (majority), 0.857 (logit), CI [0.821, 0.889] | Tab. I #11, Sec. III-C | same | (b), (d) |
| Ensemble − single +2.40 pp, P = 0.999 | Sec. III-C | same | (c) |
| ACR residual only 0.814, GRL only 0.826, discrete-bin 0.796 | Tab. II | `SUPP_ABLATION/ACR_*/seed*/epoch_ckpts/ep100.pt` | (a) |
| Continuous − discrete +3.57 pp, CI [+1.91, +5.31] | Sec. III-C | same | (c) |
| ERM 0.146, Doppler-stretch only 0.704 | Tab. II | `SUPP_ABLATION/DAS_*/` | (a) |
| Fixed-narrow + ACR 0.800, fixed-full + ACR 0.626 | Sec. III-C | `SUPP_ABLATION/SCHED_*/` | (a) |

### 3.2 Reported from archived run records (checkpoints no longer available)

The final-EMA checkpoints of four ablation runs and of the nine public baselines were deleted
from the training machine before this release was assembled and cannot be regenerated except by
retraining (Section 4). For these rows the repository ships the evidence that exists:

| Paper number | Where | Evidence in this repo |
|---|---|---|
| Full DAS 0.767 ± 0.076 (`A_REF`) | Tab. II, Intro | `logs/REVISION_5090/A_REF/seed*/train.log`; archived table `docs/ablation/ablation_finalEMA_3seed.md` (row "- both modules (DAS only)") |
| Radar aug. only 0.302 ± 0.031 (`E1_noDAS`, = Tab. I #9) | Tab. I, Tab. II | `logs/REVISION_5090/E1_noDAS/`; same table, row "- DAS (pure base)"; `docs/public_baseline/pb_results_strong_auto.md` #9 |
| Physics-free jitter 0.518 ± 0.030 (`E1_jitter`) | Tab. II | `logs/REVISION_5090/E1_jitter/`; same table |
| DANN control 0.275 ± 0.024 (`E1_DANN`) | Tab. II, Intro | `logs/REVISION_5090/E1_DANN/`; same table |
| DAS+ACR − DAS +6.55 pp [+4.69, +8.37]; DAS − jitter +24.90 pp [+21.47, +28.32] | Sec. III-C | `docs/ablation/paired_bootstrap_ci.md` (computed when `A_REF`/`E1_jitter` checkpoints existed) |
| Full fine-tune collapse 0.481 ± 0.075 | Sec. III-C | `logs/REVISION_5090/VITL_FULLFT/`; `docs/proposed/ABLATION_REPORT.md` §7.4 |
| Baselines #1-#8 (VGG16-BN ... SelaFD) | Tab. I | `EXPERIMENTSRESULT/REVISION_5090/public_baseline/runs_strong/<model>/seed*/reports/history.json` (per-epoch record incl. epoch-100 EMA test F1) and `train.log` + `docs/public_baseline/pb_results_strong_auto.md` |

The archived ablation table in `docs/ablation/` was produced by the same `aggregate_ablation_finalema.py`
with its own `max |diff| vs history.json = 0.0000` cross-check, at a time when all checkpoints were present.

---

## 4. Retraining from scratch

Everything is driven by environment variables read in `baseline_v20/config.py`; no code edits are
needed. One run (100 epochs) takes about 18 min on an RTX 5090 and fits in 16 GB of GPU memory.

```bash
# Proposed model (DAS curriculum + full ACR), one seed. Output -> EXPERIMENTSRESULT/REVISION_5090/A_V13_GRL_repro/seed42
export SOURCE_QUALIFIED_METRIC=acc SOURCE_QUALIFIED_MIN_F1=0.0 POOL_THRESHOLD=0.90 POOL_PERIOD=10
export V921_FAST_GPU=1 V921_SKIP_ORACLE=1 V921_SKIP_LAST_CKPT=1 V921_NUM_WORKERS=0 V921_SOURCE_BATCH_SIZE=16
export V921_USE_DAS=1 V921_DAS_MODE=curriculum V921_USE_DANN=0 V921_USE_HFT=1 V921_USE_SPEC_AUGMENT=1
export V13_FREQ_WEIGHT=0.05 V13_DECORR_WEIGHT=0 V13_GRL_WEIGHT=0.3 V13_GRL_TARGET=shown V13_GRL_DISCRETE=0
export V15_KIN_SOURCE_WEIGHT=0 V15_FALSIFY_WEIGHT=0 V15_SENSOR_UNIFORM_WEIGHT=0 V15_CONSIST_WEIGHT=0
export DUMP_EPOCH_CKPTS=1 V921_EXPERIMENT_NAME=A_V13_GRL_repro
python baseline_v20/train.py --epochs 100 --seed 42 --progress simple \
       --run-dir EXPERIMENTSRESULT/REVISION_5090/A_V13_GRL_repro/seed42
```

The exact scripts that produced the shipped runs are included and now resolve paths relative to
the repository (set `PY=<your python>` if it is not on `PATH`):

| Runs | Script |
|---|---|
| Proposed, seeds 1234 / 31415 (seed 42 came from the `GRL_TUNE/w0.3_seed42` sweep, same recipe) | `EXPERIMENTSRESULT/REVISION_5090/A_V13_GRL/run_scripts/run_grl_phase2.sh` |
| All 7 ablation configs x 3 seeds (idempotent, ~6 h) | `EXPERIMENTSRESULT/REVISION_5090/SUPP_ABLATION/scripts/run_all_formal.sh` |
| One ablation config, e.g. discrete adversary | `.../SUPP_ABLATION/scripts/run_ACR_discrete.sh` (each script states only its delta from `_base_env.sh`) |
| Public baselines #1-#8, 3 seeds each, then the unified table | `python EXPERIMENTSRESULT/REVISION_5090/public_baseline/pb_sweep_strong.py` |

Main switches (`baseline_v20/config.py`):

| Variable | Meaning | Paper value |
|---|---|---|
| `V921_USE_DAS` | Doppler-axis stretch on/off | `1` |
| `V921_DAS_MODE` | `curriculum` / `fixed_full` / `fixed_narrow` / `jitter` | `curriculum` |
| `V921_USE_HFT`, `V921_USE_SPEC_AUGMENT` | radar augmentations (HFT, SpecAugment) | `1`, `1` |
| `V13_FREQ_WEIGHT` | ACR residual carrier branch weight (`0` = off) | `0.05` |
| `V13_GRL_WEIGHT` | ACR gradient-reversal adversary weight (`0` = off) | `0.3` |
| `V13_GRL_TARGET` | adversary target: `shown` (= log f_s + rendered residual) / `base` | `shown` |
| `V13_GRL_DISCRETE`, `V13_GRL_BINS` | replace the continuous regressor by a K-bin CE adversary | `0`, (`3` for the control) |
| `V921_USE_DANN` | binary source-band DANN control (weight 0.1) | `0` |

After retraining, rerun the analysis scripts of Section 1 on the new run directories. Because of
GPU non-determinism (`grid_sample`, reduction order) and the small training set (644 images),
retrained single-seed numbers move by roughly ±0.05 macro-F1 per seed; the component deltas are
stable. Use the shipped checkpoints for exact reproduction.

**Public baselines.** RadMamba is run from the vendored `external/AIRHAR` (Apache-2.0, license
included). SelaFD's upstream repository carries no license file, so its code is **not**
redistributed here: to retrain row #8, clone https://github.com/wangyijunlyy/SelaFD into
`EXPERIMENTSRESULT/REVISION_5090/public_baseline/external/SelaFD` (the ImageNet ViT-B/16 initial
weights it needs are built automatically from `timm` by `pb_external.py`). Rows #1-#6 use `timm`
ImageNet weights, downloaded on demand.

---

## 5. Data

`tasks/known_people_unknown_freq/` is the exact data used for every number in the paper:
1 024 train / 253 val / 653 test spectrograms in the manifests (11 activity classes), of which the
seven-class experiment subset is 644 train / 162 source-val (10 + 24 GHz) and 418 test (77 GHz).
The per-run `manifests/` folders record the subset each run saw.

The data combines the public **CI4R cross-frequency dataset** (University of Alabama; co-located
Xethru 10 GHz UWB, Ancortek 24 GHz FMCW, TI 77 GHz FMCW radars,
https://github.com/ci4r/CI4R-Activity-Recognition-datasets) with a **24 GHz supplement recorded
at the National Research Council Canada** (Luswave PUP_EN24C_T2R4 FMCW radar, paired 15 dBi horn
antennas, 1 m mount, subjects at 3 m on boresight, informed consent obtained). The supplement
enriches the 24 GHz source band only; it is never a test set. Composition, subject IDs, and the
provenance caveat that the two sources are not separable per file are documented in
[`docs/DATA_SOURCES.md`](docs/DATA_SOURCES.md). Please cite the CI4R dataset when using this data.

Every test subject also appears in the source bands: the benchmark isolates the **carrier** shift
and is not a cross-subject evaluation.

---

## 6. Notes for reviewers

- **Selection rule.** The reported checkpoint is always the EMA weights at epoch 100
  (`pool_ep100_ema.pt` / `epoch_ckpts/ep100.pt`). The trainer also writes `eval_sourceval.json`
  and `eval_sourcequalified.json` (source-val-selected / target-best diagnostics); those are
  **not** the reported numbers.
- **Parameter count.** Table I lists 1.9 M (1 853 441 trainable parameters on the recognition
  path: LoRA + necks + heads); the ≈2.4 M quoted in the text additionally counts the ACR heads,
  which exist only during training.
- **Ensemble.** The paper reports the posterior-average rule (0.856); the three rules agree to
  within 0.6 pp (Section III-C), and all three are printed by step (b).
- **Mechanism claim.** ACR does not make the feature carrier-unrecognizable to a linear probe
  (`docs/proposed/GRL_RESULTS.md`, Sections 3 and 7); the paper accordingly claims invariance along
  the continuous carrier-scale direction, not probe-level carrier erasure.
- **Code change since the runs.** `baseline_v20/aggregate_ablation_finalema.py` gained one line
  (`out.parent.mkdir(...)`) so it can be run from a fresh clone; no numerical code changed.
  `docs/ablation/CODE_CHANGES.diff` documents the env-gated additions that implemented the ablation
  configs on top of the training library.

---

## 7. License and citation

Code: MIT ([`LICENSE`](LICENSE)). The dataset under `tasks/` is third-party (CI4R, University of
Alabama) plus the NRC supplement and remains governed by their own terms. The DINOv3 backbone is
downloaded from the HuggingFace Hub under Meta's DINOv3 license and is not redistributed here.

If you use this repository, please cite the paper (see [`CITATION.cff`](CITATION.cff)).
