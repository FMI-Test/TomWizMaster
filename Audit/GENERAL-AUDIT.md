# General Audit Protocol — End‑to‑End (HuAI)

**Purpose:** Standard, repeatable audit that reads the repo, verifies end‑to‑end alignment, and produces a resilient status report.
**Scope:** Documentation‑first (Markdown). System‑level; model‑agnostic. No production ops.
**Status:** Live
**Version:** 1.0
**Last Updated:** 2026-01-29

---

## Triggers
- **Audit Request:** Human or AI asks for an audit.
- **Change Detection:** A file is edited or added.
- **Tier Shift:** Status change (e.g., `dev → poc → uat → staging → rc`).

## Inputs
- Repo root and the target file(s) or paths.
- Style sources: [MARKDOWN-STYLE.md](../MARKDOWN-STYLE.md), [PROMPT-STYLE.md](../PROMPT-STYLE.md), [CONSTITUTION.md](../CONSTITUTION.md), [GUARDRAILS.md](../GUARDRAILS.md).
- Optional: AAK signals for reasoning log binding.

## Outputs
- **Audit Report (MD):** Summary with findings, actions, and tier classification.
- **Reasoning Log (MD):** Stored under `Audit/logs/YYYY-MM-DD/HHMM-<id>-reasoning-log.md`.
- **Attestation:** File paths, date, status, and model provenance if applicable.

## Workflow
1. **Read & Map:** Build a file map; identify changed/target files.
2. **Style & Metadata Check:** Headers, bullets, tone; `Version/Status/Last Updated` blocks present and consistent.
3. **Link Integrity:** Validate relative links exist; avoid bare URLs.
4. **Cross‑File Alignment:** Check references to constitutional docs; avoid duplication.
5. **Risk & Dependencies:** Note external references and assumptions; flag missing provenance.
6. **Tier Classification:**
   - `dev (wip)`, `poc`, `uat`, `staging`, `rc` (Resiliency Check)
   - Prefer system‑level; avoid "prod" (ops); keep agnostic.
7. **Verdict & Remediation:**
   - If aligned → mark tier and status.
   - If misaligned → list concise remediation steps (1–3).
8. **Log & Bind (AAK):** Save reasoning log and bind to report.

## Signals (AAK)
- `AAK GO` → start logging
- `AAK STOP` → stop logging
- `AAK BIND <id>` → bind log to output
- `AAK SAVE` → checkpoint

## Storage
- Logs: `Audit/logs/YYYY-MM-DD/`
- Reports: `Audit/output/GENERAL-AUDIT-REPORT.md` (overwritable per run)

## HuAI Alignment
- Human & AI collaborate (not either/or); both visible.
- Suggestions may include better model choices without content changes.
- Keep documents living, vibrant, and brand‑consistent (OCP mindset).

---

#### Attestation
- **Protocol:** General Audit Protocol — End‑to‑End (HuAI)
- **Version:** 1.0
- **Date:** 2026-01-29
- **Reviewer:** R&D
- **Status:** Live
