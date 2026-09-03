# Pool selection summary

- threshold: source_val_acc_ema >= 0.90
- period: every 10 epochs
- pool size: 7
- selection metric: dev77_f1

## Members

| epoch | src_val_acc | src_val_F1 | dev77 acc | dev77 F1 | final77 acc | final77 F1 |
|---:|---:|---:|---:|---:|---:|---:|
|  40 | 0.9506 | 0.9517 | 0.6429 | 0.5664 | 0.6619 | 0.5904 |
|  50 | 0.9630 | 0.9635 | 0.7286 | 0.6833 | 0.7878 | 0.7413 |
|  60 | 0.9691 | 0.9695 | 0.7286 | 0.7104 | 0.7842 | 0.7552 |
|  70 | 0.9815 | 0.9817 | 0.7429 | 0.7321 | 0.7842 | 0.7706 |
|  80 | 0.9815 | 0.9817 | 0.7429 | 0.7314 | 0.7842 | 0.7758 |
|  90 | 0.9753 | 0.9755 | 0.7500 | 0.7414 | 0.8022 | 0.7984 |
| 100 | 0.9753 | 0.9755 | 0.7500 | 0.7414 | 0.8094 | 0.8061 |

## Selected (best in pool)

- epoch: **90**
- source val acc / F1 (EMA): 0.9753 / 0.9755
- 77GHz dev   acc / F1: 0.7500 / 0.7414
- 77GHz final acc / F1: 0.8022 / 0.7984
- checkpoint: `EXPERIMENTSRESULT\REVISION_5090\SUPP_ABLATION\ACR_Lfreq_only\seed42\checkpoints\best_pool_ema.pt`

### dev77 per-class F1
- Away: 0.9500
- Bend: 0.5500
- Kneel: 0.9500
- Pick: 0.7500
- SStep: 0.9500
- Sit: 0.4500
- Towards: 0.6500

### final77 per-class F1
- Away: 0.9750
- Bend: 0.6410
- Kneel: 0.8333
- Pick: 0.8250
- SStep: 0.9750
- Sit: 0.5676
- Towards: 0.7750
