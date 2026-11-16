"""Halstead scan of Relativa production C# via multimetric.

Calls multimetric in-process so the Windows command-line limit does not
truncate the file list. overall.operators_uniq is multimetric's union
(get_results_global concatenates tokens, then takes a set).
"""

from __future__ import annotations

import json
import math
import subprocess
import sys
import tempfile
from pathlib import Path

from multimetric.__main__ import parse_args, run

REPO = Path(__file__).resolve().parents[1]
EVIDENCE = Path(__file__).resolve().parent / "evidence"
KEYS = (
    "loc",
    "operators_uniq",
    "operands_uniq",
    "operators_sum",
    "operands_sum",
    "halstead_volume",
    "halstead_difficulty",
    "halstead_effort",
    "halstead_bugprop",
)

ROLE_FILES = {
    "core_domain": "Graph/src/Relativa.Graph/Dashboard/DashboardService.cs",
    "integration": "Graph/src/Relativa.Graph/ML/ResilientMlScoringClient.cs",
    "utility": "Core/src/Relativa.Core.Application/Validators/CreateEntityRequestValidator.cs",
}


def production_sources() -> list[Path]:
    files: list[Path] = []
    for path in REPO.rglob("*.cs"):
        parts = set(path.parts)
        if "src" not in parts:
            continue
        if parts & {"bin", "obj", "Migrations"}:
            continue
        if path.name.endswith(".Designer.cs"):
            continue
        files.append(path)
    return sorted(files)


def derive(n1: float, n2: float, N1: float, N2: float) -> dict[str, float]:
    eta = n1 + n2
    length = N1 + N2
    volume = length * math.log2(eta) if eta > 0 else 0.0
    difficulty = (n1 / 2.0) * (N2 / n2) if n2 else 0.0
    effort = volume * difficulty
    bugs = volume / 3000.0
    return {
        "eta": eta,
        "length": length,
        "volume": volume,
        "difficulty": difficulty,
        "effort": effort,
        "bugs": bugs,
    }


def slim(stats: dict) -> dict:
    return {key: stats.get(key) for key in KEYS}


def scan(files: list[Path]) -> dict:
    args = parse_args([str(path) for path in files])
    return run(args)


def union_check() -> dict:
    with tempfile.TemporaryDirectory() as tmp:
        root = Path(tmp)
        a = root / "A.cs"
        b = root / "B.cs"
        a.write_text("class A { int M() { if (true) return 1; return 0; } }\n", encoding="utf-8")
        b.write_text("class B { int M() { if (false) return 2; return 0; } }\n", encoding="utf-8")
        result = scan([a, b])
        files = result["files"]
        left = files[str(a.resolve())]
        right = files[str(b.resolve())]
        overall = result["overall"]
        summed = left["operators_uniq"] + right["operators_uniq"]
        return {
            "file_a_operators_uniq": left["operators_uniq"],
            "file_b_operators_uniq": right["operators_uniq"],
            "sum_of_file_uniques": summed,
            "overall_operators_uniq": overall["operators_uniq"],
            "is_union": overall["operators_uniq"] < summed,
        }


def best_inversion(rows: list[dict]) -> dict | None:
    eligible = [row for row in rows if row["loc"] >= 30]
    best = None
    for short in eligible:
        for long in eligible:
            if short["path"] == long["path"]:
                continue
            if short["loc"] >= long["loc"]:
                continue
            if short["effort"] <= long["effort"]:
                continue
            if long["loc"] < short["loc"] * 1.5:
                continue
            gap = short["effort"] - long["effort"]
            if best is None or gap > best["effort_gap"]:
                best = {
                    "shorter": short,
                    "longer": long,
                    "effort_gap": gap,
                }
    return best


def main() -> int:
    EVIDENCE.mkdir(parents=True, exist_ok=True)
    sha = subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=REPO, text=True).strip()
    (EVIDENCE / "head-sha.txt").write_text(sha + "\n", encoding="utf-8")

    check = union_check()
    (EVIDENCE / "halstead-union-check.json").write_text(
        json.dumps(check, indent=2) + "\n", encoding="utf-8"
    )
    print("union_check", json.dumps(check))
    if not check["is_union"]:
        print("overall operators_uniq is not a union; refusing to publish it", file=sys.stderr)
        return 1

    files = production_sources()
    print(f"scanning {len(files)} files")
    result = scan(files)

    rows = []
    for path, stats in result["files"].items():
        if not stats:
            continue
        rel = Path(path).resolve().relative_to(REPO).as_posix()
        n1 = float(stats["operators_uniq"])
        n2 = float(stats["operands_uniq"])
        N1 = float(stats["operators_sum"])
        N2 = float(stats["operands_sum"])
        classic = derive(n1, n2, N1, N2)
        rows.append(
            {
                "path": rel,
                "loc": stats.get("loc"),
                "n1": n1,
                "n2": n2,
                "N1": N1,
                "N2": N2,
                "eta": classic["eta"],
                "length": classic["length"],
                "volume": classic["volume"],
                "difficulty": classic["difficulty"],
                "effort": classic["effort"],
                "bugs": classic["bugs"],
                "cli_volume": stats.get("halstead_volume"),
                "cli_difficulty": stats.get("halstead_difficulty"),
                "cli_effort": stats.get("halstead_effort"),
                "cli_bugs": stats.get("halstead_bugprop"),
            }
        )
    rows.sort(key=lambda row: row["effort"], reverse=True)

    overall_stats = result["overall"]
    overall_classic = derive(
        float(overall_stats["operators_uniq"]),
        float(overall_stats["operands_uniq"]),
        float(overall_stats["operators_sum"]),
        float(overall_stats["operands_sum"]),
    )
    payload = {
        "sha": sha,
        "file_count": len(rows),
        "overall_cli": slim(overall_stats),
        "overall_classic": overall_classic,
        "files": rows,
        "top15": rows[:15],
        "inversion": best_inversion(rows),
        "roles": {},
    }
    by_path = {row["path"]: row for row in rows}
    for role, rel in ROLE_FILES.items():
        payload["roles"][role] = by_path.get(rel)

    (EVIDENCE / "halstead-global.json").write_text(
        json.dumps(payload, indent=2) + "\n", encoding="utf-8"
    )

    lines = [
        f"sha={sha}",
        f"files={len(rows)}",
        "overall_operators_uniq=" + str(overall_stats["operators_uniq"]),
        "overall_operands_uniq=" + str(overall_stats["operands_uniq"]),
        "overall_operators_sum=" + str(overall_stats["operators_sum"]),
        "overall_operands_sum=" + str(overall_stats["operands_sum"]),
        "overall_eta=" + format(overall_classic["eta"], ".3f"),
        "overall_length=" + format(overall_classic["length"], ".3f"),
        "overall_volume=" + format(overall_classic["volume"], ".3f"),
        "overall_difficulty=" + format(overall_classic["difficulty"], ".3f"),
        "overall_effort=" + format(overall_classic["effort"], ".3f"),
        "overall_bugs=" + format(overall_classic["bugs"], ".3f"),
        "",
        "top_by_effort",
    ]
    for row in rows[:15]:
        lines.append(
            f"{row['effort']:.3f}\tloc={row['loc']}\t{row['path']}"
        )
    lines.append("")
    lines.append("roles")
    for role, row in payload["roles"].items():
        lines.append(f"{role}\t{json.dumps(row)}")
    lines.append("")
    lines.append("inversion")
    lines.append(json.dumps(payload["inversion"], indent=2))
    text = "\n".join(lines) + "\n"
    (EVIDENCE / "halstead-global.txt").write_text(text, encoding="utf-8")
    print(text)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
