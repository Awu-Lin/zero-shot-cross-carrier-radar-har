# Pool selection summary

- threshold: source_val_acc_ema >= 0.90
- period: every 10 epochs
- pool size: 6
- selection metric: dev77_f1

## Members

| epoch | src_val_acc | src_val_F1 | dev77 acc | dev77 F1 | final77 acc | final77 F1 |
|---:|---:|---:|---:|---:|---:|---:|
|  50 | 0.9198 | 0.9207 | 0.2000 | 0.0869 | 0.2302 | 0.1075 |
|  60 | 0.9259 | 0.9277 | 0.2214 | 0.0974 | 0.2554 | 0.1146 |
|  70 | 0.9383 | 0.9404 | 0.2500 | 0.1115 | 0.2734 | 0.1217 |
|  80 | 0.9444 | 0.9460 | 0.2714 | 0.1214 | 0.2770 | 0.1234 |
|  90 | 0.9444 | 0.9460 | 0.2714 | 0.1220 | 0.2806 | 0.1261 |
| 100 | 0.9444 | 0.9460 | 0.2643 | 0.1189 | 0.2770 | 0.1257 |

## Selected (best in pool)

- epoch: **90**
- source val acc / F1 (EMA): 0.9444 / 0.9460
- 77GHz dev   acc / F1: 0.2714 / 0.1220
- 77GHz final acc / F1: 0.2806 / 0.1261
- checkpoint: `EXPERIMENTSRESULT\REVISION_5090\SUPP_ABLATION\DAS_ERM\seed31415\checkpoints\best_pool_ema.pt`

### dev77 per-class F1
- Away: 0.0000
- Bend: 0.9500
- Kneel: 0.0000
- Pick: 0.0000
- SStep: 0.0000
- Sit: 0.0000
- Towards: 0.9500

### final77 per-class F1
- Away: 0.0000
- Bend: 0.9744
- Kneel: 0.0000
- Pick: 0.0000
- SStep: 0.0000
- Sit: 0.0000
- Towards: 1.0000
