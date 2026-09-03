# SCHED_fixednarrow_ACR

- Generated: 2026-06-09 16:52:07
- Backbone: vit_large_patch16_dinov3.lvd1689m
- Adapter mode: lora
- Checkpoint: vit_large_patch16_dinov3_lvd1689m_best_sourcequalified77_ema.pt (sourcequalified)
- Selection: source-qualified diagnostic selected (source-val ema acc >= 0.00, then best 77GHz ema macro-F1)

## 77GHz final test

- acc: 0.8381
- macro-F1: 0.8204

### per-class

- Away: 1.0000
- Bend: 0.7692
- Kneel: 0.9762
- Pick: 0.8250
- SStep: 1.0000
- Sit: 0.3514
- Towards: 0.9000

## val (10+24GHz source validation)

- acc: 0.9877
- macro-F1: 0.9878

## Frequency scan on 10GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9744 | 0.9760 |
| 30.0 | 0.9872 | 0.9881 |
| 50.0 | 0.9359 | 0.9356 |
| 77.0 | 0.8846 | 0.8860 |
| 99.0 | 0.8333 | 0.8317 |
| 120.0 | 0.7692 | 0.7543 |
| 140.0 | 0.6795 | 0.6561 |

## Frequency scan on 24GHz val

| f_virt (GHz) | acc | macro-F1 |
|---|---|---|
| 15.0 | 0.9881 | 0.9876 |
| 30.0 | 0.9762 | 0.9751 |
| 50.0 | 0.9286 | 0.9279 |
| 77.0 | 0.8810 | 0.8781 |
| 99.0 | 0.7976 | 0.7853 |
| 120.0 | 0.7738 | 0.7530 |
| 140.0 | 0.7262 | 0.6870 |
