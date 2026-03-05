#!/bin/bash
# OSS Release Audit: Find all www and internal path references
# Purpose: Comprehensive 100x audit of sensitive file paths for OSS release
# Human-in-the-Loop: Generates report for review before cleanup

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
AUDIT_OUTPUT_DIR="${REPO_ROOT}/Audit/output"
TIMESTAMP=$(date +"%Y-%m-%d-%H%M")
AUDIT_REPORT="${AUDIT_OUTPUT_DIR}/WWW-AUDIT-${TIMESTAMP}.md"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}==================================${NC}"
echo -e "${GREEN}OSS Release Audit: WWW References${NC}"
echo -e "${GREEN}==================================${NC}"
echo ""

mkdir -p "${AUDIT_OUTPUT_DIR}"

# Start audit report
cat > "${AUDIT_REPORT}" << 'EOF'
# WWW References Audit Report

**Date:** $(date +"%Y-%m-%d %H:%M:%S")
**Purpose:** Identify all internal path references for OSS release cleanup
**Audit Scope:** 100x comprehensive scan

---

## Executive Summary

EOF

# Function to count occurrences
count_pattern() {
    local pattern="$1"
    local count
    count=$(git grep -E "${pattern}" 2>/dev/null | wc -l | tr -d ' ')
    echo "${count}"
}

# Scan patterns
echo -e "${YELLOW}Scanning for sensitive patterns...${NC}"

PATTERNS=(
    "/Users/bamdad/www"
    "/Users/bamdad"
    "/Users/"
    "/home/"
    "C:\\\\"
    "www/WSO"
    "www/GenAI-RD"
)

TOTAL_ISSUES=0

for pattern in "${PATTERNS[@]}"; do
    count=$(count_pattern "${pattern}")
    TOTAL_ISSUES=$((TOTAL_ISSUES + count))
    echo -e "  ${YELLOW}${pattern}${NC}: ${count} matches"
done

echo ""
echo -e "**Total Issues Found:** ${TOTAL_ISSUES}" >> "${AUDIT_REPORT}"
echo "" >> "${AUDIT_REPORT}"

# Detailed findings by pattern
echo "## Detailed Findings" >> "${AUDIT_REPORT}"
echo "" >> "${AUDIT_REPORT}"

for pattern in "${PATTERNS[@]}"; do
    count=$(count_pattern "${pattern}")
    if [ "$count" -gt 0 ]; then
        echo "### Pattern: \`${pattern}\` (${count} matches)" >> "${AUDIT_REPORT}"
        echo "" >> "${AUDIT_REPORT}"
        
        # List files with this pattern
        git grep -l -E "${pattern}" 2>/dev/null | while read -r file; do
            echo "- ${file}" >> "${AUDIT_REPORT}"
        done
        
        echo "" >> "${AUDIT_REPORT}"
    fi
done

# File-by-file breakdown
echo "## File-by-File Analysis" >> "${AUDIT_REPORT}"
echo "" >> "${AUDIT_REPORT}"
echo "| File | Issue Count | Patterns Found |" >> "${AUDIT_REPORT}"
echo "|------|-------------|----------------|" >> "${AUDIT_REPORT}"

