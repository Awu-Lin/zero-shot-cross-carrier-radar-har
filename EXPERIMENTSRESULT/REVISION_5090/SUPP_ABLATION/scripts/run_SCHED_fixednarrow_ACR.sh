#!/usr/bin/env bash
# ============================================================================
# INTRODUCTION
# P1 config: schedule ablation under ACR -- fixed-narrow DAS band [10,30] GHz from epoch 1 (no curriculum).
# ============================================================================

# P1 : schedule ablation UNDER ACR -- fixed-narrow DAS band ([10,30] GHz, p=1 from
# ep1, Kern-2022 style) with full ACR on. Pairs with SCHED_fixedfull_ACR.
source "$(dirname "$0")/_base_env.sh"
export V921_DAS_MODE=fixed_narrow   # no curriculum; narrow band throughout
# full ACR stays on (V13_FREQ_WEIGHT=0.05, V13_GRL_WEIGHT=0.3 from base)
run_supp_config "SCHED_fixednarrow_ACR"
