# ACR_GRL_only

- Generated: 2026-06-09 12:56:28
- Backbone: vit_large_patch16_dinov3.lvd1689m
- Adapter mode: lora
- Checkpoint: vit_large_patch16_dinov3_lvd1689m_best_sourcequalified77_ema.pt (sourcequalified)
- Selection: source-qualified diagnostic selected (source-val ema acc >= 0.00, then best 77GHz ema macro-F1)

## 77GHz final test

- acc: 0.8633
- macro-F1: 0.8610

### per-class

- Away: 1.0000
- Bend: 0.7949
- Kneel: 0.7857
- Pick: 0.8750
- SStep: 1.0000
- Sit: 0.6757
- Towards: 0.9000

## val (10+24GHz source validation)

- acc: 0.9691
- macro-F1: 0.9692

## Frequency scan on 10GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9744 | 0.9760 |
| 30.0 | 0.9744 | 0.9760 |
| 50.0 | 0.9744 | 0.9722 |
| 77.0 | 0.9487 | 0.9478 |
| 99.0 | 0.9744 | 0.9760 |
| 120.0 | 0.9487 | 0.9513 |
| 140.0 | 0.9359 | 0.9388 |

## Frequency scan on 24GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9881 | 0.9885 |
| 30.0 | 0.9643 | 0.9631 |
| 50.0 | 0.9762 | 0.9760 |
| 77.0 | 0.9643 | 0.9646 |
| 99.0 | 0.9524 | 0.9531 |
| 120.0 | 0.9524 | 0.9531 |
| 140.0 | 0.9405 | 0.9412 |
