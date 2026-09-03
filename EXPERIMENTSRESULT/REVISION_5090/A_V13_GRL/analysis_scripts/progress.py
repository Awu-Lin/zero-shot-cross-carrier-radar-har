"""Live dashboard for the REVISION 45-run campaign. Run anytime:
   python progress.py
Shows: runs done / 45, completed results table, and the current run's
epoch/step progress bar + speed + best 77GHz F1 so far."""
import json
import re
from pathlib import Path

OUT = Path(__file__).resolve().parent
CONFIGS = ["A_REF", "A_V13", "A_V15", "A_V20", "E1_noDAS", "E1_DANN", "E1_jitter"]
SEEDS = [42, 1234, 31415, 8253, 44809, 67947, 68398, 71223, 77387, 90954]
RUNS = [(c, s) for c in CONFIGS for s in SEEDS]   # 7 cfg x 10 seeds = 70


def final_f1(rd):
    f = rd / "reports" / "eval_sourcequalified.json"
    if f.exists():
        try:
            return json.loads(f.read_text())["test77_final"]["macro_f1"]
        except Exception:
            return None
    return None


def current_state(rd):
    log = rd / "train.log"
    if not log.exists():
        return None
    txt = log.read_text(errors="ignore")
    ep = step = tot = et = best = None
    tr = re.findall(r"\[train\] ep=(\d+) step=(\d+)/(\d+)", txt)
    if tr:
        ep, step, tot = tr[-1]
    ets = re.findall(r"ep=(\d+)/100 .*?ep_time=([\d.]+)s", txt)
    if ets:
        et = ets[-1][1]
    bs = re.findall(r"best_sourcequalified77_\w+ ep=\d+.*?test77_\w+=[\d.]+/([\d.]+)", txt)
    if bs:
        best = bs[-1]
    return ep, step, tot, et, best


def bar(frac, n=24):
    k = int(frac * n)
    return "#" * k + "." * (n - k)


done, current = [], None
for i, (c, s) in enumerate(RUNS, 1):
    rd = OUT / c / f"seed{s}"
    f1 = final_f1(rd)
    if f1 is not None:
        done.append((i, c, s, f1))
    elif current is None and (rd / "train.log").exists():
        current = (i, c, s, current_state(rd))

N = len(RUNS)
print(f"\n===== REVISION 10-seed campaign: {len(done)}/{N} runs done ({100*len(done)//N}%) =====")
for i, c, s, f1 in done:
    print(f"  [{i:2d}/{N}] {c:12s} seed{s:<6}  77GHz F1 = {f1:.4f}")
if current:
    i, c, s, st = current
    if st:
        ep, step, tot, et, best = st
        ep = int(ep or 0); step = int(step or 0); tot = int(tot or 40)
        epbar = bar(ep / 100)
        spbar = bar(step / tot)
        print(f"\n  >>> RUN {i}/{N}  {c} seed{s}  (RUNNING)")
        print(f"      epoch [{epbar}] {ep}/100")
        print(f"      step  [{spbar}] {step}/{tot}   ~{et or '?'}s/epoch")
        print(f"      best 77GHz F1 so far: {best or 'n/a (still rising)'}")
elif len(done) < N:
    print("\n  (no run currently training — campaign stopped or between runs)")
else:
    print(f"\n  ALL {N} DONE.")
print()
