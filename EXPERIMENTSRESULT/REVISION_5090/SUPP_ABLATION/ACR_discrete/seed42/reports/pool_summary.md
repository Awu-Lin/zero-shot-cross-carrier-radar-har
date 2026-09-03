# Pool selection summary

- threshold: source_val_acc_ema >= 0.90
- period: every 10 epochs
- pool size: 7
- selection metric: dev77_f1

## Members

| epoch | src_val_acc | src_val_F1 | dev77 acc | dev77 F1 | final77 acc | final77 F1 |
|---:|---:|---:|---:|---:|---:|---:|
|  40 | 0.9136 | 0.9138 | 0.5929 | 0.5261 | 0.6295 | 0.5496 |
|  50 | 0.9691 | 0.9696 | 0.7000 | 0.6645 | 0.7050 | 0.6706 |
|  60 | 0.9815 | 0.9819 | 0.7286 | 0.7093 | 0.7878 | 0.7733 |
|  70 | 0.9815 | 0.9818 | 0.7214 | 0.7094 | 0.8022 | 0.7908 |
|  80 | 0.9877 | 0.9878 | 0.7429 | 0.7283 | 0.7950 | 0.7833 |
|  90 | 0.9877 | 0.9878 | 0.7500 | 0.7376 | 0.7878 | 0.7755 |
| 100 | 0.9877 | 0.9878 | 0.7714 | 0.7616 | 0.7842 | 0.7726 |

## Selected (best in pool)

- epoch: **100**
- source val acc / F1 (EMA): 0.9877 / 0.9878
- 77GHz dev   acc / F1: 0.7714 / 0.7616
- 77GHz final acc / F1: 0.7842 / 0.7726
- checkpoint: `EXPERIMENTSRESULT\REVISION_5090\SUPP_ABLATION\ACR_discrete\seed42\checkpoints\best_pool_ema.pt`

### dev77 per-class F1
- Away: 0.9500
- Bend: 0.6000
- Kneel: 0.9000
- Pick: 0.9000
- SStep: 0.9500
- Sit: 0.4000
- Towards: 0.7000

### final77 per-class F1
- Away: 0.9750
- Bend: 0.6154
- Kneel: 0.8333
- Pick: 0.9000
- SStep: 0.9500
- Sit: 0.4054
- Towards: 0.7750
