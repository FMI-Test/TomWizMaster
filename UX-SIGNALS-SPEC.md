# UX Signals Spec (Colors & Layout)

**Version:** 1.0
**Status:** Live
**Last Updated:** 2026-01-25

## Color Semantics
- Yellow (#FFC107) — Sensitive Autofill: AI pre‑fills; human must review/confirm.
- Green (#2E7D32) — Safe Action: Primary, reversible; default proceed.
- Red (#C62828) — Destructive/Binding: Irreversible; require 4‑eyes approval.
- Blue (#1976D2) — Review/Info: Diffs, metrics, context; non‑actionable.

### Accessibility
- Provide icon/label plus color; don’t rely on color alone.
- Aim for WCAG AA contrast (≥ 4.5:1) against backgrounds.
- Support high‑contrast mode and grayscale; ensure affordances remain clear.

## Layout Consistency
- LTR:
  - Primary bottom‑right; Secondary bottom‑left; Cancel aligned left or near Secondary.
  - Destructive actions isolated; add confirm and spatial separation.
- RTL:
  - Mirror placements; keep consistency across steps; avoid swapping per page.

## Interaction Hints
- Show input mode near chat (Enter sends / Shift+Enter newline).
- Display reasoning summary when AAK signals active.

## High‑Stake Controls
- 4‑eyes for Red actions and audit bindings.
- Log approvals in Tier‑2 audit (see THINKING‑VISIBILITY‑PROTOCOL.md).
