# Pool selection summary

- threshold: source_val_acc_ema >= 0.90
- period: every 10 epochs
- pool size: 7
- selection metric: dev77_f1

## Members

| epoch | src_val_acc | src_val_F1 | dev77 acc | dev77 F1 | final77 acc | final77 F1 |
|---:|---:|---:|---:|---:|---:|---:|
|  40 | 0.9383 | 0.9398 | 0.4714 | 0.4004 | 0.4532 | 0.3898 |
|  50 | 0.9630 | 0.9635 | 0.6786 | 0.6681 | 0.7194 | 0.7084 |
|  60 | 0.9753 | 0.9756 | 0.7786 | 0.7753 | 0.8273 | 0.8244 |
|  70 | 0.9691 | 0.9694 | 0.8071 | 0.8039 | 0.8381 | 0.8342 |
|  80 | 0.9691 | 0.9694 | 0.8143 | 0.8132 | 0.8489 | 0.8447 |
|  90 | 0.9691 | 0.9694 | 0.8000 | 0.7984 | 0.8525 | 0.8488 |
| 100 | 0.9691 | 0.9694 | 0.8000 | 0.7967 | 0.8489 | 0.8462 |

## Selected (best in pool)

- epoch: **80**
- source val acc / F1 (EMA): 0.9691 / 0.9694
- 77GHz dev   acc / F1: 0.8143 / 0.8132
- 77GHz final acc / F1: 0.8489 / 0.8447
- checkpoint: `EXPERIMENTSRESULT\REVISION_5090\SUPP_ABLATION\ACR_Lfreq_only\seed31415\checkpoints\best_pool_ema.pt`

### dev77 per-class F1
- Away: 1.0000
- Bend: 0.8000
- Kneel: 0.8000
- Pick: 0.6500
- SStep: 1.0000
- Sit: 0.6500
- Towards: 0.8000

### final77 per-class F1
- Away: 1.0000
- Bend: 0.8718
- Kneel: 0.8095
- Pick: 0.8000
- SStep: 1.0000
- Sit: 0.6486
- Towards: 0.8000
