# Pool selection summary

- threshold: source_val_acc_ema >= 0.90
- period: every 10 epochs
- pool size: 7
- selection metric: dev77_f1

## Members

| epoch | src_val_acc | src_val_F1 | dev77 acc | dev77 F1 | final77 acc | final77 F1 |
|---:|---:|---:|---:|---:|---:|---:|
|  40 | 0.9506 | 0.9514 | 0.5786 | 0.4961 | 0.6403 | 0.5663 |
|  50 | 0.9630 | 0.9636 | 0.7500 | 0.7326 | 0.7554 | 0.7031 |
|  60 | 0.9691 | 0.9694 | 0.7500 | 0.7341 | 0.8058 | 0.7882 |
|  70 | 0.9691 | 0.9692 | 0.7643 | 0.7538 | 0.8058 | 0.7904 |
|  80 | 0.9691 | 0.9692 | 0.7571 | 0.7505 | 0.7734 | 0.7647 |
|  90 | 0.9630 | 0.9628 | 0.7429 | 0.7373 | 0.7770 | 0.7711 |
| 100 | 0.9630 | 0.9628 | 0.7286 | 0.7241 | 0.7986 | 0.7945 |

## Selected (best in pool)

- epoch: **70**
- source val acc / F1 (EMA): 0.9691 / 0.9692
- 77GHz dev   acc / F1: 0.7643 / 0.7538
- 77GHz final acc / F1: 0.8058 / 0.7904
- checkpoint: `EXPERIMENTSRESULT\REVISION_5090\SUPP_ABLATION\ACR_discrete\seed1234\checkpoints\best_pool_ema.pt`

### dev77 per-class F1
- Away: 0.9500
- Bend: 0.6000
- Kneel: 0.9500
- Pick: 0.7500
- SStep: 1.0000
- Sit: 0.5000
- Towards: 0.6000

### final77 per-class F1
- Away: 1.0000
- Bend: 0.7949
- Kneel: 0.9286
- Pick: 0.8000
- SStep: 1.0000
- Sit: 0.3514
- Towards: 0.7250
