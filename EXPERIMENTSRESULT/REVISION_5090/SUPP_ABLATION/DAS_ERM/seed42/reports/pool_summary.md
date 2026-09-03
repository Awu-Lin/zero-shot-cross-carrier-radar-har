# Pool selection summary

- threshold: source_val_acc_ema >= 0.90
- period: every 10 epochs
- pool size: 6
- selection metric: dev77_f1

## Members

| epoch | src_val_acc | src_val_F1 | dev77 acc | dev77 F1 | final77 acc | final77 F1 |
|---:|---:|---:|---:|---:|---:|---:|
|  50 | 0.9074 | 0.9044 | 0.1571 | 0.0597 | 0.1655 | 0.0750 |
|  60 | 0.9136 | 0.9126 | 0.1643 | 0.0667 | 0.1978 | 0.1085 |
|  70 | 0.9383 | 0.9384 | 0.1857 | 0.0908 | 0.2266 | 0.1269 |
|  80 | 0.9691 | 0.9685 | 0.1929 | 0.0940 | 0.2410 | 0.1323 |
|  90 | 0.9691 | 0.9685 | 0.2071 | 0.1065 | 0.2446 | 0.1313 |
| 100 | 0.9691 | 0.9685 | 0.2071 | 0.1038 | 0.2482 | 0.1291 |

## Selected (best in pool)

- epoch: **90**
- source val acc / F1 (EMA): 0.9691 / 0.9685
- 77GHz dev   acc / F1: 0.2071 / 0.1065
- 77GHz final acc / F1: 0.2446 / 0.1313
- checkpoint: `EXPERIMENTSRESULT\REVISION_5090\SUPP_ABLATION\DAS_ERM\seed42\checkpoints\best_pool_ema.pt`

### dev77 per-class F1
- Away: 0.4500
- Bend: 1.0000
- Kneel: 0.0000
- Pick: 0.0000
- SStep: 0.0000
- Sit: 0.0000
- Towards: 0.0000

### final77 per-class F1
- Away: 0.7250
- Bend: 1.0000
- Kneel: 0.0000
- Pick: 0.0000
- SStep: 0.0000
- Sit: 0.0000
- Towards: 0.0000
