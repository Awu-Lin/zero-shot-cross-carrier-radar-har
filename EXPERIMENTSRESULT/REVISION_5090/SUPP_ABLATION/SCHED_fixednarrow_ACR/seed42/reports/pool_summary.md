# Pool selection summary

- threshold: source_val_acc_ema >= 0.90
- period: every 10 epochs
- pool size: 7
- selection metric: dev77_f1

## Members

| epoch | src_val_acc | src_val_F1 | dev77 acc | dev77 F1 | final77 acc | final77 F1 |
|---:|---:|---:|---:|---:|---:|---:|
|  40 | 0.9321 | 0.9321 | 0.4500 | 0.3873 | 0.4568 | 0.3727 |
|  50 | 0.9753 | 0.9757 | 0.6357 | 0.5948 | 0.6475 | 0.5910 |
|  60 | 0.9753 | 0.9757 | 0.7000 | 0.6551 | 0.7482 | 0.7123 |
|  70 | 0.9753 | 0.9757 | 0.7214 | 0.6899 | 0.7950 | 0.7642 |
|  80 | 0.9877 | 0.9878 | 0.7786 | 0.7596 | 0.8165 | 0.7882 |
|  90 | 0.9877 | 0.9878 | 0.7857 | 0.7644 | 0.8273 | 0.8062 |
| 100 | 0.9877 | 0.9878 | 0.8000 | 0.7862 | 0.8381 | 0.8204 |

## Selected (best in pool)

- epoch: **100**
- source val acc / F1 (EMA): 0.9877 / 0.9878
- 77GHz dev   acc / F1: 0.8000 / 0.7862
- 77GHz final acc / F1: 0.8381 / 0.8204
- checkpoint: `EXPERIMENTSRESULT\REVISION_5090\SUPP_ABLATION\SCHED_fixednarrow_ACR\seed42\checkpoints\best_pool_ema.pt`

### dev77 per-class F1
- Away: 1.0000
- Bend: 0.7000
- Kneel: 0.9000
- Pick: 0.8000
- SStep: 1.0000
- Sit: 0.3500
- Towards: 0.8500

### final77 per-class F1
- Away: 1.0000
- Bend: 0.7692
- Kneel: 0.9762
- Pick: 0.8250
- SStep: 1.0000
- Sit: 0.3514
- Towards: 0.9000
