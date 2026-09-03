#!/usr/bin/env bash
# Phase 1 (debug): GRL adversary targeting the BASE carrier log(f_src) instead of
# the DAS'd shown carrier. Tests whether base-targeted GRL moves the 10-vs-24
# carrier probe (which the shown-target GRL did not). Seed 42 only.
set -u
cd "$(dirname "$0")/../../../.."   # repo root
PY="${PY:-python}"   # set PY=<your python> to override
OUT="EXPERIMENTSRESULT/REVISION_5090/GRL_TUNE_BASE"
mkdir -p "$OUT"

export SOURCE_QUALIFIED_METRIC=acc SOURCE_QUALIFIED_MIN_F1=0.0 POOL_THRESHOLD=0.90 POOL_PERIOD=10
export V921_FAST_GPU=1 V921_SKIP_ORACLE=1 V921_SKIP_LAST_CKPT=1 V921_NUM_WORKERS=0 V921_SOURCE_BATCH_SIZE=16
export V921_USE_DAS=1 V921_DAS_MODE=curriculum V921_USE_DANN=0
export V13_FREQ_WEIGHT=0.05 V13_DECORR_WEIGHT=0.0
export V15_KIN_SOURCE_WEIGHT=0 V15_FALSIFY_WEIGHT=0 V15_SENSOR_UNIFORM_WEIGHT=0 V15_CONSIST_WEIGHT=0
export V13_GRL_TARGET=base

for W in 0.3 1.0 3.0; do
  export V13_GRL_WEIGHT="$W"
  export V921_EXPERIMENT_NAME="GRLbase_w${W}"
  RD="$OUT/w${W}_seed42"
  LOG="$OUT/w${W}_seed42.log"
  echo "==== $(date '+%H:%M:%S') START base-GRL weight=$W -> $RD ===="
  "$PY" baseline_v20/train.py --epochs 100 --run-dir "$RD" --seed 42 --progress simple > "$LOG" 2>&1
  echo "==== $(date '+%H:%M:%S') DONE  base-GRL weight=$W (exit $?) ===="
done
echo "==== ALL BASE-GRL TUNE RUNS DONE ===="
