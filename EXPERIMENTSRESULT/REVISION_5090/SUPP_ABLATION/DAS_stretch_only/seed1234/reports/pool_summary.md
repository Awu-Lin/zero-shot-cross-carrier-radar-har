# Pool selection summary

- threshold: source_val_acc_ema >= 0.90
- period: every 10 epochs
- pool size: 7
- selection metric: dev77_f1

## Members

| epoch | src_val_acc | src_val_F1 | dev77 acc | dev77 F1 | final77 acc | final77 F1 |
|---:|---:|---:|---:|---:|---:|---:|
|  40 | 0.9198 | 0.9214 | 0.3786 | 0.3018 | 0.3597 | 0.2889 |
|  50 | 0.9506 | 0.9518 | 0.5429 | 0.5389 | 0.5324 | 0.5165 |
|  60 | 0.9691 | 0.9703 | 0.6714 | 0.6798 | 0.7266 | 0.7259 |
|  70 | 0.9691 | 0.9700 | 0.7571 | 0.7558 | 0.7806 | 0.7782 |
|  80 | 0.9815 | 0.9818 | 0.7714 | 0.7655 | 0.8201 | 0.8163 |
|  90 | 0.9815 | 0.9818 | 0.8071 | 0.8007 | 0.8237 | 0.8165 |
| 100 | 0.9815 | 0.9818 | 0.8000 | 0.7937 | 0.8165 | 0.8087 |

## Selected (best in pool)

- epoch: **90**
- source val acc / F1 (EMA): 0.9815 / 0.9818
- 77GHz dev   acc / F1: 0.8071 / 0.8007
- 77GHz final acc / F1: 0.8237 / 0.8165
- checkpoint: `EXPERIMENTSRESULT\REVISION_5090\SUPP_ABLATION\DAS_stretch_only\seed1234\checkpoints\best_pool_ema.pt`

### dev77 per-class F1
- Away: 0.9500
- Bend: 0.8000
- Kneel: 0.8000
- Pick: 0.9000
- SStep: 1.0000
- Sit: 0.4500
- Towards: 0.7500

### final77 per-class F1
- Away: 0.9750
- Bend: 0.8718
- Kneel: 0.7619
- Pick: 0.7750
- SStep: 1.0000
- Sit: 0.4324
- Towards: 0.9250
