# NSFW Content Audit Report

**Report Generated:** January 29, 2026
**Model:** GitHub Copilot (Claude Opus 4.5)
**Workspace:** /Users/bamdad/www/GenAI-RD

---

## Executive Summary

This audit identifies NSFW (Not Safe For Work) content in the workspace that is **NOT ALIGNED** with the professional tone and AI ethics messaging established in the project's documentation (particularly `GUARDRAILS.md`, `CONSTITUTION.md`, and `MANIFESTO.md`).

---

## 🚨 NSFW Content Identified

### Location: `Assets/NFSW/`

The folder is named "NFSW" (typo of NSFW). It contains the following subdirectories:

| Folder | Status | Recommendation |
|--------|--------|----------------|
| `ai.model/` | ⚠️ Contains explicit adult content references | **DELETE** |
| `SB/` | Empty (only .DS_Store) | Delete or repurpose |
| `Tall/` | Empty (only .DS_Store) | Delete or repurpose |
| `Test/` | Empty (only .DS_Store) | Delete or repurpose |
| `Upskirt/` | ⚠️ Folder name suggests inappropriate content | **DELETE** |
| `Web/` | Empty (only .DS_Store) | Delete or repurpose |
| `Wide/` | Empty (only .DS_Store) | Delete or repurpose |

### Specific Content Found (Now Deleted or Indexed)

The semantic search index previously contained references to:
- **File:** `ai.model/Vanessa Angel Nude in Marble - Free Metart Picture Gallery at Elite Babes.html`
- **Content Type:** Adult/explicit website content (saved HTML page from adult website)
- **Contains:** Explicit sexual descriptions, links to nude/pornographic galleries

---

## ❌ Alignment Violations

This content directly violates the project's own stated principles in `GUARDRAILS.md`:

| Guardrail Category | Violation |
|--------------------|-----------|
| **Harm** | Adult content without consent context |
| **Manipulation** | Objectifying content |
| **Reputation** | Unprofessional content in professional repository |

---

## ✅ Recommendations

### Immediate Actions

1. **DELETE the entire `Assets/NFSW/` folder**
   ```bash
   rm -rf "/Users/bamdad/www/GenAI-RD/Assets/NFSW"
   ```

2. **Add to `.gitignore`** (prevent future accidental commits):
   ```
   # NSFW content exclusion
   **/NSFW/
   **/NFSW/
   ```

3. **Git history cleanup** (if already committed):
   > Note: This step rewrites Git history. Coordinate with all collaborators and be prepared to force-push rewritten branches.
   >
   > You need [`git-filter-repo`](https://github.com/newren/git-filter-repo) installed (it may be available as a package on your system, or via `pip install git-filter-repo`).
   ```bash
   # From the repository root, remove Assets/NFSW from all history
   git filter-repo --path Assets/NFSW --invert-paths

   # After verifying locally, force-push the rewritten history:
   git push --force --all
   git push --force --tags
   ```

### Location: `AI-Guardrails-and-Bias/iStripper-model-user/`

| Folder | Status | Note |
|--------|--------|------|
| `iStripper-model-user/` | Empty | Folder name references adult entertainment software |

**Recommendation:** Delete if not needed for legitimate analysis purposes.

---

## 📋 Content Classification Summary

### ❌ DELETE (Not Aligned - NSFW/Controversial)

| Path | Reason |
|------|--------|
| `Assets/NFSW/` (entire folder) | Adult/explicit content, inappropriate folder names |
| `Assets/images/(4) Instagram_files/` | External cached JS files, not project code |

### ✅ KEEP (Safe/Professional)

- All `.md` documentation files
- `scripts/` directory
- `showtell/` directory
- Configuration files (`.yaml`, `.json`)
- `publish.sh`, `update_iso_data.py`
- All subdirectories with legitimate project content

---

## Audit Methodology

1. Directory structure enumeration
2. Semantic search for NSFW/explicit keywords
3. File content analysis
4. Cross-reference with project's stated ethics guidelines

---

## Sign-off

**Status:** NSFW content identified and flagged for removal
**Action Required:** Manual deletion of flagged folders
**Compliance:** Will be aligned with GUARDRAILS.md after cleanup
