"""Aggregate test77 acc + macro-F1 (mean±std) per config from eval_sourcequalified.json.
Also reports the DAS-curriculum improvement = A_REF (with DAS) vs E1_noDAS (no DAS)."""
import json
import statistics as st
from pathlib import Path

OUT = Path(__file__).resolve().parent
CONFIGS = ["A_REF", "A_V13", "A_V15", "A_V20", "E1_noDAS", "E1_DANN", "E1_jitter",
           "E1B_Pjitter", "E2_narrow", "E2_full", "E3_C0", "E3_C1", "E3_C2", "E4_D1", "E4_D2"]


def read_runs(cfg):
    """seed -> (acc, f1)"""
    out = {}
    base = OUT / cfg
    if not base.exists():
        return out
    for d in base.glob("seed*"):
        f = d / "reports" / "eval_sourcequalified.json"
        if f.exists():
            try:
                t = json.loads(f.read_text())["test77_final"]
                out[d.name.replace("seed", "")] = (float(t["acc"]), float(t["macro_f1"]))
            except Exception:
                pass
    return out


def ms(xs):
    return (st.mean(xs), (st.stdev(xs) if len(xs) > 1 else 0.0))


data = {c: read_runs(c) for c in CONFIGS}

print("=== per-config (all available seeds) ===")
for c in CONFIGS:
    r = data[c]
    if not r:
        continue
    accs = [v[0] for v in r.values()]; f1s = [v[1] for v in r.values()]
    am, asd = ms(accs); fm, fsd = ms(f1s)
    print(f"{c:12s} n={len(r):2d}  acc={am:.4f}±{asd:.4f}  F1={fm:.4f}±{fsd:.4f}")

# DAS-curriculum improvement: A_REF vs E1_noDAS
ref, nod = data["A_REF"], data["E1_noDAS"]
common = sorted(set(ref) & set(nod), key=int)
print("\n=== DAS curriculum improvement (A_REF with DAS  -  E1_noDAS no DAS) ===")
if common:
    ra = ms([ref[s][0] for s in common]); rf = ms([ref[s][1] for s in common])
    na = ms([nod[s][0] for s in common]); nf = ms([nod[s][1] for s in common])
    print(f"matched on {len(common)} common seeds {common}:")
    print(f"  with DAS (A_REF) : acc={ra[0]:.4f}±{ra[1]:.4f}  F1={rf[0]:.4f}±{rf[1]:.4f}")
    print(f"  no DAS (E1_noDAS): acc={na[0]:.4f}±{na[1]:.4f}  F1={nf[0]:.4f}±{nf[1]:.4f}")
    print(f"  >>> DAS gain     : acc +{ra[0]-na[0]:.4f} ({100*(ra[0]-na[0]):.1f} pp)   F1 +{rf[0]-nf[0]:.4f} ({100*(rf[0]-nf[0]):.1f} pp)")
# also A_REF full-seed
ra_all = ms([v[0] for v in ref.values()]); rf_all = ms([v[1] for v in ref.values()])
print(f"\nA_REF all {len(ref)} seeds: acc={ra_all[0]:.4f}±{ra_all[1]:.4f}  F1={rf_all[0]:.4f}±{rf_all[1]:.4f}")
