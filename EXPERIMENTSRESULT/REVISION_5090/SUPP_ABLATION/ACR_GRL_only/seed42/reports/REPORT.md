# ACR_GRL_only

- Generated: 2026-06-09 12:35:20
- Backbone: vit_large_patch16_dinov3.lvd1689m
- Adapter mode: lora
- Checkpoint: vit_large_patch16_dinov3_lvd1689m_best_sourcequalified77_ema.pt (sourcequalified)
- Selection: source-qualified diagnostic selected (source-val ema acc >= 0.00, then best 77GHz ema macro-F1)

## 77GHz final test

- acc: 0.8417
- macro-F1: 0.8364

### per-class

- Away: 0.9500
- Bend: 0.7179
- Kneel: 0.8571
- Pick: 0.9000
- SStep: 1.0000
- Sit: 0.5405
- Towards: 0.9000

## val (10+24GHz source validation)

- acc: 0.9877
- macro-F1: 0.9879

## Frequency scan on 10GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9744 | 0.9760 |
| 30.0 | 0.9744 | 0.9760 |
| 50.0 | 0.9744 | 0.9760 |
| 77.0 | 0.9615 | 0.9637 |
| 99.0 | 0.9615 | 0.9637 |
| 120.0 | 0.9487 | 0.9510 |
| 140.0 | 0.9359 | 0.9385 |

## Frequency scan on 24GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9881 | 0.9876 |
| 30.0 | 0.9881 | 0.9885 |
| 50.0 | 0.9762 | 0.9760 |
| 77.0 | 0.9762 | 0.9760 |
| 99.0 | 0.9762 | 0.9760 |
| 120.0 | 0.9762 | 0.9760 |
| 140.0 | 0.9762 | 0.9760 |
