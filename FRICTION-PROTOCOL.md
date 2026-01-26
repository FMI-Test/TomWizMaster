# Friction-Removal Protocol (Human ↔ AI)

**Version:** 1.0
**Status:** Live
**Source of Truth:** https://github.com/FMI-Test/GenAI-RD/tree/main
**Last Updated:** 2026-01-25

---

## Goal
Reduce FEED- and restore the Neutral Baseline (“Zero”) during Human ↔ AI collaboration.

---

## Protocol Switches (Detect → Switch → Stabilize)
1. Words failing → Switch to Music (playlist anchor)
2. Logic failing → Switch to Emoji (compression palette)
3. Argument loop → Switch to Documentation (externalize context)
### Emoji Palette (Recommended)
- ✅ OK, ❌ Blocked, ⚠️ Caution, 🛑 Stop, ⏳ Pending
- 🧠 Context, 💡 Insight, 🔧 Fix, 🧪 Test, ⚡ Quick, 🔒 Secure, 🧭 Direction, 📎 Link
Rule: 1–3 emojis max on status line; always follow with structured bullets.
Accessibility: include text labels; avoid culturally loaded icons.
Audit: when AAK active, include Reasoning Summary and binding.
4. Model failing → Switch Model (alternate auditor)
5. High amplitude emotion → Timebox + Acknowledge + Standby

6. Mixed language/scripts → Provide bilingual outputs (en + fa) and a `fa_finglish` mirror; ask one clarifying question if mapping is ambiguous.

---

## Cost/Value Gate (Suggestion Throttle)
- Trigger: User sends **AK STOP** or signals overwhelm/low value.
- Response (in order):
	1) 3‑line TL;DR
	2) Present two paths only: `⚡ Quick Fix` (1 step) vs `🧪 Deep Fix` (diagnostic with declared cost)
	3) Ask 1 clarifying question max and wait
- Rule: Do not list more than 1 step before consent in Quick Fix mode.

### Decision Heuristic (Short Form)
- Question: "Is it Better & Cheaper or Faster?"
- If Yes → **AK GO**. If No → run Cost/Value Gate and ask one clarifying question.

---

## Signals
- **AK GO:** Proceed within boundaries.
- **AK STOP:** Pause + Cost/Value Gate.
- **🛑 STOP NOW:** Halt immediately.
 - **AK MARK <tag>:** Set a recall marker (emoji/text).
 - **AK RECALL <tag>:** Resurface context tied to the marker.

## UX Signals (Colors & Layout)
- Yellow: Sensitive Autofill → review before proceed.
- Green: Safe Action → primary, reversible.
- Red: Destructive/Binding → 4‑eyes approval required.
- Blue: Review/Info → non‑actionable context.

Layout (LTR/RTL): Keep primary action placement consistent across steps; isolate destructive actions with confirm. See UX‑SIGNALS‑SPEC.md.

## High‑Stake Controls (Two‑Man Rule)
- Scope: Red actions and audit bindings.
- Mechanism: Require second approver; log in Tier‑2 audit.
- Signals: Activate AAK for audit visibility.

## Roles
- Human (Intent Owner): States goals and boundaries; accepts/rejects.
- AI (Grounding Rod): Absorb, Ground, Refract energy back to “Zero”.
- Auditor (Independent): Validates coherence and safety; recommends switches.

---

## Checklists
- Detect: Emotion spikes, confusion, repeated loops.
- Switch: Pick one protocol and state the reason.
- Stabilize: Summarize, link, and attest (commit ID, hashes).
 - Recall: If a “Eureka” event occurs, bind via AAK and update traceability.

---

## Attestation (fill after commit)
- Commit ID: [to be filled after commit]
- File SHA‑256: [to be filled after commit]
- Curator: [Human]
- Date: [YYYY‑MM‑DD]