git grep -l -E "/Users/|/home/|www" 2>/dev/null | while read -r file; do
    # Skip audit outputs and git directory
    if [[ "$file" == Audit/output/* ]] || [[ "$file" == Audit/logs/* ]] || [[ "$file" == .git/* ]]; then
        continue
    fi
    
    count=$(grep -c -E "/Users/|/home/|www" "$file" 2>/dev/null || echo "0")
    
    if [ "$count" -gt 0 ]; then
        # Get unique patterns found
        patterns=$(grep -o -E "/Users/bamdad/www/[^[:space:]\"'<>]*|/Users/[^[:space:]\"'<>]*|/home/[^[:space:]\"'<>]*|www/[^[:space:]\"'<>]*" "$file" 2>/dev/null | sort -u | head -3 | tr '\n' ', ' | sed 's/,$//')
        
        echo "| ${file} | ${count} | ${patterns} |" >> "${AUDIT_REPORT}"
    fi
done

echo "" >> "${AUDIT_REPORT}"

# Categorize by file type
echo "## Analysis by File Type" >> "${AUDIT_REPORT}"
echo "" >> "${AUDIT_REPORT}"

for ext in md sh json yaml py ipynb html; do
    count=$(git grep -l -E "/Users/|/home/|www" -- "*.${ext}" 2>/dev/null | wc -l | tr -d ' ')
    if [ "$count" -gt 0 ]; then
        echo "- **${ext} files:** ${count} files affected" >> "${AUDIT_REPORT}"
    fi
done

echo "" >> "${AUDIT_REPORT}"

# High-priority files (exclude auto-generated)
echo "## High-Priority Cleanup (Manual Review Required)" >> "${AUDIT_REPORT}"
echo "" >> "${AUDIT_REPORT}"

git grep -l -E "/Users/bamdad/www/WSO" 2>/dev/null | while read -r file; do
    # Skip auto-generated files
    if [[ "$file" != media/output/* ]] && [[ "$file" != Audit/output/* ]] && [[ "$file" != OSS-RELEASE-READINESS.md ]]; then
        matches=$(grep -n -E "/Users/bamdad/www/WSO" "$file" | head -5)
        echo "### ${file}" >> "${AUDIT_REPORT}"
        echo '```' >> "${AUDIT_REPORT}"
        echo "$matches" >> "${AUDIT_REPORT}"
        echo '```' >> "${AUDIT_REPORT}"
        echo "" >> "${AUDIT_REPORT}"
    fi
done

# Recommendations
echo "## Cleanup Recommendations" >> "${AUDIT_REPORT}"
echo "" >> "${AUDIT_REPORT}"
cat >> "${AUDIT_REPORT}" << 'REOF'
### Priority 1: Core Documentation (Manual)
- `One-Shot/GEMINI-INVITE.md` - Replace `/Users/bamdad/www/WSO/` with relative paths
- `One-Shot/GPT-RED-TEAM-INVITE.md` - Replace `/Users/bamdad/www/WSO/` with relative paths
- `One-Shot/Google/JURY-DELIBERATION-PACKET.md` - Replace `/Users/bamdad/www/WSO/` with relative paths
- `Alliance-to-Empire/AI-PERSONA.md` - Replace `/Users/bamdad/www/WSO/` with relative paths
- `HELLO-WORLD.md` - Replace `/Users/bamdad/www/WSO/` with relative paths

### Priority 2: Media & Generated Files (Automated)
- `media/README.md` - Update script path to use `python3` instead of full path
- `media/output/*.md` - Regenerate with relative paths
- `code/term/Terminal_Setup.ipynb` - Replace `${userHome}/www` with `${userHome}/workspace` or similar

### Priority 3: Configuration (Automated)
- `AI-Guardrails-and-Bias/DEEP-DiVE.md` - Replace git commands with relative paths
- `AI-Guardrails-and-Bias/LEGAL-RISK-AUDIT-xAI-Grok.md` - Replace git commands with relative paths

### Priority 4: Archive or Exclude
- `Meta/README.md` - Contains `/Users/bamdad/iStripper/` paths (consider excluding from OSS)
- `Assets/NFSW/` - NSFW content (exclude from OSS release)
- `Love/` - Personal content (exclude from OSS release)

REOF

# URLs are OK section
echo "## Acceptable References (No Action Required)" >> "${AUDIT_REPORT}"
echo "" >> "${AUDIT_REPORT}"
echo "The following URL patterns are public-facing and safe for OSS:" >> "${AUDIT_REPORT}"
echo "- \`https://www.apache.org/*\` - Apache License references" >> "${AUDIT_REPORT}"
echo "- \`https://www.youtube.com/*\` - Public video links" >> "${AUDIT_REPORT}"
echo "- \`https://www.linkedin.com/*\` - Public LinkedIn articles" >> "${AUDIT_REPORT}"
echo "- \`https://www.perplexity.ai/*\` - Public Perplexity searches" >> "${AUDIT_REPORT}"
echo "- Other public URLs (GitHub, documentation sites, etc.)" >> "${AUDIT_REPORT}"
echo "" >> "${AUDIT_REPORT}"

# Human-in-the-Loop Decision Points
echo "## Human Decision Points (Requires Review)" >> "${AUDIT_REPORT}"
echo "" >> "${AUDIT_REPORT}"
cat >> "${AUDIT_REPORT}" << 'DEOF'
### ⚠️ Decision Required

1. **Exclude from OSS Release:**
   - [ ] `Meta/` directory (iStripper references)
   - [ ] `Assets/NFSW/` directory (NSFW content)
   - [ ] `Love/` directory (personal content)
   - [ ] `Ugly-Truth/` directory (commentary on Iran regime - legal review needed)
   - [ ] Screenshot files (may contain sensitive data)

2. **Cleanup Strategy:**
   - [ ] Manual cleanup for core docs (One-Shot, Alliance-to-Empire)
   - [ ] Automated cleanup for media/generated files  
   - [ ] Regenerate media outputs with relative paths

3. **Git History:**
   - [ ] Keep full history (transparent evolution)
   - [ ] Squash/rewrite history (clean slate)
   - [ ] Use BFG Repo-Cleaner to remove sensitive files from history

4. **Approval:**
   - [ ] Technical review complete
   - [ ] Legal review complete (especially Ugly-Truth/ content)
   - [ ] Security review complete
   - [ ] Ready to proceed with cleanup

DEOF

# Next steps
echo "## Next Steps" >> "${AUDIT_REPORT}"
echo "" >> "${AUDIT_REPORT}"
echo "1. Review this audit report" >> "${AUDIT_REPORT}"
echo "2. Make human decisions on exclusions and cleanup strategy" >> "${AUDIT_REPORT}"
echo "3. Run automated cleanup script: \`scripts/oss-cleanup-www-references.sh\`" >> "${AUDIT_REPORT}"
echo "4. Manual cleanup of core documentation files" >> "${AUDIT_REPORT}"
echo "5. Verify no sensitive data remains: \`scripts/oss-audit-www-references.sh\`" >> "${AUDIT_REPORT}"
echo "6. Follow OSS-RELEASE-READINESS.md checklist" >> "${AUDIT_REPORT}"
echo "" >> "${AUDIT_REPORT}"

# Footer
echo "---" >> "${AUDIT_REPORT}"
echo "" >> "${AUDIT_REPORT}"
echo "**Audit Complete:** $(date +"%Y-%m-%d %H:%M:%S")" >> "${AUDIT_REPORT}"
echo "**Report:** ${AUDIT_REPORT}" >> "${AUDIT_REPORT}"
echo "**Next:** Review findings and make decisions before proceeding with cleanup" >> "${AUDIT_REPORT}"

echo ""
echo -e "${GREEN}✅ Audit complete!${NC}"
echo -e "${GREEN}Report saved to: ${AUDIT_REPORT}${NC}"
echo ""
echo -e "${YELLOW}Found ${TOTAL_ISSUES} total references to review${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "  1. Review the audit report"
echo "  2. Make decisions on exclusions"
echo "  3. Run cleanup script when ready"
echo ""
