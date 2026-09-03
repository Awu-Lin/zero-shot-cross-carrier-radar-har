# Component ablation -- final-EMA honest rule, full-418 77GHz, 3 seeds (42/1234/31415)

Selection = EMA weights at the last epoch (ep100); no target/source-val peeking.

| Variant | Accuracy | Macro-F1 | d macro-F1 (pp) |
|---|---|---|---:|
| V13-as-GRL (shown w0.3) | 0.836 ± 0.032 | 0.832 ± 0.034 | +0.0 |
| ACR L_freq only | 0.819 ± 0.021 | 0.814 ± 0.021 | -1.9 |
| ACR GRL only | 0.832 ± 0.016 | 0.826 ± 0.016 | -0.6 |
| ACR discrete adversary | 0.802 ± 0.032 | 0.796 ± 0.034 | -3.6 |
| DAS ERM (no aug) | 0.271 ± 0.029 | 0.146 ± 0.034 | -68.6 |
| DAS stretch only | 0.727 ± 0.075 | 0.704 ± 0.089 | -12.8 |
| DAS fixed-full + ACR | 0.640 ± 0.067 | 0.626 ± 0.058 | -20.7 |
| DAS fixed-narrow + ACR | 0.822 ± 0.038 | 0.800 ± 0.057 | -3.2 |

Per-seed Macro-F1 (full-418):

| Variant | seed42 | seed1234 | seed31415 |
|---|---:|---:|---:|
| V13-as-GRL (shown w0.3) | 0.7910 | 0.8322 | 0.8735 |
| ACR L_freq only | 0.7846 | 0.8267 | 0.8297 |
| ACR GRL only | 0.8069 | 0.8268 | 0.8454 |
| ACR discrete adversary | 0.7746 | 0.7709 | 0.8440 |
| DAS ERM (no aug) | 0.1211 | 0.1941 | 0.1232 |
| DAS stretch only | 0.5866 | 0.8038 | 0.7208 |
| DAS fixed-full + ACR | 0.5535 | 0.6273 | 0.6962 |
| DAS fixed-narrow + ACR | 0.8149 | 0.8605 | 0.7243 |

## Component contributions (full-418 macro-F1, mean)
- ACR GRL half: A_V13_GRL - ACR_Lfreq_only = **+1.9 pp**
- ACR residual half: A_V13_GRL - ACR_GRL_only = **+0.6 pp**
- continuous vs discrete adversary: A_V13_GRL - ACR_discrete = **+3.6 pp**
- Doppler-stretch alone over ERM: DAS_stretch_only - DAS_ERM = **+55.8 pp**

## Eval-harness cross-check (278-subset final-EMA vs run history last-epoch)
max |diff| vs history.json = 0.0000 (should be ~0 -> harness validated)