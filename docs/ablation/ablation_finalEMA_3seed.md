# Component ablation -- final-EMA honest rule, full-418 77GHz, 3 seeds (42/1234/31415)

Selection = EMA weights at the last epoch (ep100); no target/source-val peeking.

| Variant | Accuracy | Macro-F1 | d macro-F1 (pp) |
|---|---|---|---:|
| Full (Proposed) | 0.825 ± 0.009 | 0.818 ± 0.009 | -- |
| - falsification | 0.807 ± 0.058 | 0.803 ± 0.058 | -1.6 |
| - residual split | 0.805 ± 0.019 | 0.799 ± 0.020 | -1.9 |
| - both modules (DAS only) | 0.781 ± 0.070 | 0.767 ± 0.076 | -5.2 |
| - DAS (pure base) | 0.413 ± 0.025 | 0.302 ± 0.031 | -51.7 |
| V13-as-GRL (shown w0.3) | 0.836 ± 0.032 | 0.832 ± 0.034 | +1.4 |
| GRL + wc-margin V15R | 0.831 ± 0.008 | 0.823 ± 0.011 | +0.5 |
| DAS jitter (physics-free) | 0.585 ± 0.022 | 0.518 ± 0.030 | -30.1 |
| DANN (data-driven) | 0.374 ± 0.040 | 0.275 ± 0.024 | -54.3 |
| full-method + jitter | 0.805 ± 0.033 | 0.796 ± 0.037 | -2.2 |
| DAS fixed-full (no curric) | 0.763 ± 0.086 | 0.756 ± 0.086 | -6.2 |
| DAS fixed-narrow | 0.822 ± 0.022 | 0.804 ± 0.038 | -1.5 |
| ACR L_freq only | 0.819 ± 0.021 | 0.814 ± 0.021 | -0.5 |
| ACR GRL only | 0.832 ± 0.016 | 0.826 ± 0.016 | +0.8 |
| ACR discrete adversary | 0.802 ± 0.032 | 0.796 ± 0.034 | -2.2 |
| DAS ERM (no aug) | 0.271 ± 0.029 | 0.146 ± 0.034 | -67.2 |
| DAS stretch only | 0.727 ± 0.075 | 0.704 ± 0.089 | -11.5 |
| DAS fixed-full + ACR | 0.640 ± 0.067 | 0.626 ± 0.058 | -19.3 |
| DAS fixed-narrow + ACR | 0.822 ± 0.038 | 0.800 ± 0.057 | -1.9 |

Per-seed Macro-F1 (full-418):

| Variant | seed42 | seed1234 | seed31415 |
|---|---:|---:|---:|
| Full (Proposed) | 0.8067 | 0.8213 | 0.8272 |
| - falsification | 0.7284 | 0.8092 | 0.8701 |
| - residual split | 0.7871 | 0.7826 | 0.8276 |
| - both modules (DAS only) | 0.6707 | 0.7720 | 0.8573 |
| - DAS (pure base) | 0.3286 | 0.3174 | 0.2590 |
| V13-as-GRL (shown w0.3) | 0.7910 | 0.8322 | 0.8735 |
| GRL + wc-margin V15R | 0.8236 | 0.8365 | 0.8099 |
| DAS jitter (physics-free) | 0.5599 | 0.4967 | 0.4964 |
| DANN (data-driven) | 0.2683 | 0.2494 | 0.3081 |
| full-method + jitter | 0.8060 | 0.7471 | 0.8355 |
| DAS fixed-full (no curric) | 0.6339 | 0.8133 | 0.8209 |
| DAS fixed-narrow | 0.7513 | 0.8400 | 0.8198 |
| ACR L_freq only | 0.7846 | 0.8267 | 0.8297 |
| ACR GRL only | 0.8069 | 0.8268 | 0.8454 |
| ACR discrete adversary | 0.7746 | 0.7709 | 0.8440 |
| DAS ERM (no aug) | 0.1211 | 0.1941 | 0.1232 |
| DAS stretch only | 0.5866 | 0.8038 | 0.7208 |
| DAS fixed-full + ACR | 0.5535 | 0.6273 | 0.6962 |
| DAS fixed-narrow + ACR | 0.8149 | 0.8605 | 0.7243 |

## Component contributions (full-418 macro-F1, mean)
- DAS (foundation): A_REF 0.767 - E1_noDAS 0.302 = **+46.5 pp**
- falsification (V15) on top of full: Full - (-falsif) = **+1.6 pp**
- residual split (V13) on top of full: Full - (-residual) = **+1.9 pp**
- V15 alone over DAS-base: A_V15 - A_REF = **+3.2 pp**
- V13 alone over DAS-base: A_V13 - A_REF = **+3.6 pp**
- both modules over DAS-base: A_V20 - A_REF = **+5.2 pp** (vs sum of singles +6.8 pp -> additivity/complementarity check)
- ACR GRL half: A_V13_GRL - ACR_Lfreq_only = **+1.9 pp**
- ACR residual half: A_V13_GRL - ACR_GRL_only = **+0.6 pp**
- continuous vs discrete adversary: A_V13_GRL - ACR_discrete = **+3.6 pp**
- Doppler-stretch alone over ERM: DAS_stretch_only - DAS_ERM = **+55.8 pp**

## Eval-harness cross-check (278-subset final-EMA vs run history last-epoch)
max |diff| vs history.json = 0.0000 (should be ~0 -> harness validated)