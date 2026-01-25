# US-Gov — Government Efficiency Programs (Index)

**Version:** 1.0  
**Status:** Live (Framework-first)  
**Source of Truth:** https://github.com/FMI-Test/GenAI-RD/tree/main  
**Last Reviewed:** January 25, 2026

> This path organizes US government efficiency initiatives under the GenAI‑RD constitutional framework, applying the OCP principle: open for extension (new programs, agencies), closed for modification (core constitutional docs remain canonical).

---

## Canonical Framework
- DOGE (Department of Government Efficiencies): see [../DOGE.md](../DOGE.md)
- Constitutional docs: [../CONSTITUTION.md](../CONSTITUTION.md), [../GUARDRAILS.md](../GUARDRAILS.md), [../SHARED-RESPONSIBILITY.md](../SHARED-RESPONSIBILITY.md), [../COMPLIANCE.md](../COMPLIANCE.md)
- Chain-of-custody & regional guidance: [../AI-Guardrails-and-Bias/DEEP-DiVE.md](../AI-Guardrails-and-Bias/DEEP-DiVE.md), [../AI-Guardrails-and-Bias/APPENDIX-REGIONAL.md](../AI-Guardrails-and-Bias/APPENDIX-REGIONAL.md)

---

## Structure (open for extension)
```
US-Gov/
├── README.md                 ← Index and pointers
├── Programs/                 ← Agency/program portfolios
│   ├── Defense/              ← Defense budget efficiency
│   ├── Health/               ← Healthcare efficiency
│   ├── Education/            ← Education efficiency
│   └── Municipal/            ← City services, public works
├── Budgets/                  ← Budget baselines, KPIs, audits
├── Policies/                 ← Policy intents, constraints, guardrails mapping
└── Audits/                   ← Three‑Shot outputs (DOGE_AUDIT_1..3)
```

- Create subfolders as needed; link back to canonical docs rather than duplicating content.
- Use the Three‑Shot cadence for major proposals and record attestation (commit IDs, hashes) with each artifact.

---

## Operating Checklist
- Align to constitutional docs and guardrails.  
- Define measurable outcomes (KPIs) and risk bounds.  
- Run Draft → Audit → Stress cycles (Three‑Shot).  
- Pilot with attestation; monitor outcomes; iterate.  

---

## Attestation (fill after commit)
- Commit ID: [to be filled after commit]  
- File SHA‑256: [to be filled after commit]  
- Curator: [Agency/Program]  
- Date: [YYYY‑MM‑DD]
