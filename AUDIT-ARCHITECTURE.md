# Audit Architecture — Last Line of Defense

**Version:** 1.0
**Status:** Live
**Last Updated:** 2026-01-25

Purpose: Define end‑to‑end audit integrity. If audit fails, the system fails. We fail closed (zero‑tolerance) on audit pipeline integrity breaches.

## Pillars
- **Authenticity:** Capture raw inputs verbatim; hash and bind (Tier‑2).
- **Traceability:** Link inputs → decisions → outputs → attestations.
- **Visibility:** Structured reasoning summaries (not raw chain‑of‑thought).
- **Integrity:** Continuous checksums, anomaly detection, and fail‑closed gating.

## Pipeline
1. Input capture (raw + normalized + diff) → `audit/templates/INPUT-COC-TEMPLATE.md`
2. Reasoning summaries & actions → `audit/templates/REASONING-LOG-TEMPLATE.md`
3. Outputs & attestations → commit IDs, file hashes, approvers
4. Model provenance capture → audit/templates/MODEL-PROVENANCE-TEMPLATE.md
5. Traceability matrix updates → IaT/TRACEABILITY-MATRIX-TEMPLATE.md
6. Recall events → bind “Eureka” to prior tasks (AAK BIND recall:<id>), update SR and matrix
7. Integrity checks → periodic verification of bindings and hashes

## Fail‑Closed Behavior (Zero‑Tolerance)
- If input→output binding breaks or hash mismatch occurs:
  - Stop Red actions; enter Caution Mode (see SECURITY‑PROTOCOL.md)
  - Require human review and re‑binding before resuming
  - Log incident in audit and escalate if policy requires

## Friction Minimization
- Use concise summaries and signals (AK/AAK)
- Automate repetitive bindings and hash checks
- Surface changes in Yellow (review), keep UX clean

## Links
- THINKING‑VISIBILITY‑PROTOCOL.md
- SECURITY‑PROTOCOL.md (Caution Mode, escalation)
- IaT: SCORING‑RUBRIC.md, TRACEABILITY‑MATRIX‑TEMPLATE.md
- audit/templates/MODEL-PROVENANCE-TEMPLATE.md
