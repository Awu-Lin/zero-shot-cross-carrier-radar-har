# ACR_Lfreq_only

- Generated: 2026-06-09 11:38:31
- Backbone: vit_large_patch16_dinov3.lvd1689m
- Adapter mode: lora
- Checkpoint: vit_large_patch16_dinov3_lvd1689m_best_sourcequalified77_ema.pt (sourcequalified)
- Selection: source-qualified diagnostic selected (source-val ema acc >= 0.00, then best 77GHz ema macro-F1)

## 77GHz final test

- acc: 0.8633
- macro-F1: 0.8554

### per-class

- Away: 1.0000
- Bend: 0.5897
- Kneel: 0.8810
- Pick: 0.9750
- SStep: 1.0000
- Sit: 0.6216
- Towards: 0.9500

## val (10+24GHz source validation)

- acc: 0.9753
- macro-F1: 0.9754

## Frequency scan on 10GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9744 | 0.9756 |
| 30.0 | 0.9744 | 0.9760 |
| 50.0 | 0.9744 | 0.9760 |
| 77.0 | 0.9615 | 0.9637 |
| 99.0 | 0.9487 | 0.9523 |
| 120.0 | 0.9359 | 0.9401 |
| 140.0 | 0.9231 | 0.9265 |

## Frequency scan on 24GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9881 | 0.9885 |
| 30.0 | 0.9762 | 0.9760 |
| 50.0 | 0.9643 | 0.9631 |
| 77.0 | 0.9643 | 0.9627 |
| 99.0 | 0.9643 | 0.9627 |
| 120.0 | 0.9524 | 0.9513 |
| 140.0 | 0.9405 | 0.9398 |
