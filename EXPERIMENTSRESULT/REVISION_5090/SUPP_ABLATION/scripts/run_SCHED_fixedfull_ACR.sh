#!/usr/bin/env bash
# ============================================================================
# INTRODUCTION
# P1 config: schedule ablation under ACR -- fixed-full DAS band [15,140] GHz from epoch 1 (no curriculum).
# ============================================================================

# P1 : schedule ablation UNDER ACR -- fixed-full DAS band ([15,140] GHz, p=1 from
# ep1, no curriculum) with full ACR on. Tests if curriculum matters once ACR is on.
source "$(dirname "$0")/_base_env.sh"
export V921_DAS_MODE=fixed_full   # no curriculum; full band throughout
# full ACR stays on (V13_FREQ_WEIGHT=0.05, V13_GRL_WEIGHT=0.3 from base)
run_supp_config "SCHED_fixedfull_ACR"
