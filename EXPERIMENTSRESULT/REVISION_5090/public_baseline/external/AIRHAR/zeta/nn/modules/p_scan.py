"""Local drop-in shim for `zeta.nn.modules.p_scan.pscan` used by RadMamba's SSM.

RadMamba's backbones/SSM.py imports `pscan` from the `zeta` (zetascale) package to run
the selective-scan recurrence  h_t = A_t * h_{t-1} + X_t  (returning the stacked states
`hs`, shape (B, L, ED, N)). We do NOT install zetascale: it pins specific torch/deps and
could downgrade the Lider_5090 torch 2.11 build that runs our own method.

Instead this shim computes the SAME recurrence directly. It is the exact sequential
equivalent of RadMamba's OWN `selective_scan_seq` (already shipped in SSM.py) -- the
parallel scan and the sequential scan are two implementations of one associative recurrence
and are numerically identical. So `pscan=True` here yields the authors' intended result with
zero external dependencies. (L is small after RadMamba's time-downsampling, so the sequential
loop is not a bottleneck.)
"""
import torch


def pscan(A: torch.Tensor, X: torch.Tensor) -> torch.Tensor:
    """Associative scan of the linear recurrence h_t = A_t * h_{t-1} + X_t.

    Args:
        A: (B, L, ED, N) per-step multipliers (deltaA).
        X: (B, L, ED, N) per-step inputs (BX).
    Returns:
        hs: (B, L, ED, N) with hs[:, t] = A[:, t] * hs[:, t-1] + X[:, t], hs[:, -1...]=...
    """
    B, L, ED, N = A.shape
    hs = torch.empty_like(X)
    h = torch.zeros(B, ED, N, device=X.device, dtype=X.dtype)
    for t in range(L):
        h = A[:, t] * h + X[:, t]
        hs[:, t] = h
    return hs
