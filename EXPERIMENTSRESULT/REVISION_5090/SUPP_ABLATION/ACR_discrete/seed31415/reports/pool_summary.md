# Pool selection summary

- threshold: source_val_acc_ema >= 0.90
- period: every 10 epochs
- pool size: 7
- selection metric: dev77_f1

## Members

| epoch | src_val_acc | src_val_F1 | dev77 acc | dev77 F1 | final77 acc | final77 F1 |
|---:|---:|---:|---:|---:|---:|---:|
|  40 | 0.9444 | 0.9455 | 0.5643 | 0.4755 | 0.6223 | 0.5265 |
|  50 | 0.9444 | 0.9455 | 0.6929 | 0.6449 | 0.7194 | 0.6602 |
|  60 | 0.9444 | 0.9450 | 0.7643 | 0.7471 | 0.8165 | 0.8017 |
|  70 | 0.9630 | 0.9635 | 0.8071 | 0.8009 | 0.8561 | 0.8510 |
|  80 | 0.9630 | 0.9635 | 0.8143 | 0.8086 | 0.8597 | 0.8559 |
|  90 | 0.9630 | 0.9635 | 0.8143 | 0.8098 | 0.8669 | 0.8642 |
| 100 | 0.9630 | 0.9635 | 0.8071 | 0.8017 | 0.8669 | 0.8650 |

## Selected (best in pool)

- epoch: **90**
- source val acc / F1 (EMA): 0.9630 / 0.9635
- 77GHz dev   acc / F1: 0.8143 / 0.8098
- 77GHz final acc / F1: 0.8669 / 0.8642
- checkpoint: `EXPERIMENTSRESULT\REVISION_5090\SUPP_ABLATION\ACR_discrete\seed31415\checkpoints\best_pool_ema.pt`

### dev77 per-class F1
- Away: 1.0000
- Bend: 0.7000
- Kneel: 0.9500
- Pick: 0.5500
- SStep: 1.0000
- Sit: 0.6500
- Towards: 0.8500

### final77 per-class F1
- Away: 1.0000
- Bend: 0.8718
- Kneel: 0.9762
- Pick: 0.7000
- SStep: 1.0000
- Sit: 0.7297
- Towards: 0.7750
