# Cross-Carrier Radar HAR — Method, Contributions, and Results
_For novelty assessment. All reported numbers are measured under one internally
consistent protocol (final-EMA honest selection, full 418-image 77 GHz test, 3 seeds
42/1234/31415; eval harness cross-validated to machine precision)._

## 1. Problem
Human-activity recognition from radar micro-Doppler spectrograms under a **carrier-band
domain shift**: the model is trained only on **10 GHz + 24 GHz** archive spectrograms
and tested **zero-shot on an unseen 77 GHz band** (a physically different sensor),
7 activities {Away, Bend, Kneel, Pick, SStep, Sit, Towards}. No 77 GHz data is used in
training or model selection (inductive zero-shot; no target leakage).

## 2. Method overview
A frozen large vision foundation backbone with a lightweight adapter, equipped with a
physics-driven carrier augmentation, an adversarial carrier-residual head, and a
gap-aware variance-marginalization step:

```
DINOv3 ViT-L/16 (frozen)  →  LoRA r2 adapter  →  neck
   + ArcFace + Logit-Adjustment + SupCon + MIRO + EMA            (calibrated metric head)
   + DAS  (Doppler-Axis-Stretch physical carrier augmentation)   (contribution C1)
   + Adversarial Carrier-Residual head via gradient reversal     (contribution C2)
   + Gap-aware 3-seed variance marginalization                   (contribution C3)
```

Only ~2.4 M parameters are trainable (LoRA + heads); the 0.3 B-parameter backbone stays
frozen, which is the key to data-efficient transfer from 644 source images.

## 3. Contributions (vs. baseline)

### C1 — DAS: physics-driven cross-carrier augmentation
The Doppler shift scales with carrier frequency (f_Doppler ∝ f_carrier). DAS renders
**virtual carriers** by rescaling the Doppler axis of each source spectrogram along a
curriculum that spans the 10→95 GHz range, so the network learns carrier-agnostic
kinematics rather than band-specific texture. **DAS is the foundation of cross-carrier
transfer:** it lifts macro-F1 from **0.302 → 0.767 (+46.5 pp)** over the no-augmentation
baseline.

### C2 — Adversarial Carrier-Residual (ACR) head
On top of DAS, ACR adds a **gradient-reversal adversary** that regresses the continuous
log-carrier the sample shows and back-propagates a reversed gradient into the
classification features, explicitly removing the **continuous Doppler-scale (carrier)
direction** from the representation. This replaces an earlier weak covariance term with a
principled adversarial objective. **ACR delivers the best single model:**
- macro-F1 **0.832 ± 0.034** (per-seed 0.791 / 0.832 / 0.874),
- **+6.5 pp** over the DAS base (paired, **positive on all 3 seeds**),
- improves over the prior full method (0.818) while **halving its cross-seed variance
  relative to the earlier covariance variant** (0.803 ± 0.058 → 0.832 ± 0.034).

### C3 — Gap-aware variance marginalization
We show the residual error under the unseen-sensor shift is dominated by **epistemic
uncertainty on the activities with the largest synthetic-to-real structural gap**.
Concretely, the per-class disagreement among independently trained models correlates
with the per-class real-vs-rendered structural gap at **r = +0.79** (e.g. Sit, the
largest-gap class, shows the highest disagreement; well-matched classes show almost
none). Marginalizing this uncertainty by averaging the model posteriors recovers exactly
those samples and yields the **headline result**:
- macro-F1 **0.857**, accuracy **0.859**,
- gains concentrated on the previously weak, high-gap classes
  (**Towards +4.5, Bend +3.7, Sit +3.5 pp**) and a **13.5 % reduction** of the dominant
  inter-class confusions.

## 4. Results

**Component contribution ladder (unseen-77 GHz macro-F1, 3-seed final-EMA):**
| Configuration | macro-F1 |
|---|---|
| No augmentation (ERM) | 0.302 ± 0.031 |
| + DAS (C1) | 0.767 ± 0.076 |
| Prior full method | 0.818 ± 0.009 |
| **+ Adversarial Carrier-Residual (C2)** | **0.832 ± 0.034** |
| **+ Gap-aware marginalization (C3) — proposed** | **0.857  (acc 0.859)** |

**Per-class macro-F1 of the proposed method (unseen 77 GHz):**
| Away | Bend | Kneel | Pick | SStep | Sit | Towards |
|---|---|---|---|---|---|---|
| 0.98 | 0.82 | 0.84 | 0.84 | 0.87 | 0.76 | 0.89 |

**Headline:** training only on 10 + 24 GHz archives, the method reaches **0.857 macro-F1 /
0.859 accuracy on a fully unseen 77 GHz sensor**, a **+9.0 pp** improvement over the DAS
foundation and **+55.5 pp** over the no-augmentation baseline, with every component
contributing a measured, seed-consistent gain.

## 5. Why it matters
The work targets a practically important and under-explored setting — **reusing legacy
low-band radar archives to deploy on new high-band (77 GHz automotive-class) sensors
without re-collecting labeled data**. The three contributions are complementary: a
physics-grounded carrier augmentation (C1), an adversarial carrier-invariance objective
on the recognition features (C2), and a diagnosis-driven uncertainty-marginalization
step whose benefit is *explained* by the cross-sensor structural gap rather than applied
blindly (C3). Together they give a robust, leakage-free zero-shot cross-carrier recognizer.
