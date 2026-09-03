#!/usr/bin/env bash
# Phase 1: GRL-weight sweep on SEED 42 only (single 100-ep runs each).
# A_V13_GRL config = DAS + V13-as-GRL (decorr OFF), V15 OFF.
set -u
cd "$(dirname "$0")/../../../.."   # repo root
PY="${PY:-python}"   # set PY=<your python> to override
OUT="EXPERIMENTSRESULT/REVISION_5090/GRL_TUNE"
mkdir -p "$OUT"

# common protocol env (identical to A_V13 except decorr->0 and GRL on, V15 off)
export SOURCE_QUALIFIED_METRIC=acc SOURCE_QUALIFIED_MIN_F1=0.0 POOL_THRESHOLD=0.90 POOL_PERIOD=10
export V921_FAST_GPU=1 V921_SKIP_ORACLE=1 V921_SKIP_LAST_CKPT=1 V921_NUM_WORKERS=0 V921_SOURCE_BATCH_SIZE=16
export V921_USE_DAS=1 V921_DAS_MODE=curriculum V921_USE_DANN=0
export V13_FREQ_WEIGHT=0.05 V13_DECORR_WEIGHT=0.0
export V15_KIN_SOURCE_WEIGHT=0 V15_FALSIFY_WEIGHT=0 V15_SENSOR_UNIFORM_WEIGHT=0 V15_CONSIST_WEIGHT=0

for W in 0.1 0.3 1.0 3.0; do
  export V13_GRL_WEIGHT="$W"
  export V921_EXPERIMENT_NAME="GRL_w${W}"
  RD="$OUT/w${W}_seed42"
  LOG="$OUT/w${W}_seed42.log"
  echo "==== $(date '+%H:%M:%S') START GRL weight=$W -> $RD ===="
  "$PY" baseline_v20/train.py --epochs 100 --run-dir "$RD" --seed 42 --progress simple > "$LOG" 2>&1
  echo "==== $(date '+%H:%M:%S') DONE  GRL weight=$W (exit $?) ===="
done
echo "==== ALL GRL TUNE RUNS DONE ===="
