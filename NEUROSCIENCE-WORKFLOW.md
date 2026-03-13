![NEUROSCIENCE-WORKFLOW](images/NEUROSCIENCE-WORKFLOW.png)

# Neuroscience‑Informed Workflow — Recall & Background Processing

**Version:** 1.0
**Status:** Live
**Last Updated:** 2026-01-25

Purpose: Harness human background processing (sleep/dreams, shower thoughts) with AI collaboration using lightweight markers, recall signals, and audit‑bound “Eureka” events.

## Concepts
- Background Task: subconscious problem‑solving during rest/relaxation.
- Marker: a lightweight TODO/tag that the brain recognizes (emoji/text).
- Recall Event (“Eureka”): surfaced solution after latency; bind to original task.

## Signals
- **AK MARK <tag>:** set a marker (emoji/text) for later recall.
- **AK RECALL <tag>:** request AI to resurface context linked to the marker.
- **AAK BIND recall:<id>:** bind recall event to prior audit/log and output.

## Emoji Markers (Examples)
- 📌 Marker — set a mental bookmark
- 🌙 Rest — sleep/relaxation trigger
- 🧠 Recall — context reactivation
- ✨ Eureka — new insight emerged

## Workflow
1. Set a clear marker + minimal context (Goal, Constraint, Evidence).
2. Relaxation/background period (sleep/shower/walk).
3. On recall: send AK RECALL <tag>; AI loads prior context and proposes a succinct Reasoning Summary + action.
4. Bind the event with AAK (recall:<id>) and update audit + traceability.

## Audit & Traceability
- Capture raw recall input; compute hash; link to original log.
- Update SR and traceability matrix for any new decisions.
- If high‑stake: require 4‑eyes approval before actions.

## Inbox Zero Policy (Actionable vs FYI)
- Actionable: marker + next step; schedule or execute.
- FYI: archive under context; no action, no risk.
- Batch notifications; filter by markers/tags only.

## Links
- EMOJI‑COMPRESSION.md (palette)
- FRICTION‑PROTOCOL.md (switches)
- AUDIT‑ARCHITECTURE.md (fail‑closed)
- IaT: TRACEABILITY‑MATRIX‑TEMPLATE.md, CHANGE‑ANALYSIS‑TEMPLATE.md
