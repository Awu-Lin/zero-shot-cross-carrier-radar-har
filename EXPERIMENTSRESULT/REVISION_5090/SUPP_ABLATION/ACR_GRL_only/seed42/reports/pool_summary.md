# Pool selection summary

- threshold: source_val_acc_ema >= 0.90
- period: every 10 epochs
- pool size: 7
- selection metric: dev77_f1

## Members

| epoch | src_val_acc | src_val_F1 | dev77 acc | dev77 F1 | final77 acc | final77 F1 |
|---:|---:|---:|---:|---:|---:|---:|
|  40 | 0.9383 | 0.9388 | 0.5357 | 0.4716 | 0.5755 | 0.4972 |
|  50 | 0.9630 | 0.9632 | 0.6929 | 0.6629 | 0.7194 | 0.6870 |
|  60 | 0.9815 | 0.9819 | 0.7357 | 0.7247 | 0.8237 | 0.8139 |
|  70 | 0.9877 | 0.9879 | 0.7571 | 0.7471 | 0.8237 | 0.8145 |
|  80 | 0.9877 | 0.9879 | 0.7500 | 0.7401 | 0.8201 | 0.8091 |
|  90 | 0.9877 | 0.9879 | 0.7429 | 0.7346 | 0.8345 | 0.8277 |
| 100 | 0.9877 | 0.9879 | 0.7500 | 0.7414 | 0.8453 | 0.8397 |

## Selected (best in pool)

- epoch: **70**
- source val acc / F1 (EMA): 0.9877 / 0.9879
- 77GHz dev   acc / F1: 0.7571 / 0.7471
- 77GHz final acc / F1: 0.8237 / 0.8145
- checkpoint: `EXPERIMENTSRESULT\REVISION_5090\SUPP_ABLATION\ACR_GRL_only\seed42\checkpoints\best_pool_ema.pt`

### dev77 per-class F1
- Away: 0.8500
- Bend: 0.6000
- Kneel: 0.9000
- Pick: 0.8000
- SStep: 0.9500
- Sit: 0.4000
- Towards: 0.8000

### final77 per-class F1
- Away: 0.9500
- Bend: 0.8462
- Kneel: 0.8571
- Pick: 0.8250
- SStep: 1.0000
- Sit: 0.4324
- Towards: 0.8250
