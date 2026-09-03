"""Print the 77GHz target-best F1 of a run-dir (arg1). Used by validate_fastgpu.ps1."""
import json
import sys
from pathlib import Path

rep = Path(sys.argv[1]) / "reports"
for name in ("eval_sourcequalified.json", "eval_sourceval.json"):
    f = rep / name
    if f.exists():
        t = json.loads(f.read_text())["test77_final"]
        print(f"{name}: 77GHz acc={t['acc']:.4f} macro_f1={t['macro_f1']:.4f}")
print("paper ref: seed42 ~0.868 (3-seed mean 0.861). Reproduced if within ~0.84-0.88.")
