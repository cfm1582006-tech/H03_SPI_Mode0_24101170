#!/usr/bin/env python3
"""Validate and collect one fresh LibreLane Classic macro run (Python >= 3.9).

This program reads reports only; it never invokes EDA tools, modifies the raw
run, resumes a flow, or substitutes a previous run. A new --out is mandatory.
PASS describes the physical checks listed here, not formal or tile signoff.
"""
import argparse
import hashlib
import json
import math
import shutil
import sys
from datetime import datetime, timezone
from pathlib import Path

ZERO_METRICS = (
    "magic__drc_error__count", "klayout__drc_error__count", "route__drc_errors",
    "design__lvs_error__count", "design__lvs_unmatched_device__count",
    "design__lvs_unmatched_net__count", "design__lvs_unmatched_pin__count",
    "design__xor_difference__count", "antenna__violating__nets",
    "antenna__violating__pins", "route__antenna_violation__count",
    "design__power_grid_violation__count", "timing__setup_vio__count",
    "timing__hold_vio__count", "design__max_slew_violation__count",
    "design__max_cap_violation__count",
)
ENABLED_FLAGS = (
    "RUN_CTS", "RUN_MAGIC_DRC", "RUN_KLAYOUT_DRC", "RUN_LVS",
    "RUN_KLAYOUT_XOR", "RUN_MCSTA",
)
EXPECTED_CORNERS = {
    rc + "_" + pvt for rc in ("nom", "min", "max")
    for pvt in ("tt_025C_1v80", "ss_100C_1v60", "ff_n40C_1v95")
}
PER_CORNER_METRICS = (
    "timing__setup_vio__count", "timing__hold_vio__count",
    "design__max_slew_violation__count", "design__max_cap_violation__count",
)
LIMITATIONS = [
    "Macro-level Classic flow; no Tiny Tapeout harness/tile integration or fabrication signoff.",
    "No RTL/netlist formal-equivalence proof is validated by this collector.",
    "Functional and gate-level simulation are separate evidence; this collector does not run them.",
    "Clock 10 ns is an analysis constraint, not a measured maximum operating frequency.",
    "Power is an OpenROAD activity-based estimate in W, not measured SPI workload power.",
    "Source snapshots, exact commands and tool versions must accompany the originating flow run.",
]


def sha256(path):
    value = hashlib.sha256()
    with Path(path).open("rb") as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b""):
            value.update(block)
    return value.hexdigest()


def read_json(path):
    with Path(path).open(encoding="utf-8-sig") as stream:
        # LibreLane may use Infinity for irrelevant/unconstrained metric slots.
        # Every numeric field used for PASS is checked explicitly for finiteness.
        value = json.load(stream)
    if not isinstance(value, dict):
        raise ValueError("Expected JSON object: " + str(path))
    return value


