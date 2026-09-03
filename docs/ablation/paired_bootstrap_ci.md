# P1 paired stratified bootstrap 95% CI (PRELIMINARY -- eval-only)

N=418 target clips, B=10000 resamples, stratified by class, paired, rng_seed=0. Macro-F1 deltas in percentage points.

| Delta | Observed (pp) | 95% CI (pp) | P(delta>0) |
|---|---:|---|---:|
| DAS+ACR single - DAS single | +6.55 | [+4.69, +8.37] | 1.000 |
| DAS single - jitter single | +24.90 | [+21.47, +28.32] | 1.000 |
| DAS+ACR ensemble - DAS+ACR single | +2.40 | [+0.89, +3.96] | 0.999 |