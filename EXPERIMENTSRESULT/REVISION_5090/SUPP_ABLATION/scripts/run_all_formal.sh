#!/usr/bin/env bash
# ============================================================================
# INTRODUCTION
# MASTER LAUNCHER: all 7 configs x 3 seeds x 100 ep sequentially (idempotent skip-guard). The exact
# script that produced exact_result_runs/.
# ============================================================================

# FORMAL launch: all 7 new supplementary-ablation configs x 3 seeds x 100 ep.
# Sequential on the single local RTX 5090 (Lider_5090). ~18 min/run x 21 runs ~= 6.3 h.
# DO NOT run until the user says "begin".
#   Run in background via the Bash tool:  bash .../scripts/run_all_formal.sh
set -u
HERE="$(dirname "$0")"
echo "######## SUPP_ABLATION FORMAL START $(date '+%F %H:%M:%S') ########"
for CFG in \
  run_ACR_Lfreq_only.sh \
  run_ACR_GRL_only.sh \
  run_ACR_discrete.sh \
  run_DAS_ERM.sh \
  run_DAS_stretch_only.sh \
  run_SCHED_fixedfull_ACR.sh \
  run_SCHED_fixednarrow_ACR.sh ; do
  echo "######## $(date '+%H:%M:%S') >>> $CFG ########"
  bash "$HERE/$CFG"
done
echo "######## SUPP_ABLATION FORMAL DONE  $(date '+%F %H:%M:%S') ########"
