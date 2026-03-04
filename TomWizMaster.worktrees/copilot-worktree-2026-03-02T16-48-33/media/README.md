# Media‑as‑Text Pipeline

**Version:** 1.0
**Status:** Live
**Last Updated:** 2026‑01‑25

Purpose: Declaratively generate audience‑aware multimedia (images, short videos, audio spots) from repository context and brand configuration. Treat media briefs as text, then automate prompts and outputs.

## Flow
1. Discover sources: scan `images/` paths and project context.
2. Apply brand + audience config: tone, style, accessibility.
3. Generate Media Plan: assets with type, format, duration, audience.
4. Three‑Model Review:
   - Model A: Generate candidate prompts/assets.
   - Model B: Review or provide options.
   - Model C: Decide and finalize.
5. Output artifacts: prompts, briefs, and plan markdown; optional renders via external tools.

## Signals
- AK GO: Proceed with planned assets within guardrails.
- AK STOP: Pause for review; throttle suggestions (Cost/Value Gate).
- 🛑 STOP NOW: Halt output except “Stopped.”

## Files
- `media/config.yaml` — Brand, audiences, assets spec, discovery options
- `media/templates/MEDIA-ASSET-SPEC.md` — Asset spec template
- `scripts/generate_media_assets.py` — Generator: builds Media Plan + prompts
- `media/output/MEDIA-PLAN.md` — Generated plan per audience
- `media/output/prompts/` — Prompt files per asset (optional)

## Run
```bash
python3 scripts/generate_media_assets.py media/config.yaml
```

## Notes
- Rendering (image/video/audio) uses your external tools; we output specs and prompts.
- Accessibility: include alt text, captions, and contrast guidance in prompts.
- Provenance: log asset decisions in audit if distributed externally.

---

#### Footnote — Model & Provenance
- Model: Claude Opus 4.5 (Anthropic)
- Operation: Footnote insertion (completing GPT-5 failed task)
- Date: 2026-01-26
- Commit Ref: 87c0453da8dc93851da7fb86eb0534f1d7d0e137
- Review: AK (requested/audited)
