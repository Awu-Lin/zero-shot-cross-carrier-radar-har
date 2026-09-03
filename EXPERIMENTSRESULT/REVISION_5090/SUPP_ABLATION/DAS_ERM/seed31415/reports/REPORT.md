# DAS_ERM

- Generated: 2026-06-09 14:43:16
- Backbone: vit_large_patch16_dinov3.lvd1689m
- Adapter mode: lora
- Checkpoint: vit_large_patch16_dinov3_lvd1689m_best_sourcequalified77_ema.pt (sourcequalified)
- Selection: source-qualified diagnostic selected (source-val ema acc >= 0.00, then best 77GHz ema macro-F1)

## 77GHz final test

- acc: 0.2770
- macro-F1: 0.1248

### per-class

- Away: 0.0000
- Bend: 0.9487
- Kneel: 0.0000
- Pick: 0.0000
- SStep: 0.0000
- Sit: 0.0000
- Towards: 1.0000

## val (10+24GHz source validation)

- acc: 0.9444
- macro-F1: 0.9460

## Frequency scan on 10GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.8462 | 0.8471 |
| 30.0 | 0.3590 | 0.2489 |
| 50.0 | 0.3205 | 0.2481 |
| 77.0 | 0.3333 | 0.2290 |
| 99.0 | 0.3462 | 0.2304 |
| 120.0 | 0.3333 | 0.2107 |
| 140.0 | 0.2821 | 0.1426 |

## Frequency scan on 24GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.6548 | 0.6257 |
| 30.0 | 0.8929 | 0.8906 |
| 50.0 | 0.4405 | 0.3683 |
| 77.0 | 0.3929 | 0.2698 |
| 99.0 | 0.3690 | 0.2479 |
| 120.0 | 0.3690 | 0.2530 |
| 140.0 | 0.3214 | 0.2218 |
