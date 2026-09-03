# Pool selection summary

- threshold: source_val_acc_ema >= 0.90
- period: every 10 epochs
- pool size: 7
- selection metric: dev77_f1

## Members

| epoch | src_val_acc | src_val_F1 | dev77 acc | dev77 F1 | final77 acc | final77 F1 |
|---:|---:|---:|---:|---:|---:|---:|
|  40 | 0.9506 | 0.9510 | 0.5786 | 0.5456 | 0.5863 | 0.5385 |
|  50 | 0.9630 | 0.9626 | 0.7571 | 0.7180 | 0.7626 | 0.7267 |
|  60 | 0.9753 | 0.9757 | 0.8143 | 0.7980 | 0.8201 | 0.7956 |
|  70 | 0.9691 | 0.9695 | 0.8286 | 0.8189 | 0.8489 | 0.8346 |
|  80 | 0.9815 | 0.9818 | 0.8286 | 0.8248 | 0.8705 | 0.8650 |
|  90 | 0.9815 | 0.9818 | 0.8143 | 0.8086 | 0.8741 | 0.8703 |
| 100 | 0.9877 | 0.9878 | 0.8143 | 0.8089 | 0.8885 | 0.8851 |

## Selected (best in pool)

- epoch: **80**
- source val acc / F1 (EMA): 0.9815 / 0.9818
- 77GHz dev   acc / F1: 0.8286 / 0.8248
- 77GHz final acc / F1: 0.8705 / 0.8650
- checkpoint: `EXPERIMENTSRESULT\REVISION_5090\SUPP_ABLATION\SCHED_fixednarrow_ACR\seed1234\checkpoints\best_pool_ema.pt`

### dev77 per-class F1
- Away: 1.0000
- Bend: 0.7000
- Kneel: 0.9000
- Pick: 0.7000
- SStep: 1.0000
- Sit: 0.5500
- Towards: 0.9500

### final77 per-class F1
- Away: 1.0000
- Bend: 0.8718
- Kneel: 0.9286
- Pick: 0.8000
- SStep: 1.0000
- Sit: 0.5676
- Towards: 0.9000
