# Pool selection summary

- threshold: source_val_acc_ema >= 0.90
- period: every 10 epochs
- pool size: 6
- selection metric: dev77_f1

## Members

| epoch | src_val_acc | src_val_F1 | dev77 acc | dev77 F1 | final77 acc | final77 F1 |
|---:|---:|---:|---:|---:|---:|---:|
|  50 | 0.9691 | 0.9698 | 0.4714 | 0.4379 | 0.5504 | 0.5300 |
|  60 | 0.9630 | 0.9631 | 0.5071 | 0.4912 | 0.5612 | 0.5486 |
|  70 | 0.9691 | 0.9691 | 0.5286 | 0.5067 | 0.5647 | 0.5561 |
|  80 | 0.9691 | 0.9691 | 0.5357 | 0.5263 | 0.5899 | 0.5855 |
|  90 | 0.9691 | 0.9691 | 0.5143 | 0.5118 | 0.5827 | 0.5858 |
| 100 | 0.9691 | 0.9691 | 0.5357 | 0.5361 | 0.5612 | 0.5673 |

## Selected (best in pool)

- epoch: **100**
- source val acc / F1 (EMA): 0.9691 / 0.9691
- 77GHz dev   acc / F1: 0.5357 / 0.5361
- 77GHz final acc / F1: 0.5612 / 0.5673
- checkpoint: `EXPERIMENTSRESULT\REVISION_5090\SUPP_ABLATION\SCHED_fixedfull_ACR\seed42\checkpoints\best_pool_ema.pt`

### dev77 per-class F1
- Away: 0.0000
- Bend: 0.6000
- Kneel: 0.8000
- Pick: 0.9000
- SStep: 0.8500
- Sit: 0.3000
- Towards: 0.3000

### final77 per-class F1
- Away: 0.0250
- Bend: 0.6154
- Kneel: 0.8095
- Pick: 0.9750
- SStep: 0.7750
- Sit: 0.4324
- Towards: 0.2750
