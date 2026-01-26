#!/usr/bin/env python3
import sys
import json
from pathlib import Path
try:
    import yaml
except Exception:
    yaml = None

HEADER_LEVELS = ('#', '##', '###')

def extract_key_points(md_text):
    points = []
    for line in md_text.splitlines():
        if any(line.startswith(h) for h in HEADER_LEVELS):
            # Capture headings as key points
            points.append(line.strip())
        elif line.strip().startswith('- '):
            # Capture top-level bullets
            points.append(line.strip())
    return points[:20]

def build_exec_summary(title, sources, out_path):
    summary_lines = [f"# Executive Summary — {title}", ""]
    for src in sources:
        p = Path(src)
        if not p.exists():
            continue
        text = p.read_text(encoding='utf-8')
        points = extract_key_points(text)
        summary_lines.append(f"## Source: {src}")
        summary_lines.extend(points)
        summary_lines.append("")
    Path(out_path).parent.mkdir(parents=True, exist_ok=True)
    Path(out_path).write_text("\n".join(summary_lines), encoding='utf-8')

def build_deck(title, sections, out_path):
    lines = [f"# {title}", ""]
    for sec in sections:
        stitle = sec.get('title', 'Section')
        sfile = sec.get('file')
        lines.append(f"## {stitle}")
        if sfile and Path(sfile).exists():
            text = Path(sfile).read_text(encoding='utf-8')
            # Include first ~200 lines to keep deck concise
            snippet = "\n".join(text.splitlines()[:200])
            lines.append(snippet)
        lines.append("")
    Path(out_path).parent.mkdir(parents=True, exist_ok=True)
    Path(out_path).write_text("\n".join(lines), encoding='utf-8')

def load_config(path: Path):
    suffix = path.suffix.lower()
    text = path.read_text(encoding='utf-8')
    if suffix in ('.yaml', '.yml') and yaml is not None:
        return yaml.safe_load(text)
    else:
        return json.loads(text)

def main():
    if len(sys.argv) < 2:
        print("Usage: generate_exec_summary.py <config.json>")
        sys.exit(1)
    config_path = Path(sys.argv[1])
    conf = load_config(config_path)
    title = conf.get('title', 'Show & Tell')
    sources = conf.get('exec_summary_sources', [])
    sections = conf.get('deck_sections', [])
    out_exec = conf.get('output', {}).get('exec_summary', 'showtell/output/EXEC-SUMMARY.md')
    out_deck = conf.get('output', {}).get('deck', 'showtell/output/SLIDE-DECK.md')
    build_exec_summary(title, sources, out_exec)
    build_deck(title, sections, out_deck)

if __name__ == '__main__':
    main()
