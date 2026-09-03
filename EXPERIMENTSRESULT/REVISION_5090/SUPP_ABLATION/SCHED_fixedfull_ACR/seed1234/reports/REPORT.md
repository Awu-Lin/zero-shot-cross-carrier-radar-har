# SCHED_fixedfull_ACR

- Generated: 2026-06-09 16:15:06
- Backbone: vit_large_patch16_dinov3.lvd1689m
- Adapter mode: lora
- Checkpoint: vit_large_patch16_dinov3_lvd1689m_best_sourcequalified77_ema.pt (sourcequalified)
- Selection: source-qualified diagnostic selected (source-val ema acc >= 0.00, then best 77GHz ema macro-F1)

## 77GHz final test

- acc: 0.6727
- macro-F1: 0.6275

### per-class

- Away: 0.1250
- Bend: 0.6923
- Kneel: 0.9048
- Pick: 0.8500
- SStep: 1.0000
- Sit: 0.2432
- Towards: 0.8500

## val (10+24GHz source validation)

- acc: 0.9444
- macro-F1: 0.9438

## Frequency scan on 10GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9744 | 0.9760 |
| 30.0 | 0.9744 | 0.9760 |
| 50.0 | 0.9744 | 0.9760 |
| 77.0 | 0.9872 | 0.9881 |
| 99.0 | 0.9872 | 0.9881 |
| 120.0 | 0.9615 | 0.9618 |
| 140.0 | 0.9359 | 0.9369 |

## Frequency scan on 24GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 1.0000 | 1.0000 |
| 30.0 | 0.9881 | 0.9875 |
| 50.0 | 1.0000 | 1.0000 |
| 77.0 | 0.9881 | 0.9875 |
| 99.0 | 0.9762 | 0.9760 |
| 120.0 | 0.9762 | 0.9760 |
| 140.0 | 0.9881 | 0.9875 |
