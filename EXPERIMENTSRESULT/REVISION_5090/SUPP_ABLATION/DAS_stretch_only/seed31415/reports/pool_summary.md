# Pool selection summary

- threshold: source_val_acc_ema >= 0.90
- period: every 10 epochs
- pool size: 7
- selection metric: dev77_f1

## Members

| epoch | src_val_acc | src_val_F1 | dev77 acc | dev77 F1 | final77 acc | final77 F1 |
|---:|---:|---:|---:|---:|---:|---:|
|  40 | 0.9383 | 0.9393 | 0.3500 | 0.2733 | 0.3921 | 0.3180 |
|  50 | 0.9568 | 0.9568 | 0.5571 | 0.5277 | 0.5791 | 0.5383 |
|  60 | 0.9568 | 0.9568 | 0.6429 | 0.6264 | 0.7086 | 0.6855 |
|  70 | 0.9568 | 0.9564 | 0.6857 | 0.6689 | 0.7482 | 0.7289 |
|  80 | 0.9630 | 0.9633 | 0.7000 | 0.6796 | 0.7482 | 0.7260 |
|  90 | 0.9568 | 0.9566 | 0.7000 | 0.6809 | 0.7518 | 0.7293 |
| 100 | 0.9568 | 0.9566 | 0.7000 | 0.6797 | 0.7626 | 0.7412 |

## Selected (best in pool)

- epoch: **90**
- source val acc / F1 (EMA): 0.9568 / 0.9566
- 77GHz dev   acc / F1: 0.7000 / 0.6809
- 77GHz final acc / F1: 0.7518 / 0.7293
- checkpoint: `EXPERIMENTSRESULT\REVISION_5090\SUPP_ABLATION\DAS_stretch_only\seed31415\checkpoints\best_pool_ema.pt`

### dev77 per-class F1
- Away: 0.8500
- Bend: 0.7000
- Kneel: 0.6500
- Pick: 0.7500
- SStep: 1.0000
- Sit: 0.2000
- Towards: 0.7500

### final77 per-class F1
- Away: 0.8750
- Bend: 0.7692
- Kneel: 0.7857
- Pick: 0.7000
- SStep: 1.0000
- Sit: 0.1892
- Towards: 0.9000
