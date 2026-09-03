#!/usr/bin/env bash
# ============================================================================
# INTRODUCTION
# P0-A config: ACR residual branch ONLY (V13_GRL_WEIGHT=0), no GRL adversary.
# ============================================================================

# P0-A : ACR residual branch ONLY (no GRL). DAS curriculum + V13 carrier-residual
# regression (z_freq), GRL adversary OFF. Isolates the residual-split half of ACR.
source "$(dirname "$0")/_base_env.sh"
export V13_FREQ_WEIGHT=0.05      # residual branch ON
export V13_GRL_WEIGHT=0          # GRL adversary OFF
run_supp_config "ACR_Lfreq_only"
