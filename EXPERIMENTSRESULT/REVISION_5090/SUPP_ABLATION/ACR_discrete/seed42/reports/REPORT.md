# ACR_discrete

- Generated: 2026-06-09 13:46:19
- Backbone: vit_large_patch16_dinov3.lvd1689m
- Adapter mode: lora
- Checkpoint: vit_large_patch16_dinov3_lvd1689m_best_sourcequalified77_ema.pt (sourcequalified)
- Selection: source-qualified diagnostic selected (source-val ema acc >= 0.00, then best 77GHz ema macro-F1)

## 77GHz final test

- acc: 0.8022
- macro-F1: 0.7911

### per-class

- Away: 0.9750
- Bend: 0.9231
- Kneel: 0.7857
- Pick: 0.7500
- SStep: 0.9750
- Sit: 0.3514
- Towards: 0.8250

## val (10+24GHz source validation)

- acc: 0.9815
- macro-F1: 0.9818

## Frequency scan on 10GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9744 | 0.9762 |
| 30.0 | 0.9872 | 0.9881 |
| 50.0 | 0.9744 | 0.9762 |
| 77.0 | 0.9744 | 0.9762 |
| 99.0 | 0.9615 | 0.9642 |
| 120.0 | 0.9359 | 0.9399 |
| 140.0 | 0.9231 | 0.9269 |

## Frequency scan on 24GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9762 | 0.9760 |
| 30.0 | 0.9762 | 0.9760 |
| 50.0 | 0.9762 | 0.9760 |
| 77.0 | 0.9762 | 0.9760 |
| 99.0 | 0.9405 | 0.9399 |
| 120.0 | 0.9524 | 0.9522 |
| 140.0 | 0.9286 | 0.9296 |
