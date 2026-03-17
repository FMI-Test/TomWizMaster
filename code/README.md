# Code Infrastructure

This directory contains the project's source code, build artifacts, staging area, and packages.

## Directory Structure

### `src/` (Library Source Code)

Reusable source modules and package-oriented Python code.

### `scripts/` (Automation Scripts)

Operational CLI scripts with `-h`/`--help` support.

- `update-iso-data.py`: ISO data utility.
- `update-istripper-4k.py`: 4K text replacement utility for scene/shader files.
- `generate-exec-summary.py`: Executive summary/deck generator.
- `generate-media-assets.py`: Media plan/prompt generator.
- `oss-audit-www-references.sh`: OSS path audit script.
- `oss-cleanup-www-references.sh`: Guided cleanup script.
- `publish.sh`: Publication bootstrap script.

### `term/` (Terminal Setup)

Terminal setup snippets and notebooks.

### `build/` (Build Artifacts)

Destination for deployment artifacts and build outputs.

### `stg/` (Staging)

Staging area for intermediate files and testing.

## Terminal Setup

To configure your terminal, refer to `term/Terminal_Setup.ipynb` or source the snippets in `term/`.
