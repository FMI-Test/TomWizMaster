#!/usr/bin/env python3
import sys
from pathlib import Path
from datetime import datetime
try:
    import yaml
except Exception:
    yaml = None

ROOT = Path(__file__).resolve().parent.parent

def find_image_dirs(extra_dirs):
    dirs = []
    # Include configured dirs
    for d in extra_dirs:
        p = ROOT / d
        if p.exists() and p.is_dir():
            dirs.append(str(p))
    # Auto-scan a few common image directories (shallow)
    for candidate in [ROOT / 'images'] + [p for p in ROOT.glob('*') if (p / 'images').exists()]:
        img_dir = candidate if candidate.name == 'images' else (candidate / 'images')
        if img_dir.exists() and img_dir.is_dir():
            sp = str(img_dir)
            if sp not in dirs:
                dirs.append(sp)
    return dirs

def load_config(conf_path: Path):
    text = conf_path.read_text(encoding='utf-8')
    if conf_path.suffix.lower() in ('.yaml', '.yml') and yaml is not None:
        return yaml.safe_load(text)
    raise RuntimeError('YAML config required and PyYAML must be installed')

def ensure_dir(path: Path):
    path.mkdir(parents=True, exist_ok=True)

def build_media_plan(conf: dict):
    brand = conf.get('brand', {})
    project = conf.get('project', {})
    discover = conf.get('discover', {})
    audiences = {a['id']: a for a in conf.get('audiences', [])}
    assets = conf.get('assets', [])
    out_plan = ROOT / conf.get('output', {}).get('plan', 'media/output/MEDIA-PLAN.md')
    prompts_dir = ROOT / conf.get('output', {}).get('prompts_dir', 'media/output/prompts')
    ensure_dir(out_plan.parent)
    ensure_dir(prompts_dir)

    image_dirs = []
    if discover.get('scan_images'):
        image_dirs = find_image_dirs(discover.get('extra_image_dirs', []))

    lines = []
    lines.append('# Media Plan — Generated')
    lines.append(f"**Generated:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
    lines.append('## Brand & Accessibility')
    lines.append(f"- Brand: {brand.get('name','')} | Palette: {brand.get('style',{}).get('palette',{})}")
    lines.append(f"- Typography: {brand.get('style',{}).get('typography',{})}")
    lines.append(f"- Accessibility: {brand.get('style',{}).get('accessibility',{})}\n")

    lines.append('## Discovery')
    lines.append(f"- Project: {project.get('name','')}\n- Context files: {project.get('context_files', [])}")
    lines.append(f"- Image dirs: {image_dirs}\n")

    lines.append('## Assets by Audience')

    # Group assets by audience
    audience_to_assets = {}
    for asset in assets:
        for aid in asset.get('audience_targets', []):
            audience_to_assets.setdefault(aid, []).append(asset)

    for aid, aset in audience_to_assets.items():
        ainfo = audiences.get(aid, {'label': aid})
        lines.append(f"### Audience: {ainfo.get('label', aid)}")
        lines.append(f"- Intent: {ainfo.get('intent','')}\n- Tone: {ainfo.get('tone','')}")
        for asset in aset:
            lines.append(f"\n#### Asset: {asset.get('title')} ({asset.get('type')})")
            lines.append(f"- ID: {asset.get('id')} | Format: {asset.get('format')} | Size/Duration: {asset.get('size', asset.get('duration',''))}")
            lines.append(f"- Intended Audience: {asset.get('intended_audience')}")
            lines.append(f"- Description: {asset.get('description')}")
            # Build a prompt file per asset
            prompt_name = f"{asset.get('id')}.prompt.md"
            prompt_path = prompts_dir / prompt_name
            prompt_lines = []
            prompt_lines.append(f"# Prompt: {asset.get('title')} ({asset.get('type')})")
            prompt_lines.append('## Style & Brand')
            prompt_lines.append(f"- Palette: {brand.get('style',{}).get('palette',{})}")
            prompt_lines.append(f"- Typography: {brand.get('style',{}).get('typography',{})}")
            prompt_lines.append('## Accessibility')
            prompt_lines.append(f"- Contrast target: {brand.get('style',{}).get('accessibility',{}).get('contrast_target','')}")
            prompt_lines.append(f"- Alt text required: {brand.get('style',{}).get('accessibility',{}).get('alt_text_required', True)}")
            prompt_lines.append(f"- Captions required: {brand.get('style',{}).get('accessibility',{}).get('captions_required', True)}")
            prompt_lines.append('## Context')
            prompt_lines.append(f"- Project: {project.get('name','')}")
            prompt_lines.append(f"- Files: {project.get('context_files', [])}")
            prompt_lines.append(f"- Image sources: {image_dirs}")
            prompt_lines.append('## Requirements')
            prompt_lines.append(f"- Format: {asset.get('format')} | Size/Duration: {asset.get('size', asset.get('duration',''))}")
            prompt_lines.append(f"- Intended audience: {asset.get('intended_audience')} | Targets: {asset.get('audience_targets', [])}")
            prompt_lines.append('## Draft Instruction Example')
            # Example generator instruction
            if asset.get('type') == 'image':
                prompt_lines.append("Wide banner: Tom & Jerry collaborating, constitution + AI brain, gradient purple→blue; text 'GenAI R&D' + subtitle 'A Constitutional Framework'.")
                prompt_lines.append("Add alt text describing visuals; ensure high contrast per WCAG AA.")
            elif asset.get('type') == 'video':
                prompt_lines.append("60s motion graphic explaining audit pipeline and fail‑closed posture; include captions.")
            elif asset.get('type') == 'audio':
                prompt_lines.append("30s audio spot summarizing UX color semantics and accessibility guidance.")
            prompt_lines.append('\n## Three‑Model Review')
            prompt_lines.append('- Model A: Generate candidates')
            prompt_lines.append('- Model B: Review or provide options')
            prompt_lines.append('- Model C: Decide and finalize (record rationale)')
            prompt_path.write_text("\n".join(prompt_lines), encoding='utf-8')
            lines.append(f"- Prompt: {prompt_path.relative_to(ROOT)}")

    out_plan.write_text("\n".join(lines), encoding='utf-8')


def main():
    if len(sys.argv) < 2:
        print('Usage: generate_media_assets.py <config.yaml>')
        sys.exit(1)
    conf_path = Path(sys.argv[1])
    conf = load_config(conf_path)
    build_media_plan(conf)

if __name__ == '__main__':
    main()
