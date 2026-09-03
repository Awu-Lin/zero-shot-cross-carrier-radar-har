#!/usr/bin/env bash
# ============================================================================
# INTRODUCTION
# PRE-FLIGHT smoke test: runs each of the 7 configs for 6 epochs / 1 seed into throwaway dirs to
# validate the pipeline before the formal 100-epoch runs.
# ============================================================================

# SMOKE TEST (NOT formal training): each of the 7 new config TYPES, 1 seed (42),
# 6 epochs only, into a throwaway dir SUPP_ABLATION/_smoke/<cfg>/ . Confirms each
# pipeline starts/finishes without error/NaN, runs EMA eval (ep>=5), writes a
# checkpoint, and (for the [CODE] configs) that the new path actually fires.
# Throwaway dirs are deleted by the caller after validation.
set -u
HERE="$(dirname "$0")"
export SEEDS="42"
export EPOCHS="6"
export OUTROOT="EXPERIMENTSRESULT/REVISION_5090/SUPP_ABLATION/_smoke"
echo "######## SMOKE START $(date '+%F %H:%M:%S')  EPOCHS=$EPOCHS SEED=$SEEDS ########"
for CFG in \
  run_ACR_Lfreq_only.sh \
  run_ACR_GRL_only.sh \
  run_ACR_discrete.sh \
  run_DAS_ERM.sh \
  run_DAS_stretch_only.sh \
  run_SCHED_fixedfull_ACR.sh \
  run_SCHED_fixednarrow_ACR.sh ; do
  echo "######## $(date '+%H:%M:%S') >>> SMOKE $CFG ########"
  bash "$HERE/$CFG"
done
echo "######## SMOKE DONE  $(date '+%F %H:%M:%S') ########"
