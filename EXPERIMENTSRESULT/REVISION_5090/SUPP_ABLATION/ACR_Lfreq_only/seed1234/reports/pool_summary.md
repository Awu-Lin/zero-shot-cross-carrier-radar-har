# Pool selection summary

- threshold: source_val_acc_ema >= 0.90
- period: every 10 epochs
- pool size: 7
- selection metric: dev77_f1

## Members

| epoch | src_val_acc | src_val_F1 | dev77 acc | dev77 F1 | final77 acc | final77 F1 |
|---:|---:|---:|---:|---:|---:|---:|
|  40 | 0.9444 | 0.9452 | 0.5857 | 0.5678 | 0.6079 | 0.5839 |
|  50 | 0.9630 | 0.9627 | 0.7500 | 0.7477 | 0.7914 | 0.7809 |
|  60 | 0.9753 | 0.9755 | 0.7643 | 0.7593 | 0.8381 | 0.8325 |
|  70 | 0.9753 | 0.9754 | 0.7643 | 0.7552 | 0.8489 | 0.8424 |
|  80 | 0.9753 | 0.9754 | 0.7786 | 0.7690 | 0.8561 | 0.8493 |
|  90 | 0.9753 | 0.9754 | 0.8000 | 0.7918 | 0.8597 | 0.8520 |
| 100 | 0.9753 | 0.9754 | 0.8000 | 0.7918 | 0.8525 | 0.8445 |

## Selected (best in pool)

- epoch: **90**
- source val acc / F1 (EMA): 0.9753 / 0.9754
- 77GHz dev   acc / F1: 0.8000 / 0.7918
- 77GHz final acc / F1: 0.8597 / 0.8520
- checkpoint: `EXPERIMENTSRESULT\REVISION_5090\SUPP_ABLATION\ACR_Lfreq_only\seed1234\checkpoints\best_pool_ema.pt`

### dev77 per-class F1
- Away: 0.9500
- Bend: 0.5000
- Kneel: 0.8500
- Pick: 0.8500
- SStep: 1.0000
- Sit: 0.5500
- Towards: 0.9000

### final77 per-class F1
- Away: 1.0000
- Bend: 0.5897
- Kneel: 0.8810
- Pick: 0.9750
- SStep: 1.0000
- Sit: 0.6216
- Towards: 0.9250
