# SCHED_fixedfull_ACR

- Generated: 2026-06-09 15:56:35
- Backbone: vit_large_patch16_dinov3.lvd1689m
- Adapter mode: lora
- Checkpoint: vit_large_patch16_dinov3_lvd1689m_best_sourcequalified77_ema.pt (sourcequalified)
- Selection: source-qualified diagnostic selected (source-val ema acc >= 0.00, then best 77GHz ema macro-F1)

## 77GHz final test

- acc: 0.5899
- macro-F1: 0.5911

### per-class

- Away: 0.0250
- Bend: 0.6667
- Kneel: 0.8333
- Pick: 0.9750
- SStep: 0.8750
- Sit: 0.4595
- Towards: 0.2750

## val (10+24GHz source validation)

- acc: 0.9691
- macro-F1: 0.9691

## Frequency scan on 10GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9744 | 0.9760 |
| 30.0 | 0.9744 | 0.9760 |
| 50.0 | 0.9744 | 0.9760 |
| 77.0 | 0.9744 | 0.9760 |
| 99.0 | 0.9744 | 0.9760 |
| 120.0 | 0.9615 | 0.9618 |
| 140.0 | 0.9615 | 0.9618 |

## Frequency scan on 24GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9881 | 0.9881 |
| 30.0 | 1.0000 | 1.0000 |
| 50.0 | 1.0000 | 1.0000 |
| 77.0 | 0.9881 | 0.9875 |
| 99.0 | 0.9881 | 0.9875 |
| 120.0 | 0.9881 | 0.9875 |
| 140.0 | 0.9881 | 0.9875 |
