#!/usr/bin/env python3
import os
import re
import argparse
from pathlib import Path
from datetime import datetime

ROOT = Path(__file__).resolve().parents[1]
AUDIT_DIR = ROOT / 'Audit'
OUTPUT_DIR = AUDIT_DIR / 'output'
LOGS_DIR = AUDIT_DIR / 'logs' / datetime.now().strftime('%Y-%m-%d')
DEFAULT_REPORT_PATH = OUTPUT_DIR / 'GENERAL-AUDIT-REPORT.md'

STYLE_FILES = ['MARKDOWN-STYLE.md', 'PROMPT-STYLE.md', 'CONSTITUTION.md', 'GUARDRAILS.md']
META_KEYS = ['Version', 'Status', 'Last Updated']

MD_EXT = {'.md'}

def find_relative_links(md_text):
    # Match markdown links [text](path)
    links = re.findall(r"\[[^\]]+\]\(([^)]+)\)", md_text)
    rel_links = []
    for link in links:
        if link.startswith('http://') or link.startswith('https://'):
            continue
        rel_links.append(link)
    return rel_links

def check_metadata(md_text):
    results = {}
    for key in META_KEYS:
        results[key] = (key in md_text)
    return results

def summarize_file(path: Path, root: Path):
    text = path.read_text(encoding='utf-8', errors='ignore')
    meta = check_metadata(text)
    rel_links = find_relative_links(text)
    missing = []
    for key, ok in meta.items():
        if not ok:
            missing.append(key)
    broken = []
    for link in rel_links:
        # Normalize relative path
        target = (path.parent / link).resolve()
        if not target.exists():
            broken.append(link)

    # Safely calculate relative path
    try:
        rel_path = str(path.relative_to(root))
    except ValueError:
        rel_path = str(path)

    return {
        'path': rel_path,
        'missing_meta': missing,
        'broken_links': broken,
        'has_content': len(text.strip()) > 0,
    }

def collect_targets(root: Path, explicit: list[str] | None = None):
    """Collect markdown targets. If explicit paths provided, use those; else scan repo."""
    if explicit:
        paths = []
        for t in explicit:
            p = (root / t).resolve()
            if p.exists() and p.suffix.lower() in MD_EXT:
                paths.append(p)
        return paths
    candidates = []
    for p in root.rglob('*.md'):
        # Avoid hidden folders
        if any(part.startswith('.') for part in p.parts):
            continue
        candidates.append(p)
    return candidates

def build_report(results, report_path: Path, root: Path):
    lines = []
    lines.append('# General Audit Report — HuAI\n')
    lines.append(f'**Date:** {datetime.now().strftime("%Y-%m-%d %H:%M")}')
    lines.append('**Scope:** Markdown files; style, metadata, link integrity')
    lines.append('**Tier Policy:** System-level; prefer RC over prod (ops).\n')

    # Check style sources presence
    lines.append('## Style Sources Presence')
    for sf in STYLE_FILES:
        present = (root / sf).exists()
        lines.append(f'- {sf}: {"✅" if present else "❌"}')
    lines.append('')

    # Summaries
    lines.append('## File Checks')
    issues = 0
    for r in results:
        if r['missing_meta'] or r['broken_links']:
            issues += 1
        lines.append(f'- **{r["path"]}** — '
                     f'Meta missing: {", ".join(r["missing_meta"]) if r["missing_meta"] else "None"}; '
                     f'Broken links: {", ".join(r["broken_links"]) if r["broken_links"] else "None"}')
    lines.append('')

    # Classification (simple heuristic)
    lines.append('## Classification')
    if issues == 0:
        tier = 'rc'  # Resiliency Check passed
        verdict = 'Aligned'
    else:
        tier = 'staging'
        verdict = 'Needs Remediation'
    lines.append(f'- **Verdict:** {verdict}')
    lines.append(f'- **Tier:** {tier}')
    lines.append('')

    # Remediation suggestions
    lines.append('## Remediation (Top 3)')
    lines.append('- Add `Version`, `Status`, `Last Updated` to files missing metadata.')
    lines.append('- Fix broken relative links to ensure navigation integrity.')
    lines.append('- Cross-link core docs (README, CONSTITUTION, GUARDRAILS) where applicable for alignment.')
    lines.append('')

    # Attestation
    lines.append('---')
    lines.append('#### Attestation — Model & Provenance')
    try:
        lines.append(f'- **Report:** {report_path.relative_to(root)}')
    except ValueError:
        lines.append(f'- **Report:** {report_path}')

    logs_dir = root / 'Audit' / 'logs' / datetime.now().strftime('%Y-%m-%d')
    try:
        lines.append(f'- **Log Dir:** {logs_dir.relative_to(root)}')
    except ValueError:
        lines.append(f'- **Log Dir:** {logs_dir}')

    lines.append('- **Mode:** System-level; no production ops')
    lines.append('- **HuAI:** Human & AI collaboration')

    return '\n'.join(lines)

def parse_args():
    ap = argparse.ArgumentParser(description='General Audit (Markdown) — style, metadata, links')
    ap.add_argument('--root', default=str(ROOT), help='Repo root (default: project root)')
    ap.add_argument('--out', default=str(DEFAULT_REPORT_PATH), help='Output report path')
    ap.add_argument('--target', action='append', help='Target markdown path (relative to root). Repeatable.')
    ap.add_argument('--fail-on-issues', action='store_true', help='Exit non-zero if any issues found')
    return ap.parse_args()

def main():
    args = parse_args()
    root = Path(args.root).resolve()
    report_path = Path(args.out).resolve()
    report_path.parent.mkdir(parents=True, exist_ok=True)

    logs_dir = root / 'Audit' / 'logs' / datetime.now().strftime('%Y-%m-%d')
    logs_dir.mkdir(parents=True, exist_ok=True)

    targets = collect_targets(root, args.target)
    results = [summarize_file(p, root) for p in targets]
    report = build_report(results, report_path, root)
    report_path.write_text(report, encoding='utf-8')
    # Print summary to stdout
    issues = sum(1 for r in results if r['missing_meta'] or r['broken_links'])
    status = 'PASS' if issues == 0 else 'FAIL'
    print(f'{status}: {len(results)} files checked; issues: {issues}')
    print(f'Report: {report_path}')
    if args.fail_on_issues and issues:
        return 1
    return 0

if __name__ == '__main__':
    raise SystemExit(main())
