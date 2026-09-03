# P0-C ensemble fairness (PRELIMINARY -- eval-only, existing checkpoints)

Full-418 77GHz, final-EMA, seeds 42/1234/31415. Single = per-seed mean+/-std.

| Config | Single macro-F1 | Ens majority | Ens logit-avg | Ens posterior |
|---|---|---|---|---|
| DAS only (A_REF) | 0.7667 ± 0.0763 | 0.8166 | 0.8270 | 0.8220 |
| DAS+ACR (A_V13_GRL) | 0.8322 ± 0.0337 | 0.8512 | 0.8566 | 0.8562 |
| DAS jitter (E1_jitter) | 0.5177 ± 0.0298 | 0.5372 | 0.5369 | 0.5432 |

_Accuracy and per-seed values in ensemble_rules.json. Logits cached in logits_cache.npz for paired_bootstrap_ci.py._