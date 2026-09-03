# Pool selection summary

- threshold: source_val_acc_ema >= 0.90
- period: every 10 epochs
- pool size: 7
- selection metric: dev77_f1

## Members

| epoch | src_val_acc | src_val_F1 | dev77 acc | dev77 F1 | final77 acc | final77 F1 |
|---:|---:|---:|---:|---:|---:|---:|
|  40 | 0.9444 | 0.9451 | 0.5500 | 0.4667 | 0.5863 | 0.4940 |
|  50 | 0.9815 | 0.9818 | 0.6786 | 0.6115 | 0.7014 | 0.6326 |
|  60 | 0.9877 | 0.9878 | 0.7071 | 0.6509 | 0.7410 | 0.6805 |
|  70 | 0.9938 | 0.9939 | 0.7429 | 0.6886 | 0.7914 | 0.7429 |
|  80 | 0.9938 | 0.9939 | 0.7429 | 0.6878 | 0.7878 | 0.7392 |
|  90 | 0.9938 | 0.9939 | 0.7286 | 0.6725 | 0.7878 | 0.7390 |
| 100 | 0.9938 | 0.9939 | 0.7357 | 0.6789 | 0.7914 | 0.7471 |

## Selected (best in pool)

- epoch: **70**
- source val acc / F1 (EMA): 0.9938 / 0.9939
- 77GHz dev   acc / F1: 0.7429 / 0.6886
- 77GHz final acc / F1: 0.7914 / 0.7429
- checkpoint: `EXPERIMENTSRESULT\REVISION_5090\SUPP_ABLATION\SCHED_fixednarrow_ACR\seed31415\checkpoints\best_pool_ema.pt`

### dev77 per-class F1
- Away: 1.0000
- Bend: 0.7500
- Kneel: 0.9500
- Pick: 0.6000
- SStep: 1.0000
- Sit: 0.0000
- Towards: 0.9000

### final77 per-class F1
- Away: 1.0000
- Bend: 0.8718
- Kneel: 1.0000
- Pick: 0.6250
- SStep: 1.0000
- Sit: 0.0811
- Towards: 0.9000
