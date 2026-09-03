#!/usr/bin/env bash
# ============================================================================
# INTRODUCTION
# Zero-cost GPU watchdog: polls nvidia-smi and auto-launches run_all_formal.sh once the GPU is free
# of other python jobs. Convenience only; not required for reproduction.
# ============================================================================

# Zero-token GPU watchdog: poll nvidia-smi every 60s; once NO python.exe is using
# the GPU for 3 consecutive checks (~3 min, guards against flicker), the user's test
# process is considered finished -> auto-launch the formal supplementary training.
# Pre-authorized by the user: "start training once the GPU is idle".
set -u
cd "$(dirname "$0")/../../../.."   # repo root
SUPP="EXPERIMENTSRESULT/REVISION_5090/SUPP_ABLATION"
WLOG="$SUPP/gpu_wait.log"
ALOG="$SUPP/formal_all.log"
NEED=3            # consecutive idle checks required
PERIOD=60        # seconds between checks

echo "[$(date '+%F %H:%M:%S')] watchdog armed: launch when no python.exe on GPU for ${NEED}x${PERIOD}s" > "$WLOG"

idle=0
tick=0
while true; do
  py=$(nvidia-smi --query-compute-apps=pid,process_name --format=csv,noheader 2>/dev/null | grep -i "python.exe" || true)
  mem=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader 2>/dev/null | head -1)
  util=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader 2>/dev/null | head -1)
  if [ -z "$py" ]; then
    idle=$((idle+1))
    echo "[$(date '+%F %H:%M:%S')] no python.exe on GPU (idle ${idle}/${NEED})  mem=$mem util=$util" >> "$WLOG"
  else
    if [ "$idle" -ne 0 ]; then
      echo "[$(date '+%F %H:%M:%S')] python.exe still present -> reset idle counter  mem=$mem util=$util" >> "$WLOG"
      echo "    procs: $(echo "$py" | tr '\n' ';')" >> "$WLOG"
    elif [ $((tick % 10)) -eq 0 ]; then
      echo "[$(date '+%F %H:%M:%S')] GPU busy (test running)  mem=$mem util=$util" >> "$WLOG"
    fi
    idle=0
  fi
  if [ "$idle" -ge "$NEED" ]; then
    echo "[$(date '+%F %H:%M:%S')] GPU FREE confirmed -> launching formal training (mem=$mem util=$util)" >> "$WLOG"
    break
  fi
  tick=$((tick+1))
  sleep "$PERIOD"
done

echo "[$(date '+%F %H:%M:%S')] >>> run_all_formal.sh START" >> "$WLOG"
bash "$SUPP/scripts/run_all_formal.sh" > "$ALOG" 2>&1
rc=$?
echo "[$(date '+%F %H:%M:%S')] <<< run_all_formal.sh EXIT rc=$rc" >> "$WLOG"
echo "WATCHDOG_DONE rc=$rc"
