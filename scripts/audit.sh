#!/usr/bin/env bash
set -euo pipefail

# Simple wrapper to run the general markdown audit
# Usage:
#   scripts/audit.sh                 # scan entire repo
#   scripts/audit.sh Safety/date-ai.md README.md  # audit specific files
#   scripts/audit.sh --fail          # exit non-zero on issues

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
PY_DEFAULT="python3"
PY_VENV="$ROOT_DIR/.venv/bin/python"
PY_CMD="$PY_DEFAULT"

if [[ -x "$PY_VENV" ]]; then
  PY_CMD="$PY_VENV"
fi

FAIL_FLAG=""
TARGETS=()
for arg in "$@"; do
  if [[ "$arg" == "--fail" ]]; then
    FAIL_FLAG="--fail-on-issues"
  else
    TARGETS+=("--target" "$arg")
  fi
done

OUT_PATH="$ROOT_DIR/Audit/output/GENERAL-AUDIT-REPORT.md"

"$PY_CMD" "$ROOT_DIR/scripts/run_general_audit.py" \
  --root "$ROOT_DIR" \
  --out "$OUT_PATH" \
  $FAIL_FLAG \
  "${TARGETS[@]}"
