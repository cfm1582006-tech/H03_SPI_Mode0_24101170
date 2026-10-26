# Physical macro evidence / Bằng chứng triển khai vật lý

**Status: PASS**

- Top: `tt_um_h03_spi_mode0`
- Raw run: `/mnt/d/H03_SPI_Mode0/DL_24101170_H03/flow/runs/physical_001`
- LibreLane exit: `0`
- Clock analysis constraint: 10 ns
- STA corners checked: 9

| Quantity | Value |
|---|---|
| Synthesis cell count | 144 |
| Final standard-cell count | 282 |
| Final standard-cell area (um²) | 2738.88 |
| Die macro area (um²) | 6527.41 |
| Worst setup slack (ns) | 3.6186685783227395 |
| Worst hold slack (ns) | 0.11128598357824669 |
| Estimated total power metric (W) | 0.0005302242352627218 |

## Explicit violation checks

| Metric | Value |
|---|---|
| `magic__drc_error__count` | 0 |
| `klayout__drc_error__count` | 0 |
| `route__drc_errors` | 0 |
| `design__lvs_error__count` | 0 |
| `design__lvs_unmatched_device__count` | 0 |
| `design__lvs_unmatched_net__count` | 0 |
| `design__lvs_unmatched_pin__count` | 0 |
| `design__xor_difference__count` | 0 |
| `antenna__violating__nets` | 0 |
| `antenna__violating__pins` | 0 |
| `route__antenna_violation__count` | 0 |
| `design__power_grid_violation__count` | 0 |
| `timing__setup_vio__count` | 0 |
| `timing__hold_vio__count` | 0 |
| `design__max_slew_violation__count` | 0 |
| `design__max_cap_violation__count` | 0 |

Per-corner setup, hold, slew and capacitance counts are in `summary.json`.
Selected reports are in `reports/`, final views in `artifacts/`.
Each selected copy has its original path and SHA-256 in `summary.json`.

## Failures

None in the checks listed above.

## Scope and limits

- Macro-level Classic flow; no Tiny Tapeout harness/tile integration or fabrication signoff.
- No RTL/netlist formal-equivalence proof is validated by this collector.
- Functional and gate-level simulation are separate evidence; this collector does not run them.
- Clock 10 ns is an analysis constraint, not a measured maximum operating frequency.
- Power is an OpenROAD activity-based estimate in W, not measured SPI workload power.
- Source snapshots, exact commands and tool versions must accompany the originating flow run.
