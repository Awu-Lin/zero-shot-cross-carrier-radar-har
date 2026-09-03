# DAS_ERM

- Generated: 2026-06-09 18:19:23
- Backbone: vit_large_patch16_dinov3.lvd1689m
- Adapter mode: lora
- Checkpoint: vit_large_patch16_dinov3_lvd1689m_best_sourcequalified77_ema.pt (sourcequalified)
- Selection: source-qualified diagnostic selected (source-val ema acc >= 0.00, then best 77GHz ema macro-F1)

## 77GHz final test

- acc: 0.2338
- macro-F1: 0.1321

### per-class

- Away: 0.6500
- Bend: 1.0000
- Kneel: 0.0000
- Pick: 0.0000
- SStep: 0.0000
- Sit: 0.0000
- Towards: 0.0000

## val (10+24GHz source validation)

- acc: 0.9444
- macro-F1: 0.9446

## Frequency scan on 10GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.8205 | 0.8166 |
| 30.0 | 0.3718 | 0.2381 |
| 50.0 | 0.3333 | 0.1848 |
| 77.0 | 0.3205 | 0.1624 |
| 99.0 | 0.3077 | 0.1349 |
| 120.0 | 0.3077 | 0.1353 |
| 140.0 | 0.3205 | 0.1634 |

## Frequency scan on 24GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.6429 | 0.6233 |
| 30.0 | 0.9405 | 0.9404 |
| 50.0 | 0.5595 | 0.5141 |
| 77.0 | 0.3333 | 0.2245 |
| 99.0 | 0.2738 | 0.1427 |
| 120.0 | 0.2619 | 0.1188 |
| 140.0 | 0.2738 | 0.1231 |
