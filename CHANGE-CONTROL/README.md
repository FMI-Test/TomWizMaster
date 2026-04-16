# Infrastructure‑as‑Text (IaT) Framework

![README](images/README.png)

**Version:** 1.0
**Status:** Live
**Last Updated:** 2026-01-25

Purpose: Provide a domain‑agnostic workflow where users describe intent in text (We are / We want / Because), and AI generates structured, auditable outputs: compliance, security, dev, separation of concerns, legal, and implementation guidance.

## Flow

1. Intake (We are / We want / Because + Context) → IaT Intake Form
2. AI Output Checklist → Required + Optional sections
3. System Requirements (SR) → constraints, policies, non‑functionals
4. Reference Architecture → AWS/Azure/GCP/On‑Prem/GitHub variants
5. Decision Options (A/B/C) → recommended, simple, flexible
6. Change Analysis (X → Y) at System/Platform/App → pro/con, cost/time/value, risk
7. Automation Plan → tasks, risks, dependencies
8. Tier‑2 Audit Binding → AAK signals + chain‑of‑custody

## Signals

- Use AK/AAK signals from PROMPT‑STYLE for minimal path and audit visibility.
- Bind inputs/outputs per THINKING‑VISIBILITY‑PROTOCOL.

## Neutrality & Licensing

- Domain‑agnostic; neutral posture; respect license boundaries; cite sources.

## Files

- INTAKE‑FORM.md — User input template
- CHECKLIST.md — AI output sections (Required/Optional)
- SYSTEM‑REQUIREMENTS‑TEMPLATE.md — SR structure
- REFERENCE‑ARCHITECTURE.md — cloud/on‑prem patterns
- DECISION‑OPTIONS.md — options A/B/C with trade‑offs
- CHANGE‑ANALYSIS‑TEMPLATE.md — what‑if substitutions (X → Y)
- SCORING‑RUBRIC.md — normalization for cost/time/value/risk
- TRACEABILITY‑MATRIX‑TEMPLATE.md — SR ↔ components ↔ tests mapping
- PROMPT.md — starter prompt for IaT sessions
- Audit/templates/MODEL‑PROVENANCE‑TEMPLATE.md — model identity, lineage, hashes, attestations

## Example Change Packet

- [October-7.md](October-7.md) — intake for a negotiation-versus-force cost study
- [October-7-system-requirements.md](October-7-system-requirements.md) — scoped requirements for the study
- [October-7-decision-options.md](October-7-decision-options.md) — bounded options and recommendation
- [October-7-change-analysis.md](October-7-change-analysis.md) — structured X -> Y analysis
- [October-7-traceability-matrix.md](October-7-traceability-matrix.md) — requirements-to-artifacts mapping

---

### Footnote — Model & Provenance

- Model: GitHub Copilot (GPT-5)
- Operation: Footnote insertion
- Date: 2026-01-26
- Commit Ref: 87c0453da8dc93851da7fb86eb0534f1d7d0e137
- Review: AK (requested/audited)

This framework README retains provenance notes for audit consistency.
