#!/usr/bin/env bash
# ============================================================================
# INTRODUCTION
# Shared base environment for ALL supplementary-ablation training runs (proposed recipe, 100 ep,
# final-EMA). Sourced by every per-config script; defaults reproduce the DAS+ACR anchor.
# run_supp_config() loops the 3 seeds and is IDEMPOTENT (skips a (config,seed) that already has
# epoch_ckpts/ep100.pt). Hard-coded paths target the original repo; adjust to your checkout.
# ============================================================================

# Shared base environment for ALL supplementary-ablation runs (the proposed recipe,
# 100 ep). SOURCE this from each per-config script, then apply per-config overrides
# AFTER sourcing so the override wins. Defaults here reproduce the A_V13_GRL anchor
# (DAS curriculum + full ACR), so each per-config script only states its delta.
#
# Knobs that the per-config scripts may parametrize (env, with defaults):
#   SEEDS   -> "42 1234 31415"   (smoke test passes "42")
#   EPOCHS  -> 100               (smoke test passes 6)
#   OUTROOT -> EXPERIMENTSRESULT/REVISION_5090/SUPP_ABLATION   (smoke -> .../_smoke)
set -u
cd "$(dirname "${BASH_SOURCE[0]}")/../../../.."   # repo root
export PY="${PY:-python}"   # set PY=<your python> to override

# ---- selection / pool protocol (final-EMA honest rule; no target/source-val peek)
export SOURCE_QUALIFIED_METRIC=acc SOURCE_QUALIFIED_MIN_F1=0.0
export POOL_THRESHOLD=0.90 POOL_PERIOD=10
# ---- speed / IO ----
export V921_FAST_GPU=1 V921_SKIP_ORACLE=1 V921_SKIP_LAST_CKPT=1
export V921_NUM_WORKERS=0 V921_SOURCE_BATCH_SIZE=16
# ---- DAS (Doppler-stretch) + radar aug ----
export V921_USE_DAS=1 V921_DAS_MODE=curriculum V921_USE_DANN=0
export V921_USE_HFT=1 V921_USE_SPEC_AUGMENT=1
# ---- ACR (carrier-residual + GRL) : full ACR by default ----
export V13_FREQ_WEIGHT=0.05 V13_DECORR_WEIGHT=0
export V13_GRL_WEIGHT=0.3 V13_GRL_TARGET=shown
export V13_GRL_DISCRETE=0 V13_GRL_BINS=3
# ---- V15 falsification family : OFF (this paper is DAS + ACR only) ----
export V15_KIN_SOURCE_WEIGHT=0 V15_FALSIFY_WEIGHT=0
export V15_SENSOR_UNIFORM_WEIGHT=0 V15_CONSIST_WEIGHT=0
# ---- guarantee a final-epoch EMA (epoch_ckpts/epNNN.pt) even if pool gate unmet ----
export DUMP_EPOCH_CKPTS=1

# Defaults for the parametrized knobs (per-config scripts can override before run).
SEEDS="${SEEDS:-42 1234 31415}"
EPOCHS="${EPOCHS:-100}"
OUTROOT="${OUTROOT:-EXPERIMENTSRESULT/REVISION_5090/SUPP_ABLATION}"

# run_supp_config <CONFIG_NAME> : loops SEEDS, trains EPOCHS ep into
#   $OUTROOT/<CONFIG_NAME>/seed<seed>/ , logging to .../seed<seed>.log .
run_supp_config () {
  local CFG="$1"
  local OUT="$OUTROOT/$CFG"
  mkdir -p "$OUT"
  export V921_EXPERIMENT_NAME="$CFG"
  echo "==== CONFIG=$CFG  EPOCHS=$EPOCHS  SEEDS=[$SEEDS]  OUT=$OUT ===="
  echo "     V921_USE_DAS=$V921_USE_DAS DAS_MODE=$V921_DAS_MODE USE_HFT=$V921_USE_HFT USE_SPEC_AUGMENT=$V921_USE_SPEC_AUGMENT"
  echo "     V13_FREQ_WEIGHT=$V13_FREQ_WEIGHT V13_GRL_WEIGHT=$V13_GRL_WEIGHT V13_GRL_DISCRETE=$V13_GRL_DISCRETE V13_GRL_BINS=$V13_GRL_BINS"
  # SUPP_DRYRUN=1 -> resolve + print config knobs via the real config.py and EXIT
  # (no training). Lets any config be validated instantly before a formal run.
  if [ "${SUPP_DRYRUN:-0}" = "1" ]; then
    "$PY" -c "import sys; sys.path.insert(0,'baseline_v20'); import config as c; \
print('  [resolved] USE_DAS=%s DAS_MODE=%s USE_HFT=%s USE_SPEC_AUGMENT=%s FREQ_W=%s GRL_W=%s GRL_DISCRETE=%s GRL_BINS=%s'%(\
c.USE_DAS,getattr(c,'DAS_MODE','curriculum'),c.USE_HFT,c.USE_SPEC_AUGMENT,c.V13_FREQ_WEIGHT,c.V13_GRL_WEIGHT,c.V13_GRL_DISCRETE,c.V13_GRL_BINS))"
    return 0
  fi
  local MARK
  MARK=$(printf 'ep%03d.pt' "$EPOCHS")
  for SEED in $SEEDS; do
    local RD="$OUT/seed${SEED}"
    local LOG="$OUT/seed${SEED}.log"
    # Idempotent resume: skip a (config,seed) that already finished (final-epoch
    # EMA present). Lets the whole run be re-launched safely after an interrupt.
    if [ -f "$RD/epoch_ckpts/$MARK" ]; then
      echo "---- $(date '+%H:%M:%S') SKIP  $CFG seed=$SEED (already complete: epoch_ckpts/$MARK) ----"
      continue
    fi
    echo "---- $(date '+%H:%M:%S') START $CFG seed=$SEED ep=$EPOCHS -> $RD ----"
    "$PY" baseline_v20/train.py --epochs "$EPOCHS" --run-dir "$RD" --seed "$SEED" --progress simple > "$LOG" 2>&1
    echo "---- $(date '+%H:%M:%S') DONE  $CFG seed=$SEED (exit $?) ----"
  done
}
