# SCHED_fixedfull_ACR

- Generated: 2026-06-09 16:33:38
- Backbone: vit_large_patch16_dinov3.lvd1689m
- Adapter mode: lora
- Checkpoint: vit_large_patch16_dinov3_lvd1689m_best_sourcequalified77_ema.pt (sourcequalified)
- Selection: source-qualified diagnostic selected (source-val ema acc >= 0.00, then best 77GHz ema macro-F1)

## 77GHz final test

- acc: 0.7338
- macro-F1: 0.7244

### per-class

- Away: 0.2000
- Bend: 0.6667
- Kneel: 0.8095
- Pick: 0.9750
- SStep: 0.9750
- Sit: 0.8919
- Towards: 0.6250

## val (10+24GHz source validation)

- acc: 0.9506
- macro-F1: 0.9499

## Frequency scan on 10GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9744 | 0.9760 |
| 30.0 | 0.9744 | 0.9760 |
| 50.0 | 0.9744 | 0.9760 |
| 77.0 | 0.9744 | 0.9760 |
| 99.0 | 0.9744 | 0.9760 |
| 120.0 | 0.9744 | 0.9760 |
| 140.0 | 0.9615 | 0.9615 |

## Frequency scan on 24GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9881 | 0.9876 |
| 30.0 | 0.9881 | 0.9876 |
| 50.0 | 0.9881 | 0.9876 |
| 77.0 | 0.9881 | 0.9876 |
| 99.0 | 0.9881 | 0.9876 |
| 120.0 | 0.9881 | 0.9876 |
| 140.0 | 0.9643 | 0.9631 |
