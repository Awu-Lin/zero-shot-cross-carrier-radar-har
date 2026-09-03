# Pool selection summary

- threshold: source_val_acc_ema >= 0.90
- period: every 10 epochs
- pool size: 7
- selection metric: dev77_f1

## Members

| epoch | src_val_acc | src_val_F1 | dev77 acc | dev77 F1 | final77 acc | final77 F1 |
|---:|---:|---:|---:|---:|---:|---:|
|  40 | 0.9815 | 0.9819 | 0.6214 | 0.5595 | 0.6619 | 0.6052 |
|  50 | 0.9630 | 0.9631 | 0.7429 | 0.7293 | 0.8129 | 0.7913 |
|  60 | 0.9691 | 0.9692 | 0.7786 | 0.7733 | 0.8381 | 0.8306 |
|  70 | 0.9691 | 0.9692 | 0.7929 | 0.7910 | 0.8597 | 0.8570 |
|  80 | 0.9691 | 0.9692 | 0.8071 | 0.8043 | 0.8561 | 0.8532 |
|  90 | 0.9691 | 0.9692 | 0.7929 | 0.7894 | 0.8489 | 0.8458 |
| 100 | 0.9691 | 0.9692 | 0.7857 | 0.7833 | 0.8489 | 0.8457 |

## Selected (best in pool)

- epoch: **80**
- source val acc / F1 (EMA): 0.9691 / 0.9692
- 77GHz dev   acc / F1: 0.8071 / 0.8043
- 77GHz final acc / F1: 0.8561 / 0.8532
- checkpoint: `EXPERIMENTSRESULT\REVISION_5090\SUPP_ABLATION\ACR_GRL_only\seed1234\checkpoints\best_pool_ema.pt`

### dev77 per-class F1
- Away: 0.9500
- Bend: 0.6000
- Kneel: 0.7500
- Pick: 0.9000
- SStep: 0.9500
- Sit: 0.7000
- Towards: 0.8000

### final77 per-class F1
- Away: 1.0000
- Bend: 0.7692
- Kneel: 0.7857
- Pick: 0.8750
- SStep: 1.0000
- Sit: 0.6486
- Towards: 0.9000
