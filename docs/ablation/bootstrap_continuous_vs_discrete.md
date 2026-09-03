# Continuous vs discrete carrier adversary -- paired bootstrap 95% CI (PRELIMINARY, eval-only)

Full ACR, final-EMA (ep100), full-418 77 GHz, seeds 42/1234/31415. `single` macro-F1 = mean
over the 3 seeds; resampling is paired (same clips both sides) and class-stratified, B=10000,
rng_seed=0. Produced by `analysis_scripts/bootstrap_discrete.py`.

| Adversary | single macro-F1 (3-seed mean) |
|---|---|
| continuous log-carrier regressor (A_V13_GRL) | 0.8322 |
| discrete 3-bin classifier (ACR_discrete)      | 0.7965 |

| Delta | Observed (pp) | 95% CI (pp) | P(delta>0) |
|---|---:|---|---:|
| continuous - discrete (full ACR) | +3.57 | [+1.91, +5.31] | 1.000 |

The continuous log-carrier adversary significantly outperforms the ordinary discrete
domain-adversary control (CI excludes 0).
