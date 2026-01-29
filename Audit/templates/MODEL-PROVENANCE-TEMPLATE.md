# Model Provenance Record

**Version:** 1.0
**Status:** Template
**Last Updated:** 2026-01-25

Purpose: Capture model identity, lineage, artifacts, evaluations, and attestations to ensure trust, auditability, and lawful use. Bind this record to the audit pipeline and IaT outputs.

---

## 1. Identity
- Model Name: [e.g., "Gemini-2 Pro"]
- Provider/Vendor: [Org]
- Version/Tag: [vX.Y.Z / commit]
- Model Card URL: [link]
- License: [license name + URL]

## 2. Lineage & Training
- Base Model: [name + URL]
- Fine-Tuning Datasets: [sources + brief description]
- Fine-Tuning Date/Method: [date + SFT/RLHF/LoRA/etc.]
- Data Governance: [PII/PHI policies, consent]

## 3. Artifacts & Hashes
- Weights Digest (SHA-256): [hex]
- Container/Image Digest: [registry@sha256:...]
- Runtime/Frameworks: [CUDA/PyTorch/TF/etc. + versions]
- Config File Checksum: [SHA-256]

## 4. Evaluations & Risk
- Benchmarks: [datasets + metrics]
- Safety/Ethics: [known limitations, mitigations]
- Fairness: [bias tests, disparate impact notes]
- Residual Risks: [top risks]

## 5. Intended Use & Non-Use
- Intended Use: [allowed contexts]
- Not Intended For: [disallowed contexts]

## 6. Deployment Context
- Environment: [cloud/on-prem; region; node class]
- Inference Params: [temperature/top-p/max-tokens]
- Prompt Templates: [reference files]

## 7. Provenance & Attestations
- Source of Weights: [registry/repo]
- Supply Chain Signatures: [Sigstore/cosign, etc.]
- Attestation IDs: [IDs + links]
- Approvers: [names/roles]

## 8. Audit Bindings
- Input CoC: [link to audit/templates/INPUT-COC-TEMPLATE.md]
- Reasoning Log: [link to audit/templates/REASONING-LOG-TEMPLATE.md]
- Traceability Matrix: [link to IaT/TRACEABILITY-MATRIX-TEMPLATE.md]
- Signals: [AAK BIND entries + IDs]

## 9. Change Log
- YYYY-MM-DD: [change summary]

## 10. References
- Model Card: [URL]
- License: [URL]
- Provider Docs: [URL]
- Related SR: [link to IaT/SYSTEM-REQUIREMENTS-TEMPLATE.md]

---

#### Footnote — Model & Provenance
- Model: GitHub Copilot (GPT-5)
- Operation: Footnote insertion
- Date: 2026-01-26
- Commit Ref: 87c0453da8dc93851da7fb86eb0534f1d7d0e137
- Review: AK (requested/audited)

