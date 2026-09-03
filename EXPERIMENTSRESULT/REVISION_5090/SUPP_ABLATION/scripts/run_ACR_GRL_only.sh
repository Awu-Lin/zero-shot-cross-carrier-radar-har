#!/usr/bin/env bash
# ============================================================================
# INTRODUCTION
# P0-A config: ACR continuous-GRL adversary ONLY (V13_FREQ_WEIGHT=0), no residual branch.
# ============================================================================

# P0-A : ACR GRL adversary ONLY (no residual branch). DAS curriculum + continuous
# log-carrier GRL on z_cls, residual regression OFF. Isolates the adversarial half.
source "$(dirname "$0")/_base_env.sh"
export V13_FREQ_WEIGHT=0         # residual branch OFF
export V13_GRL_WEIGHT=0.3        # GRL adversary ON (continuous)
run_supp_config "ACR_GRL_only"
