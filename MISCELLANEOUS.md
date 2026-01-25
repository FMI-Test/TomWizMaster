# Miscellaneous: Cross‑Domain Usage & Safety Playbook

**Version:** 1.0  
**Status:** Live  
**Source of Truth:** https://github.com/FMI-Test/GenAI-RD/tree/main  
**Last Reviewed:** January 25, 2026

> This document explains how to apply the GenAI‑RD framework across domains (policy, engineering, finance, healthcare, etc.), with a pragmatic playbook, benefits vs. limitations, pitfalls and do/don’t, and model selection guidance tied to the “One‑Shot” methodology.

---

## 1. Purpose & Scope
- **Goal:** Provide a methodical, repeatable path to use this repo’s constitutional framework in any domain.  
- **Scope:** Documentation‑first workflows; AI‑assisted analysis and auditing; human‑in‑the‑loop decision making; chain‑of‑custody verification.  
- **Audience:** Engineers, analysts, auditors, and collaborators mapping real problems to this framework.

---

## 2. Cross‑Domain Playbook (Methodical)
1. **Anchor to Constitution:** Read and align with [CONSTITUTION.md](CONSTITUTION.md) and [GUARDRAILS.md](GUARDRAILS.md).  
2. **Clarify Roles:** Map ownership using [SHARED-RESPONSIBILITY.md](SHARED-RESPONSIBILITY.md).  
3. **Define Intent:** Write a short domain intent (What/Why/Boundaries) in the target folder.  
4. **Run One‑Shot (Draft):** Use a capable model to ingest the repo and draft domain‑specific artifacts (analysis, checklist, risk map).  
5. **Run One‑Shot (Audit):** Commission an independent auditor model to review findings for coherence, completeness, and risk.  
6. **Human Verdict:** Review auditor output; accept/reject changes; record decision and rationale in the domain folder.  
7. **Attest & Trace:** Capture evidence (links, hashes, commit IDs) per chain‑of‑custody guidance (see DEEP‑DiVE audit section).

---

## 3. Benefits vs. Limitations (Pro/Con)
- **Pro: Speed:** Rapid onboarding and domain application via One‑Shot ingestion.  
- **Pro: Traceability:** Git/GitHub history + audit documents enable verifiable trails.  
- **Pro: Reuse:** Shared constitutional layer reduces duplication; projects inherit patterns.  
- **Pro: Governance:** Guardrails and shared responsibility clarify boundaries and accountability.  
- **Con: Model Variance:** Different LLMs exhibit different failure modes; require multi‑model review.  
- **Con: Non‑Production Proof:** One‑Shot is a POC method; reliability needs repeated runs (multi‑shot) and human oversight.  
- **Con: Context Drift Risk:** Long sessions may drift; keep artifacts short, explicit, and versioned.

---

## 4. Pitfalls & Do/Don’t
- **Do:**  
  - Anchor every decision to constitutional docs; cite evidence.  
  - Record hashes and commit IDs for artifacts (attestation).  
  - Use multi‑model peer review for critical domains.  
  - Keep domain outputs concise; prefer checklists and tables.  
- **Don’t:**  
  - Ship auditor output as truth without human review.  
  - Mix domain artifacts with constitutional docs; keep inheritance clean.  
  - Ignore model limitations; declare uncertainty and defer to sources.

---

## 5. Model Selection: “When Which Model?” (One‑Shot Triad)
- **Claude (Architect/Draft):** Structured drafts, reasoning, and document generation; good for initial One‑Shot outputs.  
- **Gemini (Auditor/Review):** Cross‑checking, coherence, safety, and risk identification; good for independent audit runs.  
- **OpenAI (Prosecutor/Stress):** Adversarial tests and stress scenarios to reveal edge failures.  
- **Human (Judge):** Final authority; accepts/rejects; merges to main.  
- **Pattern:** Draft → Audit → Verdict; repeat if high stakes (multi‑shot).

---

## 6. Dependencies & Style Adherence
- **Runtime Dependencies:** None required; compliance and audit rely on internal documents and Git/GitHub.  
- **Evidence Dependencies:**  
  - Use chain‑of‑custody commands (branch, HEAD, file hashes) as shown in [AI-Guardrails-and-Bias/DEEP-DiVE.md](AI-Guardrails-and-Bias/DEEP-DiVE.md).  
  - Reference regulatory mappings in [AI-Guardrails-and-Bias/APPENDIX-REGIONAL.md](AI-Guardrails-and-Bias/APPENDIX-REGIONAL.md).  
  - For compliance automation, see [COMPLIANCE.md](COMPLIANCE.md) (One‑Shot audit prompt).  
- **Style:**  
  - Keep sections short, bulleted, and actionable.  
  - Link to root docs instead of repeating text.  
  - Prefer checklists for domain artifacts; add attestation lines (commit ID, SHA‑256).

---

## 7. One‑Shot: 5‑Line Audit Instruction
```
System: You are an AI Compliance Auditor.
1. Ingest the entire GenAI‑RD repository.
2. Operate per CONSTITUTION.md and GUARDRAILS.md.
3. Audit [TARGET_PROJECT_FOLDER] for risks and violations.
4. Produce [PROJECT]_AUDIT.md with evidence; do not modify files.
```

---

## 8. Conclusion & Next Steps
- **Conclusion:** Cross‑domain application works when anchored to shared principles, explicit roles, and auditable evidence. One‑Shot accelerates analysis, but must be paired with independent audit and human verdict.  
- **Next:** Add domain‑specific checklists; run triad; attach evidence (links, hashes, commit IDs); record verdict.  
- **References:** [README.md](README.md), [CONSTITUTION.md](CONSTITUTION.md), [GUARDRAILS.md](GUARDRAILS.md), [SHARED-RESPONSIBILITY.md](SHARED-RESPONSIBILITY.md), [DESIGN.md](DESIGN.md), [COMPLIANCE.md](COMPLIANCE.md).

---

## Attestation (fill after commit)
- Commit ID: [to be filled after commit]
- File SHA‑256: [to be filled after commit]
- Curator: [Human/Jurisdiction]
- Date: [YYYY‑MM‑DD]
