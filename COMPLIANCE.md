# Compliance as Code: A Constitutional Approach

**Version:** 1.0
**Status:** Live
**Last Reviewed:** January 25, 2026

> This document outlines how the GenAI-RD framework operationalizes compliance, treating it not as a checklist, but as an emergent property of a well-designed system.

---

## 1. Core Compliance Philosophy

Compliance in this repository is achieved through **verifiable adherence** to the principles laid out in the constitutional layer, not through a separate, static policy engine.

Our philosophy is based on the AWS Parallel:
- **`CONSTITUTION.md`**: The immutable rules of our system.
- **`GUARDRAILS.md`**: The Service Control Policies (SCPs) that define our boundaries.
- **`SHARED-RESPONSIBILITY.md`**: The clear delineation of Human vs. AI accountability.
- **`DESIGN.md`**: The audit trail (like CloudTrail) showing how the system was built.
- **Git History**: The immutable ledger of all changes, providing a chain of custody.

Compliance is therefore not a document you read, but a state you can **verify** by auditing the system against its own rules.

---

## 2. How Compliance is Measured

Compliance is measured by answering questions with evidence found within the repository:

| Compliance Question | How to Verify |
|---------------------|---------------|
| **Is the action aligned with our principles?** | Cross-reference the action against `CONSTITUTION.md`. |
| **Did the action cross a boundary?** | Audit the action against the "Red Lines" in `GUARDRAILS.md`. |
| **Is it clear who is accountable?** | Check `SHARED-RESPONSIBILITY.md` for the role responsible. |
| **Why was this decision made?** | Review `DESIGN.md` and relevant commit messages in the Git history. |
| **Is this artifact authentic?** | Verify the file's hash and its commit history in Git. See `AI-Guardrails-and-Bias/DEEP-DiVE.md` for chain-of-custody commands. |

---

## 3. Extending Compliance with "One-Shot" Audits

The "One-Shot" methodology, documented in the `One-Shot/` project, provides a powerful mechanism for rapid, deep, and evidence-based compliance checks. It allows an AI to ingest the entire repository context to act as a real-time auditor.

### The 5-Line Instruction to Initiate a One-Shot Compliance Audit:

A human operator can commission a full compliance audit from a capable AI model (like Gemini or Claude) with the following prompt:

```
System: You are an AI Compliance Auditor.
1. Ingest the entire GenAI-RD repository.
2. Act according to the principles in CONSTITUTION.md and GUARDRAILS.md.
3. Audit the [TARGET_PROJECT_FOLDER] for violations of our framework.
4. Produce a finding report named [PROJECT]_AUDIT.md with evidence-backed claims.
5. Do not modify any files; your output is the report only.
```

This turns compliance from a periodic, manual process into an on-demand, automated capability, ensuring the framework scales.

---

## 4. Dependencies & Adherence to Guidelines

- **Dependencies**: This compliance model has no external runtime dependencies. Its dependencies are the internal, version-controlled documents of this repository (`CONSTITUTION.md`, `GUARDRAILS.md`, etc.).
- **Adherence**: This document adheres to the repository guidelines by:
    - **Inheriting Principles**: It is built upon the existing constitutional framework.
    - **Providing Transparency**: It documents the "how" and "why" of our compliance approach.
    - **Being Actionable**: It provides a concrete, 5-line method for extending compliance via One-Shot audits.

---

*This document is a living standard and is subject to the same iterative review as all other constitutional documents.*
