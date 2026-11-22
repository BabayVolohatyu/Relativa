"""List documentation pages whose review_date is before today.

A published page that is overdue fails the process (exit 1).
A deprecated page is listed and does not fail: it stays in the tree
and points at the page that replaced it.
"""

from __future__ import annotations

import sys
from datetime import date
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DOCS = ROOT / "docs"
SKIP = ("ai-guides", "PROMOTION-STRATEGY.md")


def front_matter(text: str) -> dict[str, str]:
    if not text.startswith("---"):
        return {}
    end = text.find("\n---", 3)
    if end < 0:
        return {}
    block = text[3:end]
    found: dict[str, str] = {}
    for line in block.splitlines():
        if ":" not in line or line.startswith(" ") or line.startswith("-"):
            continue
        key, value = line.split(":", 1)
        found[key.strip()] = value.strip()
    return found


def main() -> int:
    today = date.today()
    overdue_published: list[str] = []
    overdue_deprecated: list[str] = []
    missing: list[str] = []

    for path in sorted(DOCS.rglob("*.md")):
        relative = path.relative_to(DOCS).as_posix()
        if relative.startswith(SKIP) or relative in SKIP:
            continue
        meta = front_matter(path.read_text(encoding="utf-8"))
        status = meta.get("status", "")
        raw = meta.get("review_date", "")
        if not raw or not status:
            missing.append(relative)
            continue
        try:
            review = date.fromisoformat(raw)
        except ValueError:
            missing.append(f"{relative} (review_date {raw})")
            continue
        if review >= today:
            continue
        line = f"{relative} status={status} review_date={raw}"
        if status == "deprecated":
            overdue_deprecated.append(line)
        else:
            overdue_published.append(line)

    print(f"review_date audit {today.isoformat()}")
    print("overdue published:")
    for line in overdue_published:
        print(f"  {line}")
    if not overdue_published:
        print("  (none)")
    print("overdue deprecated (kept, not a failure):")
    for line in overdue_deprecated:
        print(f"  {line}")
    if not overdue_deprecated:
        print("  (none)")
    if missing:
        print("missing passport:")
        for line in missing:
            print(f"  {line}")
        return 1
    if overdue_published:
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
