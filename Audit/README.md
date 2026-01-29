# Audit

This folder holds the general audit protocol, Tier‑2 audit logs, templates, and output reports.

## Structure
- `GENERAL-AUDIT.md` — End‑to‑end protocol (HuAI)
- `run_audit.ai` — Declarative spec for model‑executed audits
- `logs/YYYY-MM-DD/HHMM-<short-id>-reasoning-log.md` — AAK reasoning logs
- `output/GENERAL-AUDIT-REPORT.md` — Latest generated report
- `templates/REASONING-LOG-TEMPLATE.md` — AAK log scaffold
- `templates/INPUT-COC-TEMPLATE.md` — Chain‑of‑custody input capture
- `templates/MODEL-PROVENANCE-TEMPLATE.md` — Model identity and attestations

## Usage
1. **Protocol:** See [GENERAL-AUDIT.md](GENERAL-AUDIT.md) for workflow and signals.
2. **Run (Manual):**
	 - Full repo:
		 ```bash
		 scripts/audit.sh
		 ```
	 - Specific files:
		 ```bash
		 scripts/audit.sh Safety/date-ai.md README.md
		 ```
	 - Fail on issues (CI-friendly):
		 ```bash
		 scripts/audit.sh --fail
		 ```
	 Output: `Audit/output/GENERAL-AUDIT-REPORT.md`.
3. **Run (AI):** Provide `Audit/run_audit.ai` to your model‑runner to execute the audit steps.
4. **Log Control:** Use signals (AAK GO/STOP/BIND/SAVE) to control logging.
5. **Attestation:** Link the log to the primary output (doc path or commit hash). For input authenticity, capture raw input with hash using `INPUT-COC-TEMPLATE.md`.

Retention defaults to 90 days in R&D unless overridden by COMPLIANCE.
