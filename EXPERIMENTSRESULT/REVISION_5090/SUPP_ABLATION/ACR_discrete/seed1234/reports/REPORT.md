# ACR_discrete

- Generated: 2026-06-09 14:06:44
- Backbone: vit_large_patch16_dinov3.lvd1689m
- Adapter mode: lora
- Checkpoint: vit_large_patch16_dinov3_lvd1689m_best_sourcequalified77_ema.pt (sourcequalified)
- Selection: source-qualified diagnostic selected (source-val ema acc >= 0.00, then best 77GHz ema macro-F1)

## 77GHz final test

- acc: 0.8094
- macro-F1: 0.7956

### per-class

- Away: 1.0000
- Bend: 0.7949
- Kneel: 0.9286
- Pick: 0.8000
- SStep: 1.0000
- Sit: 0.3784
- Towards: 0.7250

## val (10+24GHz source validation)

- acc: 0.9691
- macro-F1: 0.9692

## Frequency scan on 10GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9744 | 0.9760 |
| 30.0 | 0.9872 | 0.9881 |
| 50.0 | 0.9744 | 0.9760 |
| 77.0 | 0.9615 | 0.9637 |
| 99.0 | 0.9231 | 0.9273 |
| 120.0 | 0.9231 | 0.9273 |
| 140.0 | 0.9103 | 0.9152 |

## Frequency scan on 24GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9881 | 0.9885 |
| 30.0 | 1.0000 | 1.0000 |
| 50.0 | 0.9881 | 0.9875 |
| 77.0 | 0.9643 | 0.9637 |
| 99.0 | 0.9643 | 0.9637 |
| 120.0 | 0.9643 | 0.9646 |
| 140.0 | 0.9286 | 0.9291 |
