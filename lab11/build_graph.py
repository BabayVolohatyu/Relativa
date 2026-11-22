"""Write lab11/evidence/graph.html from the documentation link bush."""

from __future__ import annotations

import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DOCS = ROOT / "docs"
OUT = Path(__file__).resolve().parent / "evidence" / "graph.html"


def pages() -> list[Path]:
    found = []
    for path in DOCS.rglob("*.md"):
        relative = path.relative_to(DOCS).as_posix()
        if relative.startswith(("ai-guides/", "runbooks/")) or relative == "PROMOTION-STRATEGY.md":
            continue
        found.append(path)
    return sorted(found)


def resolve_wikilink(target: str) -> Path | None:
    target = target.strip()
    if target.endswith(".md"):
        target = target[:-3]
    direct = DOCS / f"{target}.md"
    if direct.exists():
        return direct
    # Vault links are often relative to the repo root (docs/...).
    repo = ROOT / f"{target}.md"
    if repo.exists() and DOCS in repo.parents:
        return repo
    name = Path(target).name + ".md"
    matches = [path for path in pages() if path.name == name]
    if len(matches) == 1:
        return matches[0]
    return None


def main() -> None:
    files = pages()
    edges: list[tuple[str, str]] = []

    def rel(path: Path) -> str:
        return path.relative_to(DOCS).as_posix()

    for path in files:
        text = path.read_text(encoding="utf-8")
        source = rel(path)
        for match in re.finditer(r"\[\[([^\]|#]+)", text):
            dest = resolve_wikilink(match.group(1))
            if dest is not None and dest in files:
                edges.append((source, rel(dest)))
        for match in re.finditer(r"\[[^\]]+\]\(([^)]+)\)", text):
            href = match.group(1).split("#", 1)[0].strip()
            if not href or href.startswith(("http://", "https://", "mailto:")):
                continue
            dest = (path.parent / href).resolve()
            if dest.suffix == "" and dest.is_dir():
                dest = dest / "index.md"
            if dest.suffix != ".md":
                continue
            if dest.exists() and DOCS in dest.parents or dest.parent == DOCS:
                edges.append((source, rel(dest)))

    unique: list[list[str]] = []
    seen: set[tuple[str, str]] = set()
    for pair in edges:
        if pair[0] == pair[1] or pair in seen:
            continue
        seen.add(pair)
        unique.append([pair[0], pair[1]])

    names = [rel(path) for path in files]
    linked = {node for edge in unique for node in edge}
    isolated = [name for name in names if name not in linked]
    html = """<!doctype html>
<meta charset="utf-8">
<title>Relativa knowledge graph</title>
<style>
body { margin:0; background:#1b1b1b; color:#eee; font-family:Segoe UI,sans-serif; }
h1 { font-size:16px; margin:12px 16px; font-weight:600; }
canvas { width:100vw; height:calc(100vh - 44px); display:block; }
</style>
<h1>Граф бази знань: SDD, ISD, ADR, API і розділ розробника з'єднані</h1>
<canvas id="c"></canvas>
<script>
const nodes = __NODES__;
const links = __LINKS__;
const canvas = document.getElementById("c");
const ctx = canvas.getContext("2d");
function size() { canvas.width = innerWidth; canvas.height = innerHeight - 44; }
size();
const pts = nodes.map((id, i) => {
  const ang = (i / nodes.length) * Math.PI * 2;
  return {id, x: canvas.width / 2 + Math.cos(ang) * 320, y: canvas.height / 2 + Math.sin(ang) * 240, vx: 0, vy: 0};
});
const byId = Object.fromEntries(pts.map(p => [p.id, p]));
function tick() {
  for (const a of pts) { a.vx += (canvas.width / 2 - a.x) * 0.008; a.vy += (canvas.height / 2 - a.y) * 0.008; }
  for (let i = 0; i < pts.length; i++) for (let j = i + 1; j < pts.length; j++) {
    const a = pts[i], b = pts[j];
    let dx = a.x - b.x, dy = a.y - b.y, d = Math.hypot(dx, dy) || 1;
    const f = 900 / (d * d);
    a.vx += dx / d * f; a.vy += dy / d * f; b.vx -= dx / d * f; b.vy -= dy / d * f;
  }
  for (const [s, t] of links) {
    const a = byId[s], b = byId[t];
    if (!a || !b) continue;
    let dx = b.x - a.x, dy = b.y - a.y, d = Math.hypot(dx, dy) || 1;
    const f = (d - 150) * 0.02;
    a.vx += dx / d * f; a.vy += dy / d * f; b.vx -= dx / d * f; b.vy -= dy / d * f;
  }
  for (const a of pts) { a.vx *= 0.7; a.vy *= 0.7; a.x += a.vx; a.y += a.vy; }
}
function color(id) {
  if (id.includes("adr/")) return "#c792ea";
  if (id.startsWith("api/")) return "#82aaff";
  if (id.startsWith("developer/")) return "#c3e88d";
  if (id.startsWith("architecture/")) return "#ffcb6b";
  return "#89ddff";
}
function frame() {
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  ctx.strokeStyle = "#777";
  ctx.lineWidth = 1.2;
  for (const [s, t] of links) {
    const a = byId[s], b = byId[t];
    if (!a || !b) continue;
    ctx.beginPath(); ctx.moveTo(a.x, a.y); ctx.lineTo(b.x, b.y); ctx.stroke();
  }
  for (const a of pts) {
    ctx.beginPath(); ctx.fillStyle = color(a.id); ctx.arc(a.x, a.y, 7, 0, Math.PI * 2); ctx.fill();
    ctx.fillStyle = "#eee"; ctx.font = "13px Segoe UI";
    ctx.fillText(a.id.replace(".md", ""), a.x + 10, a.y + 4);
  }
}
for (let i = 0; i < 240; i++) tick();
frame();
</script>
"""
    html = html.replace("__NODES__", json.dumps(names)).replace("__LINKS__", json.dumps(unique))
    OUT.write_text(html, encoding="utf-8")
    print(f"nodes {len(names)} edges {len(unique)}")
    print("isolated", isolated)


if __name__ == "__main__":
    main()
