# Architecture Hierarchy — System → Platform → App

**Version:** 1.0
**Status:** Live
**Last Updated:** 2026-01-25

Purpose: Define a clear decomposition so we can analyze changes up/down the stack and evaluate cost/time/value alignment with built‑in pro/con.

## Hierarchy
- **System:** End‑to‑end capability (policies, governance, cross‑cutting concerns)
- **Platform:** Shared services and runtime (identity, CI/CD, observability, data)
- **App:** Domain workloads and features (business logic, UX)

## Navigation (Up/Down)
- Start at change origin (App/Platform/System)
- Trace dependencies upward (guards, policies) and downward (components)
- Evaluate substitution: X → Y at the right layer

## Built‑In Evaluation (PRO/CON, OCP)
- **Open/Closed Principle (OCP):** Prefer extending via interfaces/config over modifying core.
- **Pro/Con:** List benefits/trade‑offs for X → Y substitutions.
- **Cost/Time/Value:** Estimate cost, lead‑time impact, and value alignment.
- **Risk:** Security/compliance/regression risks; mitigation and rollback.

## Decision Flow
1. Identify component X and candidate Y (layer: System/Platform/App)
2. Map interfaces and contracts (guardrails, SR constraints)
3. Score Pro/Con and Cost/Time/Value
4. Choose Option A/B/C (Recommended/Simple/Flexible)
5. Plan: rollout, test, rollback; bind Tier‑2 audit

## Links
- IaT: CHECKLIST, SR template, Reference Architecture, Decision Options
- Protocols: PROMPT‑STYLE (signals), FRICTION‑PROTOCOL, THINKING‑VISIBILITY‑PROTOCOL

## Coverage Checklist
- Scoring: Use IaT/SCORING‑RUBRIC.md for cost/time/value/risk normalization.
- Traceability: Maintain IaT/TRACEABILITY‑MATRIX‑TEMPLATE.md to map SR → components → tests.
- RACI: Reference SHARED‑RESPONSIBILITY.md for ownership; record approvers for Red actions.
