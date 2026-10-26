#!/usr/bin/env python3
"""Run current core/wrapper tests, Classic RTL-to-GDS, and functional GLS.

Invoke inside the LibreLane development environment. Python standard library
only. Raw runs are immutable; curated evidence is saved to evidence/<tag>.
"""
import argparse
import hashlib
import json
import re
import shutil
import subprocess
import sys
import time
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
TOP = "tt_um_h03_spi_mode0"


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def write_json(path, value):
    Path(path).write_text(json.dumps(value, indent=2, ensure_ascii=False,
                                     allow_nan=False) + "\n", encoding="utf-8")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--tag", required=True)
    parser.add_argument("--pdk-root", type=Path, required=True)
    parser.add_argument("--jobs", type=int, default=4)
    args = parser.parse_args()
    if not re.fullmatch(r"[A-Za-z0-9][A-Za-z0-9_-]{0,63}", args.tag):
        parser.error("tag must contain 1-64 letters, digits, underscores or dashes")
    if args.jobs < 1:
        parser.error("jobs must be positive")
    pdk = args.pdk_root.resolve()
    if not (pdk / "sky130A").is_dir():
        parser.error("pdk-root must contain sky130A")
    raw = ROOT / "evidence/runs" / args.tag
    run = ROOT / "flow/runs" / args.tag
    keep = ROOT / "evidence" / args.tag
    for path in (raw, run, keep):
        if path.exists():
            parser.error("Choose a new tag; path already exists: " + str(path))
    for name in ("librelane", "iverilog", "vvp", "git"):
        if not shutil.which(name):
            parser.error("Missing tool in environment: " + name)
    source_names = (
        "rtl/h03_spi_master.sv", "rtl/tt_um_h03_spi_mode0.sv",
        "tb/h03_spi_master_tb.sv", "tb/h03_wrapper_tb.sv",
        "flow/config_wrapper.json", "flow/wrapper.sdc",
        "scripts/run_physical.py", "scripts/collect_physical.py",
        "scripts/run_physical.sh",
    )
    for name in source_names:
        if not (ROOT / name).is_file():
            parser.error("Missing source: " + name)
    raw.mkdir(parents=True, exist_ok=False)
    report = {"status": "RUNNING", "tag": args.tag,
              "started_utc": datetime.now(timezone.utc).isoformat(),
              "root": str(ROOT), "pdk_root": str(pdk),
              "source_sha256": {}, "commands": [], "failures": [],
              "scope": "H4/MSB-first; standalone SKY130 macro; GLS has no SDF; no formal proof."}

    def save():
        write_json(raw / "pipeline.json", report)

    def execute(label, argv, progress=False):
        logfile = raw / (label + ".log")
        print("RUN " + label + "; log: " + str(logfile), flush=True)
        code = 127
        started = datetime.now(timezone.utc).isoformat()
        try:
            with logfile.open("w", encoding="utf-8") as stream:
                process = subprocess.Popen([str(x) for x in argv], cwd=ROOT,
                                           stdout=stream, stderr=subprocess.STDOUT)
                last_stage = None
                while process.poll() is None:
                    time.sleep(2)
                    if progress:
                        text = logfile.read_text(encoding="utf-8", errors="replace")
                        stages = re.findall(r"Running '([^']+)'", text)
                        if stages and stages[-1] != last_stage:
                            last_stage = stages[-1]
                            print("  " + last_stage, flush=True)
                code = process.wait()
        except OSError as exc:
            with logfile.open("a", encoding="utf-8") as stream:
                stream.write(str(exc) + "\n")
        report["commands"].append({"stage": label, "argv": [str(x) for x in argv],
                                   "exit": code, "log": str(logfile), "started_utc": started})
        (raw / (label + "_exit.txt")).write_text("EXIT=%d\n" % code, encoding="utf-8")
        save()
        if not progress:
            text = logfile.read_text(encoding="utf-8", errors="replace")
            for line in text.splitlines():
                if "PASS" in line or "FAIL" in line or "FATAL" in line:
                    print("  " + line, flush=True)
        return code, logfile

    def checked_test(label, sources, wrapper=False, gate=False):
        top = "h03_wrapper_tb" if wrapper else "h03_spi_master_tb"
        binary = raw / (label + ".vvp")
        command = ["iverilog", "-g2012", "-s", top, "-o", binary]
        if gate:
            command.extend(["-DFUNCTIONAL", "-DGATE_LEVEL"])
        else:
            command.append("-Wall")
        command.extend(sources)
        rc, _ = execute(label + "_compile", command)
        if rc:
            raise RuntimeError(label + " compiler failed")
        vcd = raw / (label + ".vcd")
        rc, log = execute(label + "_simulation", ["vvp", binary, "+VCD=" + str(vcd)])
        lines = log.read_text(encoding="utf-8", errors="replace").splitlines()
        prefix, count, marker = (
            ("WRAPPER CASE PASS ", 13, "WRAPPER PASS HC=4 ORDER=1 cases=13") if wrapper else
            ("CASE PASS ", 5, "SIMULATION PASS cases=5 HC=4 ORDER=1"))
        summary_prefix = "WRAPPER PASS " if wrapper else "SIMULATION PASS "
        if (rc or sum(line.startswith(prefix) for line in lines) != count or
                [line for line in lines if line.startswith(summary_prefix)] != [marker] or
                not vcd.is_file() or vcd.stat().st_size == 0):
            raise RuntimeError(label + " result/summary/VCD check failed")
        report[label] = {"status": "PASS", "cases": count}
        save()

    save()
    flow_rc = None
    try:
        for name in source_names:
            source = ROOT / name
            target = raw / "inputs" / name
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(source, target)
            report["source_sha256"][name] = digest(source)
        for label, argv in (
            ("git_head", ["git", "rev-parse", "HEAD"]),
            ("git_status", ["git", "status", "--porcelain=v1", "--untracked-files=normal"]),
            ("librelane_version", ["librelane", "--version"]),
            ("iverilog_version", ["iverilog", "-V"]),
            ("openroad_version", ["openroad", "-version"]),
            ("yosys_version", ["yosys", "-V"]),
        ):
            rc, _ = execute(label, argv)
            if rc and label in ("git_head", "git_status", "librelane_version"):
                raise RuntimeError("Cannot record " + label)
        checked_test("core", [ROOT / "rtl/h03_spi_master.sv", ROOT / "tb/h03_spi_master_tb.sv"])
        checked_test("wrapper", [ROOT / "rtl/h03_spi_master.sv", ROOT / "rtl/tt_um_h03_spi_mode0.sv", ROOT / "tb/h03_wrapper_tb.sv"], wrapper=True)
        flow_rc, _ = execute("flow", ["librelane", "--manual-pdk", "--pdk-root", pdk,
            "--jobs", str(args.jobs), "--condensed", "--run-tag", args.tag,
            ROOT / "flow/config_wrapper.json"], progress=True)
        if flow_rc == 0:
            library = pdk / "sky130A/libs.ref/sky130_fd_sc_hd/verilog"
            checked_test("gate", [library / "primitives.v", library / "sky130_fd_sc_hd.v",
                run / "final/nl" / (TOP + ".nl.v"), ROOT / "tb/h03_wrapper_tb.sv"], wrapper=True, gate=True)
    except (OSError, RuntimeError) as exc:
        report["failures"].append(str(exc))
    if flow_rc is not None:
        rc, _ = execute("collect", [sys.executable, ROOT / "scripts/collect_physical.py",
            "--run-dir", run, "--out", keep, "--flow-exit", str(flow_rc)])
        if rc:
            report["failures"].append("Physical metrics/artifact validation failed")
        if flow_rc:
            report["failures"].append("LibreLane returned " + str(flow_rc))
    else:
        report["failures"].append("Physical flow did not run")
    for name, original in report["source_sha256"].items():
        if digest(ROOT / name) != original:
            report["failures"].append("Source changed during run: " + name)
    report["status"] = "FAIL" if report["failures"] else "PASS"
    report["finished_utc"] = datetime.now(timezone.utc).isoformat()
    save()
    if keep.is_dir():
        shutil.copyfile(raw / "pipeline.json", keep / "pipeline.json")
        shutil.copytree(raw / "inputs", keep / "inputs")
        logs = keep / "pipeline_logs"
        logs.mkdir()
        for path in sorted(raw.iterdir()):
            if path.is_file() and path.suffix in (".log", ".txt", ".vcd"):
                shutil.copyfile(path, logs / path.name)
    if report["status"] == "PASS":
        physical = json.loads((keep / "summary.json").read_text(encoding="utf-8"))
        metrics = physical["metrics"]
        evidence = "../evidence/" + args.tag
        text = """# Ket qua wrapper va RTL den GDSII

Tag: `{tag}`. Xem [pipeline.json]({evidence}/pipeline.json) va
[bao cao physical]({evidence}/summary.md) de truy lenh, hash va tool.

- RTL core: 5 ca PASS, H=4, MSB-first.
- RTL wrapper: 13 tinh huong PASS, gom pinmap/OE, START/ENA va reset giua frame.
- Functional gate simulation: 13 tinh huong PASS, KHONG SDF.
- LibreLane Classic, SKY130A / sky130_fd_sc_hd, clock phan tich 10 ns.
- Setup worst slack: {setup:.6f} ns; hold worst slack: {hold:.6f} ns.
- Magic DRC=0, KLayout DRC=0, LVS error=0; 9 RC/PVT corners duoc kiem tra.
- Die area: {die:.2f} um^2; final standard cells: {cells}.
- Power uoc luong: {power:.6f} mW (hoat dong mac dinh cua tool).

Day la macro doc lap. Chua chung minh formal equivalence, timing SPI ngoai chip
hoac tich hop tile/harness Tiny Tapeout. Clock 10 ns khong phai ket luan Fmax.
Bao cao va slide do nguoi hoc tu thuc hien.
""".format(tag=args.tag, evidence=evidence, setup=metrics["timing__setup__ws"],
           hold=metrics["timing__hold__ws"], die=metrics["design__die__area"],
           cells=metrics["design__instance__count__stdcell"], power=metrics["power__total"] * 1000)
        (ROOT / "docs").mkdir(exist_ok=True)
        (ROOT / "docs/physical_results.md").write_text(text, encoding="utf-8")
        matrix = ROOT / "docs/verification_matrix.md"
        if matrix.is_file():
            content = matrix.read_text(encoding="utf-8-sig")
            content = re.sub(r"(?m)^\| R02 \|.*$",
                "| R02 | Giao dien va wrapper khong xung dot chan | [Wrapper](wrapper.md), [pipeline](" + evidence + "/pipeline.json) | Dat trong 13 tinh huong H4/MSB-first; chua tich hop tile/harness. |", content)
            content = re.sub(r"(?m)^\| R08 \|.*$",
                "| R08 | RTL den GDSII, synthesis/STA/power/DRC/LVS/layout | [Ket qua](physical_results.md), [reports](" + evidence + "/summary.md) | Dat flow macro duoi rang buoc da cong bo; power la uoc luong. |", content)
            content = content.replace("Chưa tích hợp hoặc kiểm thử wrapper.", "Đã kiểm thử wrapper ở mốc physical mới.")
            content = re.sub(r"(?m)^- START trong lúc BUSY.*\n", "", content)
            content = re.sub(r"(?m)^- Reset giữa frame.*\n", "", content)
            content = content.replace("Chưa kiểm các tình huống biên điều khiển như reset giữa frame.",
                "Các tình huống START/ENA/reset được kiểm thêm ở wrapper; xem physical_results.md.")
            content += "\n## Cap nhat wrapper/physical\n\nXem [ket qua moi](physical_results.md): 13 tinh huong RTL wrapper va 13 tinh huong functional GLS; day la mốc bo sung cho bang evidence core/CI phia tren.\n"
            matrix.write_text(content, encoding="utf-8-sig")
        requirements = ROOT / "docs/requirements.md"
        if requirements.is_file():
            content = requirements.read_text(encoding="utf-8-sig").replace(
                "Wrapper và flow RTL đến GDSII chưa được thực hiện cho phiên bản này.",
                "Wrapper và flow RTL đến GDSII đã có kết quả macro; xem [kết quả mới](physical_results.md).")
            requirements.write_text(content, encoding="utf-8-sig")
        readme = ROOT / "README.md"
        if readme.is_file():
            content = readme.read_text(encoding="utf-8-sig").replace(
                "Wrapper, flow RTL đến GDSII và bản báo cáo/slide hoàn chỉnh còn cần thực hiện.",
                "Wrapper và RTL đến GDSII: xem [kết quả macro](docs/physical_results.md). Báo cáo và slide do người học tự thực hiện.")
            heading = "## Wrapper va RTL den GDSII"
            if heading not in content:
                content += "\n" + heading + "\n\n- [Pinmap va kiem thu wrapper](docs/wrapper.md)\n- [Cach chay flow](docs/physical_flow.md)\n- [Ket qua va gioi han](docs/physical_results.md)\n"
            readme.write_text(content, encoding="utf-8-sig")
    print("PHYSICAL PIPELINE " + report["status"], flush=True)
    print("Raw: " + str(raw), flush=True)
    if keep.is_dir():
        print("Evidence: " + str(keep), flush=True)
    for reason in report["failures"]:
        print(" - " + reason, flush=True)
    return 0 if report["status"] == "PASS" else 1


if __name__ == "__main__":
    sys.exit(main())
