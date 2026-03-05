# UI/UX Friction Playbook — Human ↔ AI Co‑Work

**Version:** 1.0  
**Status:** Live  
**Last Updated:** 2026-01-25

Purpose: Domain‑agnostic guidance to reduce UX friction, align with "Don't make me think", and make Human‑AI co‑work fast, clear, and safe.

## Principles
- Clarity over cleverness: defaults should be obvious, not surprising.
- Consistency over novelty: actions shouldn’t move or swap sides.
- Minimal path first: one step at a time in time‑sensitive flows.
- Two‑man rule for high‑stakes: require 4‑eyes before destructive or binding actions.

## Chat vs Desktop: Enter/Newline Defaults
- Desktop editors: Enter inserts newline; suggestions require explicit accept.
- Chat inputs: Enter sends; Shift+Enter inserts newline; allow toggling "Enter to send".
- Recommended defaults:
  - Editor: Accept Suggestion On Enter = off
  - Chat: Enter = send; Shift+Enter = newline; Cmd+Enter = send (mac), Ctrl+Enter (win)
- Provide a visible toggle in chat for "Enter sends" to prevent accidental submits.

## Highlight & Action Signal Scheme (Domain‑Agnostic)
- Yellow (Sensitive Autofill): AI proposes pre‑filled fields requiring human review.
- Green (Action OK): Safe, reversible actions; primary buttons.
- Red (Destructive/Binding): Irreversible or high‑impact; requires 4‑eyes approval.
- Blue (Review/Info): Non‑actionable context, diffs, metrics, links.

### Autocorrect & Authenticity
- Never silently autocorrect user input in binding flows; show a diff and highlight changes in Yellow.
- Provide a visible toggle: “Authenticity mode” (capture raw verbatim; defer heavy corrections).
- Display a hash of the raw input (e.g., SHA‑256) when Tier‑2 audit is active.
- Offer “AAK BIND raw:<id>” to connect input authenticity to the output/audit.

## Layout Rules (LTR / RTL)
- Keep primary actions in a consistent region:
  - LTR: Primary bottom‑right; secondary bottom‑left; cancel top‑right rarely.
  - RTL: Mirror consistently; do not mix regions per page.
- Never alternate primary from right to left across steps.
- Group destructive actions away from primary; add spacing and confirm step.

## Two‑Man Rule (4‑Eyes)
- Scope: Red actions (destructive), binding audits, production pushes.
- Mechanism: Require a second approver or an auditor role with explicit confirmation.
- Evidence: Log approvers and timestamps in Tier‑2 audit (see THINKING‑VISIBILITY‑PROTOCOL.md).
  - Include raw input hash and normalization summary when actions depend on interpreted text.

## Perplexity Case (Pattern)
- Good: Fast answers, inline citations, smooth multi‑paragraph composition.
- Bad: Enter key ambiguity in chat, accidental sends, mixed signal density.
- Fix: Visible "Enter sends" toggle, Shift+Enter hint, consistent button placement.

## Anti‑Friction Checklist
- Show input mode hint near chat box (Enter sends / Shift+Enter newline).
- Keep primary button placement fixed across steps.
- Color‑code actions per scheme (Yellow/Green/Red/Blue).
- Require confirm + 4‑eyes for Red actions.
- Provide a small "Reasoning Summary" for AI actions when AAK signals are active.

## References
- PROMPT‑STYLE.md (signals, minimal path mode)
- FRICTION‑PROTOCOL.md (switches, cost/value gate)
- THINKING‑VISIBILITY‑PROTOCOL.md (Tier‑2 audit)
