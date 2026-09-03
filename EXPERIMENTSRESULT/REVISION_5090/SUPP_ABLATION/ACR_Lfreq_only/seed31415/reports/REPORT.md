# ACR_Lfreq_only

- Generated: 2026-06-09 12:05:11
- Backbone: vit_large_patch16_dinov3.lvd1689m
- Adapter mode: lora
- Checkpoint: vit_large_patch16_dinov3_lvd1689m_best_sourcequalified77_ema.pt (sourcequalified)
- Selection: source-qualified diagnostic selected (source-val ema acc >= 0.00, then best 77GHz ema macro-F1)

## 77GHz final test

- acc: 0.8561
- macro-F1: 0.8525

### per-class

- Away: 1.0000
- Bend: 0.8462
- Kneel: 0.8095
- Pick: 0.8500
- SStep: 1.0000
- Sit: 0.6757
- Towards: 0.8000

## val (10+24GHz source validation)

- acc: 0.9691
- macro-F1: 0.9694

## Frequency scan on 10GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9615 | 0.9637 |
| 30.0 | 0.9744 | 0.9760 |
| 50.0 | 0.9744 | 0.9760 |
| 77.0 | 0.9872 | 0.9881 |
| 99.0 | 0.9744 | 0.9760 |
| 120.0 | 0.9359 | 0.9398 |
| 140.0 | 0.8846 | 0.8878 |

## Frequency scan on 24GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9881 | 0.9881 |
| 30.0 | 0.9881 | 0.9885 |
| 50.0 | 0.9643 | 0.9631 |
| 77.0 | 0.9762 | 0.9760 |
| 99.0 | 0.9762 | 0.9760 |
| 120.0 | 0.9643 | 0.9646 |
| 140.0 | 0.9643 | 0.9641 |
