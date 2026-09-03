# Pool selection summary

- threshold: source_val_acc_ema >= 0.90
- period: every 10 epochs
- pool size: 6
- selection metric: dev77_f1

## Members

| epoch | src_val_acc | src_val_F1 | dev77 acc | dev77 F1 | final77 acc | final77 F1 |
|---:|---:|---:|---:|---:|---:|---:|
|  50 | 0.9074 | 0.9080 | 0.6357 | 0.5827 | 0.6619 | 0.5760 |
|  60 | 0.9444 | 0.9447 | 0.6357 | 0.5852 | 0.6871 | 0.6298 |
|  70 | 0.9444 | 0.9447 | 0.6357 | 0.5922 | 0.6871 | 0.6359 |
|  80 | 0.9568 | 0.9572 | 0.6357 | 0.5985 | 0.6691 | 0.6190 |
|  90 | 0.9506 | 0.9501 | 0.6357 | 0.6033 | 0.6727 | 0.6274 |
| 100 | 0.9444 | 0.9438 | 0.6214 | 0.5917 | 0.6835 | 0.6447 |

## Selected (best in pool)

- epoch: **90**
- source val acc / F1 (EMA): 0.9506 / 0.9501
- 77GHz dev   acc / F1: 0.6357 / 0.6033
- 77GHz final acc / F1: 0.6727 / 0.6274
- checkpoint: `EXPERIMENTSRESULT\REVISION_5090\SUPP_ABLATION\SCHED_fixedfull_ACR\seed1234\checkpoints\best_pool_ema.pt`

### dev77 per-class F1
- Away: 0.3000
- Bend: 0.5500
- Kneel: 0.9000
- Pick: 0.8000
- SStep: 1.0000
- Sit: 0.1500
- Towards: 0.7500

### final77 per-class F1
- Away: 0.1500
- Bend: 0.6923
- Kneel: 0.9048
- Pick: 0.8500
- SStep: 1.0000
- Sit: 0.2162
- Towards: 0.8500
