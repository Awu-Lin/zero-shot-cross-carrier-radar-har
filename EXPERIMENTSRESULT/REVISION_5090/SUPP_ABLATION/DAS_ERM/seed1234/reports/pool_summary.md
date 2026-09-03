# Pool selection summary

- threshold: source_val_acc_ema >= 0.90
- period: every 10 epochs
- pool size: 5
- selection metric: dev77_f1

## Members

| epoch | src_val_acc | src_val_F1 | dev77 acc | dev77 F1 | final77 acc | final77 F1 |
|---:|---:|---:|---:|---:|---:|---:|
|  60 | 0.9198 | 0.9213 | 0.3000 | 0.2102 | 0.2554 | 0.1446 |
|  70 | 0.9383 | 0.9394 | 0.3143 | 0.2158 | 0.2806 | 0.1692 |
|  80 | 0.9506 | 0.9518 | 0.3214 | 0.2191 | 0.2878 | 0.1693 |
|  90 | 0.9444 | 0.9455 | 0.3214 | 0.2153 | 0.2914 | 0.1739 |
| 100 | 0.9506 | 0.9516 | 0.3286 | 0.2210 | 0.2950 | 0.1789 |

## Selected (best in pool)

- epoch: **100**
- source val acc / F1 (EMA): 0.9506 / 0.9516
- 77GHz dev   acc / F1: 0.3286 / 0.2210
- 77GHz final acc / F1: 0.2950 / 0.1789
- checkpoint: `EXPERIMENTSRESULT\REVISION_5090\SUPP_ABLATION\DAS_ERM\seed1234\checkpoints\best_pool_ema.pt`

### dev77 per-class F1
- Away: 0.3000
- Bend: 1.0000
- Kneel: 0.0000
- Pick: 0.0000
- SStep: 0.0000
- Sit: 0.0000
- Towards: 1.0000

### final77 per-class F1
- Away: 0.1500
- Bend: 1.0000
- Kneel: 0.0000
- Pick: 0.0000
- SStep: 0.0000
- Sit: 0.0000
- Towards: 0.9250
