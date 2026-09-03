# SCHED_fixednarrow_ACR

- Generated: 2026-06-09 17:29:00
- Backbone: vit_large_patch16_dinov3.lvd1689m
- Adapter mode: lora
- Checkpoint: vit_large_patch16_dinov3_lvd1689m_best_sourcequalified77_ema.pt (sourcequalified)
- Selection: source-qualified diagnostic selected (source-val ema acc >= 0.00, then best 77GHz ema macro-F1)

## 77GHz final test

- acc: 0.7914
- macro-F1: 0.7471

### per-class

- Away: 1.0000
- Bend: 0.7436
- Kneel: 1.0000
- Pick: 0.7250
- SStep: 1.0000
- Sit: 0.1081
- Towards: 0.9000

## val (10+24GHz source validation)

- acc: 0.9938
- macro-F1: 0.9939

## Frequency scan on 10GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9744 | 0.9756 |
| 30.0 | 0.9615 | 0.9637 |
| 50.0 | 0.9487 | 0.9510 |
| 77.0 | 0.9103 | 0.9110 |
| 99.0 | 0.8718 | 0.8740 |
| 120.0 | 0.8077 | 0.7993 |
| 140.0 | 0.7692 | 0.7540 |

## Frequency scan on 24GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 1.0000 | 1.0000 |
| 30.0 | 0.9881 | 0.9875 |
| 50.0 | 0.9643 | 0.9637 |
| 77.0 | 0.8452 | 0.8441 |
| 99.0 | 0.6786 | 0.6640 |
| 120.0 | 0.5714 | 0.5329 |
| 140.0 | 0.5833 | 0.5313 |
