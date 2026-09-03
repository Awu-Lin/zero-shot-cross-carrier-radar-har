# DAS_ERM

- Generated: 2026-06-09 14:25:02
- Backbone: vit_large_patch16_dinov3.lvd1689m
- Adapter mode: lora
- Checkpoint: vit_large_patch16_dinov3_lvd1689m_best_sourcequalified77_ema.pt (sourcequalified)
- Selection: source-qualified diagnostic selected (source-val ema acc >= 0.00, then best 77GHz ema macro-F1)

## 77GHz final test

- acc: 0.2950
- macro-F1: 0.1803

### per-class

- Away: 0.1500
- Bend: 1.0000
- Kneel: 0.0000
- Pick: 0.0000
- SStep: 0.0000
- Sit: 0.0000
- Towards: 0.9250

## val (10+24GHz source validation)

- acc: 0.9444
- macro-F1: 0.9455

## Frequency scan on 10GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.8718 | 0.8787 |
| 30.0 | 0.3974 | 0.3200 |
| 50.0 | 0.2821 | 0.1504 |
| 77.0 | 0.2949 | 0.1524 |
| 99.0 | 0.3077 | 0.1690 |
| 120.0 | 0.2949 | 0.1637 |
| 140.0 | 0.2821 | 0.1299 |

## Frequency scan on 24GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.6071 | 0.5748 |
| 30.0 | 0.9286 | 0.9288 |
| 50.0 | 0.4881 | 0.4672 |
| 77.0 | 0.4048 | 0.2876 |
| 99.0 | 0.3690 | 0.2465 |
| 120.0 | 0.3690 | 0.2457 |
| 140.0 | 0.3095 | 0.1824 |