def write_json(path, value):
    def safe(item):
        if isinstance(item, float) and not math.isfinite(item):
            return repr(item)
        if isinstance(item, dict):
            return {key: safe(child) for key, child in item.items()}
        if isinstance(item, list):
            return [safe(child) for child in item]
        return item
    Path(path).write_text(json.dumps(safe(value), indent=2, ensure_ascii=False,
                                     allow_nan=False) + "\n", encoding="utf-8")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--run-dir", type=Path, required=True)
    parser.add_argument("--out", type=Path, required=True)
    parser.add_argument("--flow-exit", type=int, required=True,
                        help="Actual exit code of the LibreLane invocation")
    parser.add_argument("--top", default="tt_um_h03_spi_mode0")
    parser.add_argument("--clock-period", type=float, default=10.0)
    args = parser.parse_args()
    run, out = args.run_dir.resolve(), args.out.resolve()
    if out.exists():
        parser.error("Output must not exist: " + str(out))
    if out == run or run in out.parents:
        parser.error("Output must be outside the immutable raw run directory")
    if not math.isfinite(args.clock_period) or args.clock_period <= 0:
        parser.error("clock-period must be positive and finite")
    out.mkdir(parents=True, exist_ok=False)
    failures, warnings, selected, copied = [], [], {}, []
    report = {
        "status": "FAIL", "scope": "LibreLane Classic macro physical checks",
        "collected_utc": datetime.now(timezone.utc).isoformat(),
        "run_dir": str(run), "flow_exit": args.flow_exit,
        "expected_top": args.top, "expected_clock_ns": args.clock_period,
        "collector_sha256": sha256(Path(__file__)), "failures": failures,
        "warnings": warnings, "metrics": selected, "copies": copied,
        "artifacts_sha256": {}, "limitations": LIMITATIONS,
    }

    def check_number(metrics, key, zero=False, nonnegative=False, positive=False):
        value = metrics.get(key)
        if isinstance(value, bool) or not isinstance(value, (int, float)) or not math.isfinite(value):
            failures.append("Missing or non-finite numeric metric: " + key)
            return None
        selected[key] = value
        if zero and value != 0:
            failures.append("Nonzero violation: %s=%s" % (key, value))
        if nonnegative and value < 0:
            failures.append("Negative value: %s=%s" % (key, value))
        if positive and value <= 0:
            failures.append("Expected positive value: %s=%s" % (key, value))
        return value

    def copy_file(source, category, required=False, allow_empty=False):
        source = Path(source)
        if not source.is_file() or (not allow_empty and source.stat().st_size == 0):
            if required:
                failures.append("Missing or empty file: " + str(source))
            return
        relative = source.relative_to(run).as_posix()
        # Flat selected copies keep original run-relative paths in this manifest.
        name = relative.replace("/", "__")
        target = out / category / name
        target.parent.mkdir(parents=True, exist_ok=True)
        if target.exists():
            raise RuntimeError("Collection name collision: " + name)
        shutil.copyfile(source, target)
        copied.append({"source_relative": relative, "source_absolute": str(source),
                       "copy": target.relative_to(out).as_posix(),
                       "bytes": source.stat().st_size, "sha256": sha256(source)})

    def one_stage(suffix):
        choices = sorted(path for path in run.iterdir()
                         if path.is_dir() and path.name.endswith("-" + suffix))
        if len(choices) != 1:
            failures.append("Expected exactly one stage %s; found %d" % (suffix, len(choices)))
            return None
        return choices[0]

    try:
        if args.flow_exit != 0:
            failures.append("LibreLane exited with nonzero code: " + str(args.flow_exit))
        if not run.is_dir():
            raise ValueError("Raw run directory does not exist: " + str(run))
        for name in ("flow.log", "warning.log", "error.log"):
            copy_file(run / name, "reports", required=(name == "flow.log"), allow_empty=True)
        copy_file(run / "resolved.json", "reports", required=True)
        copy_file(run / "final/metrics.json", "reports", required=True)
        config = read_json(run / "resolved.json")
        metrics = read_json(run / "final/metrics.json")
        report["resolved_config_sha256"] = sha256(run / "resolved.json")
        report["final_metrics_sha256"] = sha256(run / "final/metrics.json")
        report["librelane_meta"] = config.get("meta", {})
        report["configuration"] = {key: config.get(key) for key in (
            "DESIGN_NAME", "CLOCK_PORT", "CLOCK_PERIOD", "PDK", "PDK_ROOT",
            "STD_CELL_LIBRARY", "SYNTH_PARAMETERS", "RUN_EQY", "RUN_LINTER",
            "ERROR_ON_LINTER_WARNINGS", "LINTER_DISABLE_WARNINGS_BLACKBOX", *ENABLED_FLAGS)}
        for key, expected in (("DESIGN_NAME", args.top), ("CLOCK_PORT", "clk"),
                              ("PDK", "sky130A"), ("STD_CELL_LIBRARY", "sky130_fd_sc_hd")):
            if config.get(key) != expected:
                failures.append("Unexpected %s: %r (expected %r)" % (key, config.get(key), expected))
        clock = config.get("CLOCK_PERIOD")
        if isinstance(clock, bool) or not isinstance(clock, (int, float)) or clock != args.clock_period:
            failures.append("Unexpected CLOCK_PERIOD: " + repr(clock))
        for key in ENABLED_FLAGS:
            if config.get(key) is not True:
                failures.append("Required physical check is not enabled: " + key)
        corners = config.get("STA_CORNERS")
        if not isinstance(corners, list) or not all(isinstance(corner, str) for corner in corners):
            failures.append("STA_CORNERS must be a list of corner names")
            corners = []
        report["sta_corners"] = corners
        if len(corners) != len(set(corners)):
            failures.append("Duplicate STA_CORNERS")
        missing_corners = sorted(EXPECTED_CORNERS - set(corners))
        if missing_corners:
            failures.append("Missing expected SKY130 RC/PVT corners: " + ", ".join(missing_corners))
        for key in ZERO_METRICS:
            check_number(metrics, key, zero=True)
        for corner in corners:
            for base in PER_CORNER_METRICS:
                check_number(metrics, base + "__corner:" + corner, zero=True)
        for key in ("timing__setup__ws", "timing__hold__ws"):
            check_number(metrics, key, nonnegative=True)
        for key in ("design__die__area", "design__core__area",
                    "design__instance__area__stdcell", "design__instance__count__stdcell"):
            check_number(metrics, key, positive=True)
        for key in ("power__total", "power__internal__total",
                    "power__switching__total", "power__leakage__total"):
            check_number(metrics, key, nonnegative=True)
        for key in ("design__lvs_device_difference__count", "design__lvs_net_difference__count",
                    "design__lvs_property_fail__count"):
            if key in metrics:
                check_number(metrics, key, zero=True)
        for key in ("design__instance__count", "design__instance__count__class:sequential_cell"):
            if key in metrics:
                check_number(metrics, key, nonnegative=True)

        for folder, extension in (("gds", ".gds"), ("def", ".def"),
                                  ("nl", ".nl.v"), ("sdc", ".sdc")):
            copy_file(run / "final" / folder / (args.top + extension), "artifacts", required=True)
        for directory in ("spef", "sdf"):
            files = sorted(path for path in (run / "final" / directory).rglob("*") if path.is_file())
            if not files:
                failures.append("No extracted final " + directory.upper())
            for path in files:
                copy_file(path, "artifacts", required=True)
        for path in sorted((run / "final/render").glob("*.png")):
            copy_file(path, "artifacts")
        report["artifacts_sha256"] = {
            path.relative_to(run).as_posix(): sha256(path)
            for path in sorted((run / "final").rglob("*")) if path.is_file()
        }

        synthesis = one_stage("yosys-synthesis")
        sta = one_stage("openroad-stapostpnr")
        if synthesis:
            for relative in ("reports/stat.json", "reports/stat.rpt", "state_out.json", "yosys-synthesis.log"):
                copy_file(synthesis / relative, "reports", required=True)
            for relative in ("reports/latch.rpt", "reports/chk.rpt", "reports/pre_synth_chk.rpt"):
                copy_file(synthesis / relative, "reports", allow_empty=True)
            synth_state = read_json(synthesis / "state_out.json")
            synth_metrics = synth_state.get("metrics", {})
            count = synth_metrics.get("design__instance__count")
            if isinstance(count, bool) or not isinstance(count, int) or count <= 0:
                failures.append("Missing positive synthesis cell count")
            else:
                report["synthesis_cell_count"] = count
            area = synth_metrics.get("design__instance__area")
            if isinstance(area, bool) or not isinstance(area, (int, float)) or not math.isfinite(area) or area <= 0:
                failures.append("Missing positive finite synthesis cell area")
            else:
                report["synthesis_cell_area_um2"] = area
        if sta:
            copy_file(sta / "summary.rpt", "reports", required=True)
            for corner in corners:
                for name in ("checks.rpt", "max.rpt", "min.rpt", "power.rpt"):
                    copy_file(sta / corner / name, "reports", required=True)
        for suffix, names in (
            ("magic-drc", ("magic-drc.log", "reports/drc.magic.rpt")),
            ("klayout-drc", ("klayout-drc.log", "reports/drc.klayout.json")),
            ("netgen-lvs", ("netgen-lvs.log", "reports/lvs.netgen.rpt", "reports/lvs.netgen.json")),
            ("klayout-xor", ("klayout-xor.log", "xor.xml")),
            ("misc-reportmanufacturability", ("manufacturability.rpt",)),
        ):
            stage = one_stage(suffix)
            if stage:
                for name in names:
                    copy_file(stage / name, "reports", required=True)
        warnings.append("Raw warning/error logs are preserved; metric checks do not classify every warning.")
    except (OSError, ValueError, RuntimeError, TypeError) as exc:
        failures.append(str(exc))
    report["status"] = "FAIL" if failures else "PASS"
    write_json(out / "summary.json", report)
    lines = ["# Physical macro evidence / Bằng chứng triển khai vật lý", "",
             "**Status: %s**" % report["status"], "",
             "- Top: `%s`" % args.top, "- Raw run: `%s`" % run,
             "- LibreLane exit: `%s`" % args.flow_exit,
             "- Clock analysis constraint: %g ns" % args.clock_period,
             "- STA corners checked: %d" % len(report.get("sta_corners", [])), "",
             "| Quantity | Value |", "|---|---|"]
    for label, value in (
        ("Synthesis cell count", report.get("synthesis_cell_count", "unavailable")),
        ("Final standard-cell count", selected.get("design__instance__count__stdcell", "unavailable")),
        ("Final standard-cell area (um²)", selected.get("design__instance__area__stdcell", "unavailable")),
        ("Die macro area (um²)", selected.get("design__die__area", "unavailable")),
        ("Worst setup slack (ns)", selected.get("timing__setup__ws", "unavailable")),
        ("Worst hold slack (ns)", selected.get("timing__hold__ws", "unavailable")),
        ("Estimated total power metric (W)", selected.get("power__total", "unavailable")),
    ):
        lines.append("| %s | %s |" % (label, value))
    lines += ["", "## Explicit violation checks", "", "| Metric | Value |", "|---|---|"]
    lines += ["| `%s` | %s |" % (key, selected.get(key, "MISSING")) for key in ZERO_METRICS]
    lines += ["", "Per-corner setup, hold, slew and capacitance counts are in `summary.json`.",
              "Selected reports are in `reports/`, final views in `artifacts/`.",
              "Each selected copy has its original path and SHA-256 in `summary.json`.",
              "", "## Failures", ""]
    lines += ["- " + failure for failure in failures] or ["None in the checks listed above."]
    lines += ["", "## Scope and limits", ""] + ["- " + note for note in LIMITATIONS]
    (out / "summary.md").write_text("\n".join(lines) + "\n", encoding="utf-8")
    print("PHYSICAL COLLECTION %s: %s" % (report["status"], out / "summary.json"))
    for failure in failures:
        print(" - " + failure)
    return 0 if report["status"] == "PASS" else 1


if __name__ == "__main__":
    sys.exit(main())
