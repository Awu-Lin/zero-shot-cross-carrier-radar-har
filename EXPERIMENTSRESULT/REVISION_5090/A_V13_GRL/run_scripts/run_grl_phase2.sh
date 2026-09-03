#!/usr/bin/env bash
# Phase 2: chosen config A_V13_GRL = DAS + V13-as-GRL (SHOWN target, weight 0.3),
# V15 OFF, decorr OFF. Seed 42 already trained (GRL_TUNE/w0.3_seed42, copied in);
# here we train the two held-out seeds 1234 and 31415.
set -u
cd "$(dirname "$0")/../../../.."   # repo root
PY="${PY:-python}"   # set PY=<your python> to override
OUT="EXPERIMENTSRESULT/REVISION_5090/A_V13_GRL"
mkdir -p "$OUT"

export SOURCE_QUALIFIED_METRIC=acc SOURCE_QUALIFIED_MIN_F1=0.0 POOL_THRESHOLD=0.90 POOL_PERIOD=10
export V921_FAST_GPU=1 V921_SKIP_ORACLE=1 V921_SKIP_LAST_CKPT=1 V921_NUM_WORKERS=0 V921_SOURCE_BATCH_SIZE=16
export V921_USE_DAS=1 V921_DAS_MODE=curriculum V921_USE_DANN=0
export V13_FREQ_WEIGHT=0.05 V13_DECORR_WEIGHT=0.0
export V15_KIN_SOURCE_WEIGHT=0 V15_FALSIFY_WEIGHT=0 V15_SENSOR_UNIFORM_WEIGHT=0 V15_CONSIST_WEIGHT=0
export V13_GRL_WEIGHT=0.3 V13_GRL_TARGET=shown
export V921_EXPERIMENT_NAME=A_V13_GRL

for SEED in 1234 31415; do
  RD="$OUT/seed${SEED}"
  LOG="$OUT/seed${SEED}.log"
  echo "==== $(date '+%H:%M:%S') START A_V13_GRL seed=$SEED -> $RD ===="
  "$PY" baseline_v20/train.py --epochs 100 --run-dir "$RD" --seed "$SEED" --progress simple > "$LOG" 2>&1
  echo "==== $(date '+%H:%M:%S') DONE  A_V13_GRL seed=$SEED (exit $?) ===="
done
echo "==== A_V13_GRL PHASE2 DONE ===="
