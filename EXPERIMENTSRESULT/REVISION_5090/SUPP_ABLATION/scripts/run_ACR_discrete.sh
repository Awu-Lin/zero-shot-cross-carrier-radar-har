#!/usr/bin/env bash
# ============================================================================
# INTRODUCTION
# P0-A config: FULL ACR but with the DISCRETE carrier adversary (V13_GRL_DISCRETE=1, 3-bin CE) --
# the ordinary discrete-domain-adversary control vs our continuous log-carrier regressor.
# ============================================================================

# P0-A : full ACR but with a DISCRETE carrier adversary (the ordinary discrete
# domain-adversary control). DAS curriculum + residual branch ON + GRL head as a
# K-way carrier-BIN classifier (CE) instead of our continuous log-carrier regressor.
source "$(dirname "$0")/_base_env.sh"
export V13_FREQ_WEIGHT=0.05      # residual branch ON (full ACR)
export V13_GRL_WEIGHT=0.3        # GRL adversary ON
export V13_GRL_DISCRETE=1        # <-- discrete K-way carrier-bin classifier (CE)
export V13_GRL_BINS=3
run_supp_config "ACR_discrete"
