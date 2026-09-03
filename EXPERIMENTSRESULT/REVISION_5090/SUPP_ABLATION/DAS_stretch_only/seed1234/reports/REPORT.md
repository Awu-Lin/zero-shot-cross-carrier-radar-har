# DAS_stretch_only

- Generated: 2026-06-09 15:19:48
- Backbone: vit_large_patch16_dinov3.lvd1689m
- Adapter mode: lora
- Checkpoint: vit_large_patch16_dinov3_lvd1689m_best_sourcequalified77_ema.pt (sourcequalified)
- Selection: source-qualified diagnostic selected (source-val ema acc >= 0.00, then best 77GHz ema macro-F1)

## 77GHz final test

- acc: 0.8273
- macro-F1: 0.8230

### per-class

- Away: 1.0000
- Bend: 0.8974
- Kneel: 0.7381
- Pick: 0.7500
- SStep: 1.0000
- Sit: 0.4595
- Towards: 0.9250

## val (10+24GHz source validation)

- acc: 0.9815
- macro-F1: 0.9818

## Frequency scan on 10GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9615 | 0.9637 |
| 30.0 | 0.9744 | 0.9760 |
| 50.0 | 0.9744 | 0.9760 |
| 77.0 | 0.9487 | 0.9520 |
| 99.0 | 0.9359 | 0.9393 |
| 120.0 | 0.9231 | 0.9275 |
| 140.0 | 0.8974 | 0.8974 |

## Frequency scan on 24GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9881 | 0.9875 |
| 30.0 | 0.9762 | 0.9751 |
| 50.0 | 0.9643 | 0.9637 |
| 77.0 | 0.9643 | 0.9637 |
| 99.0 | 0.9643 | 0.9637 |
| 120.0 | 0.9405 | 0.9402 |
| 140.0 | 0.9286 | 0.9279 |
