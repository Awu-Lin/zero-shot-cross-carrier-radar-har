# ACR_Lfreq_only

- Generated: 2026-06-09 03:54:44
- Backbone: vit_large_patch16_dinov3.lvd1689m
- Adapter mode: lora
- Checkpoint: vit_large_patch16_dinov3_lvd1689m_best_sourcequalified77_ema.pt (sourcequalified)
- Selection: source-qualified diagnostic selected (source-val ema acc >= 0.00, then best 77GHz ema macro-F1)

## 77GHz final test

- acc: 0.8058
- macro-F1: 0.8022

### per-class

- Away: 0.9750
- Bend: 0.6410
- Kneel: 0.8333
- Pick: 0.8750
- SStep: 0.9500
- Sit: 0.5676
- Towards: 0.7750

## val (10+24GHz source validation)

- acc: 0.9753
- macro-F1: 0.9755

## Frequency scan on 10GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9744 | 0.9756 |
| 30.0 | 0.9744 | 0.9760 |
| 50.0 | 0.9872 | 0.9881 |
| 77.0 | 0.9744 | 0.9760 |
| 99.0 | 0.9359 | 0.9355 |
| 120.0 | 0.8974 | 0.8991 |
| 140.0 | 0.8974 | 0.8993 |

## Frequency scan on 24GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9762 | 0.9757 |
| 30.0 | 0.9881 | 0.9876 |
| 50.0 | 0.9762 | 0.9751 |
| 77.0 | 0.9762 | 0.9751 |
| 99.0 | 0.9762 | 0.9751 |
| 120.0 | 0.9762 | 0.9751 |
| 140.0 | 0.9762 | 0.9751 |
