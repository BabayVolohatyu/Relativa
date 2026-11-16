"""Join Lizard cyclomatic complexity with Git churn for the lab 7 hotspot matrix.

Scans **/src/**/*.cs, skipping bin, obj, Migrations, Designer files, and
.sonarqube. Writes complexity.json plus two quadrant files.

90-day quadrants: high complexity is max CCN > 10, high churn is 3 or more
commits, low churn is 0 or 1. Two commits sit between those cuts and get no
quadrant.

Full-history quadrants use the same complexity cut. High churn there is 15
or more commits; anything below that is low churn.
"""

from __future__ import annotations

import argparse
import json
import os
import subprocess
import sys
from pathlib import Path

import lizard

SKIP_DIRS = {"bin", "obj", ".sonarqube", "Migrations", ".git"}
HIGH_CCN = 10
CHURN_90_HIGH = 3
CHURN_90_LOW = 1
CHURN_ALL_HIGH = 15


def repo_root() -> Path:
    out = subprocess.check_output(
        ["git", "rev-parse", "--show-toplevel"],
        text=True,
        encoding="utf-8",
    )
    return Path(out.strip())


def source_files(root: Path) -> list[str]:
    found: list[str] = []
    for dirpath, dirnames, filenames in os.walk(root):
        dirnames[:] = [name for name in dirnames if name not in SKIP_DIRS]
        for name in filenames:
            if not name.endswith(".cs") or name.endswith(".Designer.cs"):
                continue
            path = Path(dirpath) / name
            rel = path.relative_to(root).as_posix()
            parts = rel.split("/")
            if "src" not in parts:
                continue
            if any(part in SKIP_DIRS for part in parts):
                continue
            found.append(rel)
    found.sort()
    return found


def scan_file(root: Path, rel: str) -> dict:
    analysis = lizard.analyze_file(str(root / rel))
    functions = list(analysis.function_list)
    if functions:
        worst = max(functions, key=lambda item: item.cyclomatic_complexity)
        max_ccn = int(worst.cyclomatic_complexity)
        max_name = worst.name
    else:
        max_ccn = 0
        max_name = ""
    return {
        "path": rel,
        "function_count": len(functions),
        "max_ccn": max_ccn,
        "max_ccn_function": max_name,
        "nloc": int(analysis.nloc),
    }


def git_churn(root: Path, since: str | None = None) -> dict[str, int]:
    command = ["git", "log", "--format=format:", "--name-only"]
    if since:
        command.extend(["--since", since])
    raw = subprocess.check_output(
        command,
        cwd=root,
        text=True,
        encoding="utf-8",
        errors="replace",
    )
    counts: dict[str, int] = {}
    for line in raw.splitlines():
        name = line.strip().replace("\\", "/")
        if not name:
            continue
        counts[name] = counts.get(name, 0) + 1
    return counts


def quadrant_90(max_ccn: int, commits: int) -> str | None:
    if commits > CHURN_90_LOW and commits < CHURN_90_HIGH:
        return None
    high_cc = max_ccn > HIGH_CCN
    high_churn = commits >= CHURN_90_HIGH
    if high_cc and high_churn:
        return "High Risk"
    if high_cc:
        return "Sleeping Danger"
    if high_churn:
        return "Active Development"
    return "Stable"


def quadrant_all(max_ccn: int, commits: int) -> str:
    high_cc = max_ccn > HIGH_CCN
    high_churn = commits >= CHURN_ALL_HIGH
    if high_cc and high_churn:
        return "High Risk"
    if high_cc:
        return "Sleeping Danger"
    if high_churn:
        return "Active Development"
    return "Stable"


def with_churn(rows: list[dict], churn: dict[str, int], category) -> list[dict]:
    joined = []
    for row in rows:
        item = dict(row)
        commits = churn.get(row["path"], 0)
        item["commits"] = commits
        item["category"] = category(row["max_ccn"], commits)
        joined.append(item)
    joined.sort(key=lambda item: (-item["commits"], -item["max_ccn"], item["path"]))
    return joined


def counts(rows: list[dict]) -> dict[str, int]:
    summary = {
        "High Risk": 0,
        "Sleeping Danger": 0,
        "Active Development": 0,
        "Stable": 0,
        "unclassified": 0,
    }
    for row in rows:
        key = row["category"] if row["category"] else "unclassified"
        summary[key] = summary.get(key, 0) + 1
    return summary


def write_json(path: Path, payload: dict) -> None:
    path.write_text(json.dumps(payload, indent=2) + "\n", encoding="utf-8")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--out", required=True, help="Directory for JSON reports")
    args = parser.parse_args()

    root = repo_root()
    out = Path(args.out)
    out.mkdir(parents=True, exist_ok=True)

    rows = [scan_file(root, rel) for rel in source_files(root)]
    churn_90 = git_churn(root, "90 days ago")
    churn_all = git_churn(root)
    joined_90 = with_churn(rows, churn_90, quadrant_90)
    joined_all = with_churn(rows, churn_all, quadrant_all)

    write_json(
        out / "complexity.json",
        {
            "scanner": "lizard",
            "language": "csharp",
            "file_count": len(rows),
            "files": rows,
        },
    )
    write_json(
        out / "hotspots-90d.json",
        {
            "window": "90 days",
            "high_ccn_above": HIGH_CCN,
            "high_churn_at": CHURN_90_HIGH,
            "low_churn_at_most": CHURN_90_LOW,
            "quadrant_counts": counts(joined_90),
            "files": joined_90,
        },
    )
    write_json(
        out / "hotspots-all.json",
        {
            "window": "full history",
            "high_ccn_above": HIGH_CCN,
            "high_churn_at": CHURN_ALL_HIGH,
            "quadrant_counts": counts(joined_all),
            "files": joined_all,
        },
    )
    print(f"files={len(rows)} out={out}")
    print("90d", counts(joined_90))
    print("all", counts(joined_all))
    return 0


if __name__ == "__main__":
    sys.exit(main())
