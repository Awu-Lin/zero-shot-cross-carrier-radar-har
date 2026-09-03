# Pool selection summary

- threshold: source_val_acc_ema >= 0.90
- period: every 10 epochs
- pool size: 7
- selection metric: dev77_f1

## Members

| epoch | src_val_acc | src_val_F1 | dev77 acc | dev77 F1 | final77 acc | final77 F1 |
|---:|---:|---:|---:|---:|---:|---:|
|  40 | 0.9321 | 0.9316 | 0.3714 | 0.2996 | 0.3921 | 0.3258 |
|  50 | 0.9444 | 0.9452 | 0.4500 | 0.3708 | 0.4856 | 0.3941 |
|  60 | 0.9506 | 0.9508 | 0.5143 | 0.4470 | 0.5396 | 0.4592 |
|  70 | 0.9506 | 0.9507 | 0.5500 | 0.4920 | 0.5755 | 0.5067 |
|  80 | 0.9568 | 0.9562 | 0.5786 | 0.5316 | 0.6007 | 0.5415 |
|  90 | 0.9568 | 0.9562 | 0.6000 | 0.5602 | 0.6223 | 0.5721 |
| 100 | 0.9568 | 0.9562 | 0.6214 | 0.5846 | 0.6331 | 0.5865 |

## Selected (best in pool)

- epoch: **100**
- source val acc / F1 (EMA): 0.9568 / 0.9562
- 77GHz dev   acc / F1: 0.6214 / 0.5846
- 77GHz final acc / F1: 0.6331 / 0.5865
- checkpoint: `EXPERIMENTSRESULT\REVISION_5090\SUPP_ABLATION\DAS_stretch_only\seed42\checkpoints\best_pool_ema.pt`

### dev77 per-class F1
- Away: 1.0000
- Bend: 0.9000
- Kneel: 0.9000
- Pick: 0.5500
- SStep: 0.2500
- Sit: 0.1500
- Towards: 0.6000

### final77 per-class F1
- Away: 1.0000
- Bend: 0.8462
- Kneel: 0.8333
- Pick: 0.6250
- SStep: 0.2000
- Sit: 0.0811
- Towards: 0.8000
