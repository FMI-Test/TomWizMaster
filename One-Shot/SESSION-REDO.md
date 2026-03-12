# Session Redo: OpenAI vs Claude & Budget Limitation

## Context & Trigger
- Session required best-in-class, enterprise-ready model (Claude), but budget limitations caused VS Code to auto-switch to OpenAI.
- Model selection and tooling setup were not explicitly confirmed, leading to process deviation.
- This note documents the impact, lessons, and recommendations for future sessions.

## OpenAI vs Claude: Key Differences
- **Claude (Anthropic):**
  - Preferred for trusted, enterprise, and safety-critical outputs
  - Higher reliability, transparency, and compliance in this domain
  - User explicitly requested only Claude outputs be accepted
- **OpenAI (OpenAI):**
  - Used due to budget/tooling constraints
  - Outputs not accepted for final, high-stakes documentation
  - Should be reviewed with caution and not relied upon for compliance or audit

## Budget Limitation Impact
- Budget constraints led to auto-switching of model in VS Code
- Trust and auditability were compromised
- Human-AI setup and explicit confirmation were missed, resulting in critical process gaps

## Lessons Learned
- Always confirm model selection and tooling setup before starting high-stakes sessions
- Document and audit all model/tooling switches and their impact
- Budget limitations must be flagged and mitigated before session begins
- Human-in-the-loop and explicit confirmation are non-negotiable in safety-critical domains

## Recommendations
- For future sessions, ensure budget and tooling support for preferred model (Claude)
- Add pre-session checklist for model, budget, and tooling confirmation
- If auto-switch occurs, halt and re-confirm before proceeding
- Document all deviations and their impact for audit and review

---

## Session Redo: Claude Opus 4.5 Confirmed
- **Model**: Claude Opus 4.5 (Anthropic) — Explicitly selected by user for entire session and all redo.
- Budget updated ($100, highest GPU compute) to prevent auto-switch.
- All prior GPT-4.1 outputs reviewed and redone under Claude Opus 4.5.
- AK!? Confirmed.

---

*Session redo completed with Claude Opus 4.5. AK!? Ready for further action or review.*
