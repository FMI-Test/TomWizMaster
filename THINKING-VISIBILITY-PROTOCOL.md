# Thinking Visibility & Tier‑2 Audit Protocol

Purpose: Ensure reasoning and decision traces are consistently visible, auditable, and bound to outputs for R&D and high‑stake workflows without exposing confidential chain‑of‑thought. This protocol defines what to capture, how to store it, and signals to control audit behavior.

## Modes
- R&D Default: Full trace visibility via structured summaries of reasoning and actions. Store in `audit/` using the template.
- High‑Stake (P4–P7, domain‑dependent): Max visibility with Tier‑2 binding. Every significant action logs to an audit file and links back to the main output.

## Classification
- Priority bands: P1…P10. High‑stake typically P4–P7 (domain dependent).
- Time‑Sensitive flag: If time‑critical, prefer minimal path logging (concise summaries) with frequent checkpoints.

## What to Capture (Structured, not raw chain‑of‑thought)
Record the following elements for each task:
1. Objective: What we’re solving.
2. Constraints & Assumptions: Known limits and inferred premises.
3. Plan: Key steps and sequencing.
4. Actions Taken: Timestamps, tools, files touched, diffs/patch references.
5. Decisions & Deviations: Why changes were made, rejected options.
6. Outcomes: Results, artifacts, and verification notes.
7. Next Steps: Follow‑ups, risks, and owners.

Store secrets separately; do not include credentials or sensitive personal data. Redact identifiers per SECURITY-PROTOCOL.

## Signals
- AAK GO: Start audit logging for the current task.
- AAK STOP: Stop audit logging (retain file, no more entries).
- AAK BIND <id>: Bind the audit log to a main output (e.g., document or commit) by ID.
- AAK SAVE: Flush/checkpoint the current log entry block.

These complement existing signals (e.g., AK GO/AK STOP) and focus on audit control.

## Binding & Storage
- File location: `audit/logs/<YYYY-MM-DD>/<HHMM>-<short-id>-reasoning-log.md`
- Cross‑link: Include references to the primary output (document path or commit hash) in the log header.
- Retention: Follow COMPLIANCE and SECURITY-PROTOCOL. Default retention 90 days in R&D; extend for high‑stake per governance.

## Minimal Path Logging
When time‑sensitive, log succinct bullet summaries at checkpoints:
- Context
- Action (tool + file or command)
- Result
- Risk/Next

## Template
Use `audit/templates/REASONING-LOG-TEMPLATE.md` to start logs. Keep entries structured and concise.

## Privacy & Neutrality
- No identity‑based triggers; neutrality by default.
- Redact PII and sensitive references.
- Escalate per SECURITY-PROTOCOL when risk thresholds are met.

## Input Authenticity & Autocorrect
- Preserve the original raw input (verbatim) for chain‑of‑custody. Compute and store a hash (e.g., SHA‑256) of the raw text.
- If normalization or autocorrect is applied, store a separate normalized version and a diff summary. Do not overwrite raw.
- Prefer AI interpretation on normalized text but reference raw when ambiguity arises.
- For time‑sensitive flows, enable “Authenticity mode”: capture raw + minimal normalization notes; defer heavy corrections.
- Bind inputs to outputs using AAK signals (e.g., AAK BIND <id>) and reference in the audit header.
- Template: see `audit/templates/INPUT-COC-TEMPLATE.md` for input chain‑of‑custody.
