# DAS_stretch_only

- Generated: 2026-06-09 15:01:32
- Backbone: vit_large_patch16_dinov3.lvd1689m
- Adapter mode: lora
- Checkpoint: vit_large_patch16_dinov3_lvd1689m_best_sourcequalified77_ema.pt (sourcequalified)
- Selection: source-qualified diagnostic selected (source-val ema acc >= 0.00, then best 77GHz ema macro-F1)

## 77GHz final test

- acc: 0.6331
- macro-F1: 0.5865

### per-class

- Away: 1.0000
- Bend: 0.8462
- Kneel: 0.8333
- Pick: 0.6250
- SStep: 0.2000
- Sit: 0.0811
- Towards: 0.8000

## val (10+24GHz source validation)

- acc: 0.9568
- macro-F1: 0.9562

## Frequency scan on 10GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9744 | 0.9756 |
| 30.0 | 0.9487 | 0.9474 |
| 50.0 | 0.9744 | 0.9760 |
| 77.0 | 0.9615 | 0.9597 |
| 99.0 | 0.9487 | 0.9478 |
| 120.0 | 0.9487 | 0.9478 |
| 140.0 | 0.9231 | 0.9223 |

## Frequency scan on 24GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9762 | 0.9760 |
| 30.0 | 0.9762 | 0.9760 |
| 50.0 | 0.9762 | 0.9760 |
| 77.0 | 0.9762 | 0.9760 |
| 99.0 | 0.9762 | 0.9760 |
| 120.0 | 0.9524 | 0.9526 |
| 140.0 | 0.9167 | 0.9138 |
