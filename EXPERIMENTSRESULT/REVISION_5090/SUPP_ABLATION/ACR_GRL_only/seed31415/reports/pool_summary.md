# Pool selection summary

- threshold: source_val_acc_ema >= 0.90
- period: every 10 epochs
- pool size: 7
- selection metric: dev77_f1

## Members

| epoch | src_val_acc | src_val_F1 | dev77 acc | dev77 F1 | final77 acc | final77 F1 |
|---:|---:|---:|---:|---:|---:|---:|
|  40 | 0.9444 | 0.9455 | 0.5643 | 0.4794 | 0.6151 | 0.5265 |
|  50 | 0.9506 | 0.9516 | 0.6857 | 0.6349 | 0.7122 | 0.6521 |
|  60 | 0.9630 | 0.9637 | 0.7786 | 0.7583 | 0.7806 | 0.7525 |
|  70 | 0.9691 | 0.9697 | 0.8429 | 0.8360 | 0.8273 | 0.8186 |
|  80 | 0.9691 | 0.9697 | 0.8500 | 0.8419 | 0.8561 | 0.8517 |
|  90 | 0.9753 | 0.9756 | 0.8357 | 0.8296 | 0.8597 | 0.8538 |
| 100 | 0.9753 | 0.9756 | 0.8357 | 0.8296 | 0.8597 | 0.8532 |

## Selected (best in pool)

- epoch: **80**
- source val acc / F1 (EMA): 0.9691 / 0.9697
- 77GHz dev   acc / F1: 0.8500 / 0.8419
- 77GHz final acc / F1: 0.8561 / 0.8517
- checkpoint: `EXPERIMENTSRESULT\REVISION_5090\SUPP_ABLATION\ACR_GRL_only\seed31415\checkpoints\best_pool_ema.pt`

### dev77 per-class F1
- Away: 1.0000
- Bend: 0.8000
- Kneel: 1.0000
- Pick: 0.8000
- SStep: 1.0000
- Sit: 0.5000
- Towards: 0.8500

### final77 per-class F1
- Away: 0.9750
- Bend: 0.8462
- Kneel: 0.8810
- Pick: 0.7750
- SStep: 1.0000
- Sit: 0.5676
- Towards: 0.9250
