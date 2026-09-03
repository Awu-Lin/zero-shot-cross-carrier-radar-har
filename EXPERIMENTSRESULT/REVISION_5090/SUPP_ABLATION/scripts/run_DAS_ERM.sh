#!/usr/bin/env bash
# ============================================================================
# INTRODUCTION
# P0-B config: true ERM -- no Doppler-stretch, no HFT, no SpecAugment, no ACR (the ablation floor).
# ============================================================================

# P0-B : true ERM -- NO Doppler-stretch, NO HFT, NO SpecAugment, NO ACR. Pins the
# floor of the DAS body ablation (vs E1_noDAS which still had HFT+SpecAug).
source "$(dirname "$0")/_base_env.sh"
export V921_USE_DAS=0            # Doppler-stretch OFF
export V921_USE_HFT=0            # generic radar aug OFF
export V921_USE_SPEC_AUGMENT=0   # generic radar aug OFF
export V13_FREQ_WEIGHT=0         # ACR OFF
export V13_GRL_WEIGHT=0          # ACR OFF
run_supp_config "DAS_ERM"
