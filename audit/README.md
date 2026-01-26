# Audit Logs

This folder holds Tier‑2 audit logs and related templates.

## Structure
- logs/YYYY-MM-DD/HHMM-<short-id>-reasoning-log.md
- templates/REASONING-LOG-TEMPLATE.md
 - templates/INPUT-COC-TEMPLATE.md

## Usage
1. Create a new log from the template.
2. Use signals (AAK GO/STOP/BIND/SAVE) to control logging.
3. Keep entries structured and concise; avoid secrets.
4. Link the log to the primary output (doc path or commit hash).
 5. For input authenticity, capture raw input with hash using INPUT-COC-TEMPLATE; store normalized copy and diff summary separately.

Retention defaults to 90 days in R&D unless overridden by COMPLIANCE.