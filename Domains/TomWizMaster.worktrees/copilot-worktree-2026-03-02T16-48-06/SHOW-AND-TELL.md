# Show & Tell — From Docs to Slides/PDF/Exec Summary

**Version:** 1.0
**Status:** Live
**Last Updated:** 2026-01-25

Purpose: Reduce friction by generating slide decks, PDFs, and executive summaries from existing Markdown docs with a simple config file.

## Outputs
- Slide Deck (Markdown → deck template)
- Executive Summary (auto-compiled from headings and key blocks)
- PDF (via external tools like Pandoc; optional)

## Config
Prefer YAML for clarity and comments. Use `showtell/config.yaml` to declare sources and targets.

Example (YAML):
```yaml
title: GenAI R&D — Show & Tell
exec_summary_sources:
  - README.md
  - COMPLIANCE.md
  - FRICTION-PROTOCOL.md
  - AUDIT-ARCHITECTURE.md
deck_sections:
  - title: Overview
    file: README.md
  - title: Guardrails
    file: GUARDRAILS.md
  - title: Friction Protocol
    file: FRICTION-PROTOCOL.md
  - title: Audit Architecture
    file: AUDIT-ARCHITECTURE.md
  - title: Model & Provenance
    file: audit/templates/MODEL-PROVENANCE-TEMPLATE.md
emoji_palette: EMOJI-PALETTE.yaml
output:
  exec_summary: showtell/output/EXEC-SUMMARY.md
  deck: showtell/output/SLIDE-DECK.md
change_log:
  - 2026-01-25: Initial config created
```

JSON remains supported via `showtell/config.json` if YAML isn’t available.

## Run (optional)
Use the generator to build the summary and deck (YAML or JSON):

```bash
python scripts/generate_exec_summary.py showtell/config.yaml
```

To produce PDF/PPT, use your local tools (e.g., Pandoc):

```bash
pandoc showtell/output/SLIDE-DECK.md -o showtell/output/SLIDE-DECK.pdf
```

## Templates
- `showtell/templates/SLIDE-DECK-TEMPLATE.md` — section scaffolding
- `showtell/templates/EXEC-SUMMARY-TEMPLATE.md` — concise summary format

## Emoji & UX
- Default palette in [EMOJI-COMPRESSION.md](EMOJI-COMPRESSION.md); override via `EMOJI-PALETTE.yaml`.
- Keep accessibility: emoji + text labels.

## Links
- PROMPT-STYLE.md (signals)
- FRICTION-PROTOCOL.md (switches)
- AUDIT-ARCHITECTURE.md (audit)
