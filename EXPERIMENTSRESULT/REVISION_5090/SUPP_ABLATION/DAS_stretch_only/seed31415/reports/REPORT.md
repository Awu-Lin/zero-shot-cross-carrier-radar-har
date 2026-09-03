# DAS_stretch_only

- Generated: 2026-06-09 15:38:07
- Backbone: vit_large_patch16_dinov3.lvd1689m
- Adapter mode: lora
- Checkpoint: vit_large_patch16_dinov3_lvd1689m_best_sourcequalified77_ema.pt (sourcequalified)
- Selection: source-qualified diagnostic selected (source-val ema acc >= 0.00, then best 77GHz ema macro-F1)

## 77GHz final test

- acc: 0.7626
- macro-F1: 0.7412

### per-class

- Away: 0.8750
- Bend: 0.7692
- Kneel: 0.8095
- Pick: 0.7250
- SStep: 1.0000
- Sit: 0.2162
- Towards: 0.9000

## val (10+24GHz source validation)

- acc: 0.9568
- macro-F1: 0.9566

## Frequency scan on 10GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9744 | 0.9760 |
| 30.0 | 0.9872 | 0.9881 |
| 50.0 | 0.9615 | 0.9637 |
| 77.0 | 0.9487 | 0.9512 |
| 99.0 | 0.9103 | 0.9121 |
| 120.0 | 0.9103 | 0.9101 |
| 140.0 | 0.8974 | 0.8976 |

## Frequency scan on 24GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9762 | 0.9751 |
| 30.0 | 0.9405 | 0.9402 |
| 50.0 | 0.9524 | 0.9517 |
| 77.0 | 0.9643 | 0.9627 |
| 99.0 | 0.9524 | 0.9502 |
| 120.0 | 0.9524 | 0.9514 |
| 140.0 | 0.9524 | 0.9517 |
