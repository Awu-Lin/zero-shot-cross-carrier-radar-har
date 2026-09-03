# Pool selection summary

- threshold: source_val_acc_ema >= 0.90
- period: every 10 epochs
- pool size: 7
- selection metric: dev77_f1

## Members

| epoch | src_val_acc | src_val_F1 | dev77 acc | dev77 F1 | final77 acc | final77 F1 |
|---:|---:|---:|---:|---:|---:|---:|
|  40 | 0.9321 | 0.9315 | 0.5286 | 0.4634 | 0.6007 | 0.5322 |
|  50 | 0.9444 | 0.9433 | 0.6000 | 0.5373 | 0.6547 | 0.6083 |
|  60 | 0.9506 | 0.9503 | 0.6357 | 0.5973 | 0.6871 | 0.6527 |
|  70 | 0.9506 | 0.9499 | 0.6429 | 0.6191 | 0.7194 | 0.6893 |
|  80 | 0.9506 | 0.9499 | 0.6500 | 0.6247 | 0.7230 | 0.6999 |
|  90 | 0.9506 | 0.9499 | 0.6500 | 0.6288 | 0.7122 | 0.6923 |
| 100 | 0.9506 | 0.9499 | 0.6571 | 0.6394 | 0.7374 | 0.7272 |

## Selected (best in pool)

- epoch: **100**
- source val acc / F1 (EMA): 0.9506 / 0.9499
- 77GHz dev   acc / F1: 0.6571 / 0.6394
- 77GHz final acc / F1: 0.7374 / 0.7272
- checkpoint: `EXPERIMENTSRESULT\REVISION_5090\SUPP_ABLATION\SCHED_fixedfull_ACR\seed31415\checkpoints\best_pool_ema.pt`

### dev77 per-class F1
- Away: 0.1500
- Bend: 0.4500
- Kneel: 0.8000
- Pick: 0.9000
- SStep: 1.0000
- Sit: 0.6500
- Towards: 0.6500

### final77 per-class F1
- Away: 0.2000
- Bend: 0.6667
- Kneel: 0.8095
- Pick: 0.9750
- SStep: 0.9750
- Sit: 0.9189
- Towards: 0.6250
