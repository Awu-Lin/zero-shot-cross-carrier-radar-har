# Final Audit Report — Letter Journal Submission Package

Scope: verify everything in this package is real, complete, and reproducible — project code,
dataset, public-baseline content, and the supplementary ablation. Result: **PASS**.

## Recovery note (transparency)
During submission preparation the package's files were accidentally deleted by a faulty cleanup
command, then **fully rebuilt from the intact source repository** `G:\zhanghe\Letter journal`
(which was never touched) plus the documentation regenerated from record. The rebuild also
dropped non-publishable junk that was previously present (`*.bak`, `__pycache__`, `*.pyc`,
`.omc`, `*.pid`), so a few folder counts are slightly lower than before while all real
content is intact. The rebuild was re-verified end-to-end (counts, `py_compile`, checksums).

## 1. Structure (PASS)
6 top-level folders (+ empty `figures/` placeholder) + root docs. Total **2841 files,
~1056 MB**.

| Folder | Files | Size |
|---|---|---|
| 00_data | 1939 | 92.7 MB |
| 01_shared_model_libraries | 50 | 0.4 MB |
| 02_proposed_single_DINOv3_LoRA_DAS_ACR | 97 | 217.6 MB |
| 03_public_baseline | 189 | 331.1 MB |
| 04_all_logs | 147 | 98.5 MB |
| 05_supplementary_ablation | 417 | 316 MB |

## 2. Dataset — 00_data (PASS)
`tasks/known_people_unknown_freq/{manifest, dataset}`; 1930 PNG spectrograms. train.csv = 1024
(10 GHz 481 + 24 GHz 543), val.csv = 253 (10/24 GHz), test.csv = 653 (77 GHz); every manifest
path resolves to a file (0 missing). Source composition (Alabama CI4R + NRC 24 GHz) is in
`00_data/DATA_SOURCES.md`.

## 3. Code chain — 01_shared_model_libraries (PASS)
Full import chain present: `baseline_v20/{config,v9_2_1lib,train,...}.py`, `baseline_v9/v9lib.py`,
`baseline_v8/v8lib.py`, `common/{v15_v18_common_train.py, pool_protocol.py}`. Re-copied verbatim
from the working repository that produced every run. All package `.py` (105 files) `py_compile`
clean.

## 4. Proposed method — 02 (PASS)
3 seeds (42/1234/31415) each complete: `train.log` + `reports/history.json` +
`checkpoints/pool_ep100_ema.pt`. Reported 77 GHz macro-F1 = 0.832 +/- 0.034. Run + analysis
scripts and reports present.

## 5. Public baseline — 03 (PASS)
11-row unified table (`pb_results_strong_auto.md`); `runs_strong/` has all generic/external
backbones x 3 seeds with `history.json`; unified eval code + `pb_results_strong.json` present;
0 trained `.pt` redistributed (only the SelaFD pretrained `.pth` kept, per design).

## 6. Supplementary ablation — 05 (PASS)
21/21 runs complete (7 configs x 3 seeds): `train.log` + full-100-epoch `reports/history.json` +
`epoch_ckpts/ep100.pt`. `analysis_scripts/`, `run_scripts/`, `modified_core_code/` (+ diff) each
with Introduction headers; `exact_result_reports/` (main table + ensemble + bootstrap +
continuous-vs-discrete + plan + interpretation) and `orchestration_logs/` present.
`INTRODUCTION.md` + `REPRODUCE.md` give the two-mode reproduction recipe. Eval-harness
cross-check `max |diff| vs history.json = 0.0000`.

## 7. Integrity (PASS)
`CHECKSUMS_SHA256.txt` = 83 entries (proposed 3-seed + public-baseline tables + 21 ablation runs
+ ablation result tables + bootstrap script). **All 83 recomputed and verified: 0 mismatch,
0 missing.**

## 8. Language (PASS, per instruction)
All package navigation docs, reports, and code Introduction headers are English. The only
remaining non-English text is in two vendored third-party files
(`03_.../external/SelaFD/{plot_attention.py, utils/dataloader_har.py}`) whose original-author
comments are kept by instruction; `ABLATION_REPORT.md` contains the math symbol "double-struck F"
(scientific notation), not Chinese. Scientific notation (±, ∝, μ, σ, ×, 𝔽) is retained.

**Conclusion:** the package is real, complete, and reproducible. Use
`05_supplementary_ablation/REPRODUCE.md` Mode A to regenerate the tables exactly from the
included checkpoints.
