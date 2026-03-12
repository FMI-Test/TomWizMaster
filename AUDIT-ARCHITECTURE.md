\![AUDIT-ARCHITECTURE](images/AUDIT-ARCHITECTURE.png)

# Audit Architecture — Last Line of Defense

**Version:** 1.0
**Status:** Live
**Last Updated:** 2026-02-08

Purpose: Define end‑to‑end audit integrity. If audit fails, the system fails. We fail closed (zero‑tolerance) on audit pipeline integrity breaches.

## Pillars
- **Authenticity:** Capture raw inputs verbatim; hash and bind (Tier‑2).
- **Traceability:** Link inputs → decisions → outputs → attestations.
- **Visibility:** Structured reasoning summaries (not raw chain‑of‑thought).
- **Integrity:** Continuous checksums, anomaly detection, and fail‑closed gating.
- **Human Context:** Capture intent, constraints, time sensitivity, and decision owner.
- **AI Use Boundary:** Audit outputs are for repository governance, not training data.

## Pipeline
1. Input capture (raw + normalized + diff) → `audit/templates/INPUT-COC-TEMPLATE.md`
2. Reasoning summaries & actions → `audit/templates/REASONING-LOG-TEMPLATE.md`
3. Outputs & attestations → commit IDs, file hashes, approvers
4. Model provenance capture → audit/templates/MODEL-PROVENANCE-TEMPLATE.md
5. Traceability matrix updates → IaT/TRACEABILITY-MATRIX-TEMPLATE.md
6. Recall events → bind “Eureka” to prior tasks (AAK BIND recall:<id>), update SR and matrix
7. Integrity checks → periodic verification of bindings and hashes
8. Auto-doc control → generated reports live under Audit/output and are excluded from audit inputs

## Auto-Documentation (Generated Artifacts)
- Store generated audit reports under `Audit/output/` and logs under `Audit/logs/`.
- Exclude generated artifacts from future audit inputs to prevent recursion and false positives.
- Stamp each generated report with date, scope, and tool provenance.

## Dependencies (Internal)
- CONSTITUTION.md
- GUARDRAILS.md
- SHARED-RESPONSIBILITY.md
- COMPLIANCE.md
- THINKING-VISIBILITY-PROTOCOL.md
- SECURITY-PROTOCOL.md
- IaT/TRACEABILITY-MATRIX-TEMPLATE.md

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
