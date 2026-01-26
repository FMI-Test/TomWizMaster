# Infrastructure‑as‑Text (IaT) Framework

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
 - audit/templates/MODEL‑PROVENANCE‑TEMPLATE.md — model identity, lineage, hashes, attestations
