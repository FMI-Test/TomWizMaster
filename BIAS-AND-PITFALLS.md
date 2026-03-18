# Bias & Pitfalls — Collaboration Playbook

**Version:** 1.0  
**Status:** Draft (for multi-model audit)  
**Source of Truth:** https://github.com/FMI-Test/GenAI-RD/tree/main  
**Last Updated:** 2026-01-25

---

## Purpose
- Identify common cognitive and process biases across Human ↔ AI collaboration.
- Catalog pitfalls and provide prosecutor/judge/auditor triad guidance to reinforce FEED+.
- Anchor all analysis to CONSTITUTION.md and GUARDRAILS.md; avoid blame, enable learning.

---

## Bias Catalog (Selected)
- Confirmation Bias: Prefer evidence that supports prior beliefs.
- Anchoring: Overweight first information or initial draft.
- Availability: Recent or vivid examples distort probability assessment.
- Authority Halo: Over-trust model output due to brand or reputation.
- Survivorship: Ignore failed runs; cherry-pick successful outputs.
- Framing: Wording changes decisions; standardize checklists.

---

## Pitfalls & Preventive Patterns
- Over-Interpretation: Treat metaphors as literal policies → Add context boxes and disclaimers.
- Single-Model Dependence: One model’s blind spots propagate → Use multi-model audit.
- Long-Session Drift: Threads lose coherence → Externalize to docs; keep short artifacts.
- Unclear Roles: Auditor vs Prosecutor vs Judge mixed → Use triad separation and attest.
- Cost/Value Disconnect: User perceives advice as costly vs simple need → Add `AK STOP` gate; offer `⚡ Quick Fix` vs `🧪 Deep Fix`; throttle suggestions to one step.

---

## Clarification: Robin Williams “WSD” (Weapon of Self-Destruction)
- Reference: Robin Williams’ 2009 stand-up special “Weapons of Self-Destruction.”
- Intent: Satire highlighting self-sabotage patterns (personal and societal). 
- Pattern Insight: Self-destructive behaviors can amplify to collective “mass” outcomes if normalized.
- Preventive Note: Label satire vs. policy; avoid conflating comedic framing with prescriptive guidance.

---

## Prosecutor / Judge / Auditor — Collaboration Triad

### Prosecutor (OpenAI — Stress Testing)
- Goal: Surface edge cases, perverse incentives, and failure modes.
- Checklist:
  - Adversarial prompts targeting hallucination and bias.
  - Scenario analysis with downside risks and red-line violations.
  - Evidence demands: sources, hashes, commit IDs, reproducibility.

### Judge (Human — Final Verdict)
- Goal: Accept/Reject with rationale; reinforce FEED+.
- Checklist:
  - Constitutional alignment: CONSTITUTION.md, GUARDRAILS.md.
  - Chain-of-custody: commits, file hashes, links.
  - Decision log: What changed, why, and with what evidence.

### Auditor (Gemini — Independent Review)
- Goal: Coherence, completeness, safety, compliance.
- Checklist:
  - Cross-check claims against source docs.
  - Flag ambiguity and tone risks; suggest clarifications.
  - Recommend protocol switches to lower friction.

---

## Attestation (fill after commit)
- Commit ID: [to be filled after commit]
- File SHA‑256: [to be filled after commit]
- Curator: [Human/Jurisdiction]
- Date: [YYYY‑MM‑DD]
