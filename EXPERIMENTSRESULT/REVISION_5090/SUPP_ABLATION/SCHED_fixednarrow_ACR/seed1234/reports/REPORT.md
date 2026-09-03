# SCHED_fixednarrow_ACR

- Generated: 2026-06-09 17:10:32
- Backbone: vit_large_patch16_dinov3.lvd1689m
- Adapter mode: lora
- Checkpoint: vit_large_patch16_dinov3_lvd1689m_best_sourcequalified77_ema.pt (sourcequalified)
- Selection: source-qualified diagnostic selected (source-val ema acc >= 0.00, then best 77GHz ema macro-F1)

## 77GHz final test

- acc: 0.8885
- macro-F1: 0.8851

### per-class

- Away: 1.0000
- Bend: 0.7949
- Kneel: 0.9524
- Pick: 0.8750
- SStep: 1.0000
- Sit: 0.6757
- Towards: 0.9000

## val (10+24GHz source validation)

- acc: 0.9815
- macro-F1: 0.9818

## Frequency scan on 10GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9744 | 0.9760 |
| 30.0 | 0.9615 | 0.9637 |
| 50.0 | 0.9487 | 0.9510 |
| 77.0 | 0.9231 | 0.9228 |
| 99.0 | 0.8590 | 0.8616 |
| 120.0 | 0.7949 | 0.7862 |
| 140.0 | 0.7949 | 0.7934 |

## Frequency scan on 24GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 1.0000 | 1.0000 |
| 30.0 | 0.9762 | 0.9751 |
| 50.0 | 0.9881 | 0.9875 |
| 77.0 | 0.9048 | 0.9040 |
| 99.0 | 0.8214 | 0.8063 |
| 120.0 | 0.7500 | 0.7315 |
| 140.0 | 0.7262 | 0.6992 |
