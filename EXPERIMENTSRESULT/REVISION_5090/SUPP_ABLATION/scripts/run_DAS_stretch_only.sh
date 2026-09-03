#!/usr/bin/env bash
# ============================================================================
# INTRODUCTION
# P0-B config: Doppler-stretch ONLY -- DAS on, HFT/SpecAugment/ACR off (isolates carrier-matched stretch).
# ============================================================================

# P0-B : Doppler-stretch ONLY -- DAS curriculum ON, but NO HFT, NO SpecAugment,
# NO ACR. Isolates the carrier-matched Doppler-axis stretch from generic radar aug.
source "$(dirname "$0")/_base_env.sh"
export V921_USE_DAS=1            # Doppler-stretch ON (curriculum)
export V921_USE_HFT=0            # generic radar aug OFF
export V921_USE_SPEC_AUGMENT=0   # generic radar aug OFF
export V13_FREQ_WEIGHT=0         # ACR OFF
export V13_GRL_WEIGHT=0          # ACR OFF
run_supp_config "DAS_stretch_only"
