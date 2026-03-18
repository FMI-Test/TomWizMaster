#!/bin/bash
# OSS Release Cleanup: Automated cleanup of www and internal path references
# Purpose: Semi-automated cleanup with human confirmation at each step
# Human-in-the-Loop: Prompts y/n at each cleanup stage

set -euo pipefail

show_help() {
    cat <<'EOF'
Usage: oss-cleanup-www-references.sh [OPTIONS]

Run guided cleanup for local-path references in docs/config files.

Options:
  -h, --help          Show this help message and exit
EOF
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo "Error: Unknown option '$1'"
            show_help
            exit 1
            ;;
    esac
done

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "${REPO_ROOT}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${GREEN}======================================${NC}"
echo -e "${GREEN}OSS Release Cleanup: WWW References${NC}"
echo -e "${GREEN}======================================${NC}"
echo ""

# Human-in-the-Loop confirmation function
confirm() {
    local prompt="$1"
    local response

    while true; do
        read -p "$(echo -e ${YELLOW}${prompt}${NC} [y/n]: )" response
        case $response in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer y or n.";;
        esac
    done
}

# Function to backup before changes
backup_file() {
    local file="$1"
    cp "${file}" "${file}.backup-$(date +%Y%m%d-%H%M%S)"
    echo -e "${GREEN}✓${NC} Backed up: ${file}"
}

echo -e "${BLUE}Step 1: Core Documentation Cleanup${NC}"
echo "This will update One-Shot and Alliance-to-Empire files with relative paths."
echo ""

if confirm "Clean up One-Shot/GEMINI-INVITE.md?"; then
    backup_file "One-Shot/GEMINI-INVITE.md"

    sed -i.bak \
        -e 's|/workspaces/WSO/GenAI-R\&D/One-Shot|One-Shot|g' \
        -e 's|/workspaces/WSO/||g' \
        "One-Shot/GEMINI-INVITE.md"

    rm "One-Shot/GEMINI-INVITE.md.bak"
    echo -e "${GREEN}✅ Cleaned: One-Shot/GEMINI-INVITE.md${NC}"
fi

if confirm "Clean up One-Shot/GPT-RED-TEAM-INVITE.md?"; then
    backup_file "One-Shot/GPT-RED-TEAM-INVITE.md"

    sed -i.bak \
        -e 's|/workspaces/WSO/GenAI-R\&D/One-Shot/README.md|One-Shot/README.md|g' \
        -e 's|/workspaces/WSO/GenAI-R\&D/One-Shot/Google/|One-Shot/Google/|g' \
        -e 's|/workspaces/WSO/GenAI-R\&D/One-Shot/OpenAI/|One-Shot/OpenAI/|g' \
        "One-Shot/GPT-RED-TEAM-INVITE.md"

    rm "One-Shot/GPT-RED-TEAM-INVITE.md.bak"
    echo -e "${GREEN}✅ Cleaned: One-Shot/GPT-RED-TEAM-INVITE.md${NC}"
fi

if confirm "Clean up One-Shot/Google/JURY-DELIBERATION-PACKET.md?"; then
    backup_file "One-Shot/Google/JURY-DELIBERATION-PACKET.md"

    sed -i.bak \
        -e 's|/workspaces/WSO/GenAI-R\&D/One-Shot/OpenAI/GPT-DISSENT.md|One-Shot/OpenAI/GPT-DISSENT.md|g' \
        -e 's|/workspaces/WSO/GenAI-R\&D/One-Shot/Google/FINAL-VERDICT.md|One-Shot/Google/FINAL-VERDICT.md|g' \
        "One-Shot/Google/JURY-DELIBERATION-PACKET.md"

    rm "One-Shot/Google/JURY-DELIBERATION-PACKET.md.bak"
    echo -e "${GREEN}✅ Cleaned: One-Shot/Google/JURY-DELIBERATION-PACKET.md${NC}"
fi

if confirm "Clean up Alliance-to-Empire/AI-PERSONA.md?"; then
    backup_file "Alliance-to-Empire/AI-PERSONA.md"

    sed -i.bak \
        -e 's|/workspaces/WSO/|[workspace root]/|g' \
        "Alliance-to-Empire/AI-PERSONA.md"

    rm "Alliance-to-Empire/AI-PERSONA.md.bak"
    echo -e "${GREEN}✅ Cleaned: Alliance-to-Empire/AI-PERSONA.md${NC}"
fi

if confirm "Clean up Alliance-to-Empire/TODO.md?"; then
    backup_file "Alliance-to-Empire/TODO.md"

    sed -i.bak \
        -e 's|/workspaces/WSO/kb/|KB/|g' \
        "Alliance-to-Empire/TODO.md"

    rm "Alliance-to-Empire/TODO.md.bak"
    echo -e "${GREEN}✅ Cleaned: Alliance-to-Empire/TODO.md${NC}"
fi

if confirm "Clean up Alliance-to-Empire/SUMMARY.md?"; then
    backup_file "Alliance-to-Empire/SUMMARY.md"

    sed -i.bak \
        -e 's|/workspaces/WSO/kb/|KB/|g' \
        "Alliance-to-Empire/SUMMARY.md"

    rm "Alliance-to-Empire/SUMMARY.md.bak"
    echo -e "${GREEN}✅ Cleaned: Alliance-to-Empire/SUMMARY.md${NC}"
fi

if confirm "Clean up HELLO-WORLD.md?"; then
    backup_file "HELLO-WORLD.md"

    sed -i.bak \
        -e 's|source: /workspaces/WSO/GenAI-R\&D/One-Shot/images/|source: One-Shot/images/|g' \
        "HELLO-WORLD.md"

    rm "HELLO-WORLD.md.bak"
    echo -e "${GREEN}✅ Cleaned: HELLO-WORLD.md${NC}"
fi

echo ""
echo -e "${BLUE}Step 2: Configuration & Technical Files${NC}"
echo "This will update git commands and paths in technical documentation."
echo ""

if confirm "Clean up AI-Guardrails-and-Bias/DEEP-DiVE.md?"; then
    backup_file "AI-Guardrails-and-Bias/DEEP-DiVE.md"

    sed -i.bak \
        -e 's|git -C /workspaces/GenAI-RD|git|g' \
        -e 's|/workspaces/GenAI-RD/|./|g' \
        "AI-Guardrails-and-Bias/DEEP-DiVE.md"

    rm "AI-Guardrails-and-Bias/DEEP-DiVE.md.bak"
    echo -e "${GREEN}✅ Cleaned: AI-Guardrails-and-Bias/DEEP-DiVE.md${NC}"
fi

if confirm "Clean up AI-Guardrails-and-Bias/LEGAL-RISK-AUDIT-xAI-Grok.md?"; then
    backup_file "AI-Guardrails-and-Bias/LEGAL-RISK-AUDIT-xAI-Grok.md"

    sed -i.bak \
        -e 's|git -C /workspaces/GenAI-RD|git|g' \
        -e 's|/workspaces/GenAI-RD/|./|g' \
        "AI-Guardrails-and-Bias/LEGAL-RISK-AUDIT-xAI-Grok.md"

    rm "AI-Guardrails-and-Bias/LEGAL-RISK-AUDIT-xAI-Grok.md.bak"
    echo -e "${GREEN}✅ Cleaned: AI-Guardrails-and-Bias/LEGAL-RISK-AUDIT-xAI-Grok.md${NC}"
fi

if confirm "Clean up media/README.md?"; then
    backup_file "media/README.md"

    sed -i.bak \
        -e 's|/workspaces/GenAI-RD/.venv/bin/python|python3|g' \
        "media/README.md"

    rm "media/README.md.bak"
    echo -e "${GREEN}✅ Cleaned: media/README.md${NC}"
fi

if confirm "Clean up code/term/Terminal_Setup.ipynb?"; then
    backup_file "code/term/Terminal_Setup.ipynb"

    sed -i.bak \
        -e 's|\${userHome}/www/GenAI-RD|\${workspaceFolder}|g' \
        -e 's|\$HOME/www|\$HOME/workspace|g' \
        "code/term/Terminal_Setup.ipynb"

    rm "code/term/Terminal_Setup.ipynb.bak"
    echo -e "${GREEN}✅ Cleaned: code/term/Terminal_Setup.ipynb${NC}"
fi

echo ""
echo -e "${BLUE}Step 3: Auto-Generated Files${NC}"
echo "These files should be regenerated after cleanup."
echo ""

if confirm "Regenerate media outputs?"; then
    echo -e "${YELLOW}Note: You'll need to run the media generator manually:${NC}"
    echo -e "  ${BLUE}python3 code/scripts/generate-media-assets.py media/config.yaml${NC}"
    echo ""
    echo -e "${YELLOW}Skipping for now - mark as manual step${NC}"
fi

echo ""
echo -e "${BLUE}Step 4: Exclusions from OSS Release${NC}"
echo "The following directories contain sensitive or personal content:"
echo ""

if confirm "Add Meta/ to .gitignore for OSS release?"; then
    if ! grep -q "^Meta/" .gitignore 2>/dev/null; then
        echo "" >> .gitignore
        echo "# OSS Release Exclusions" >> .gitignore
        echo "Meta/" >> .gitignore
        echo -e "${GREEN}✅ Added Meta/ to .gitignore${NC}"
    else
        echo -e "${YELLOW}Meta/ already in .gitignore${NC}"
    fi
fi

if confirm "Add Assets/NFSW/ to .gitignore for OSS release?"; then
    if ! grep -q "^Assets/NFSW/" .gitignore 2>/dev/null; then
        echo "Assets/NFSW/" >> .gitignore
        echo -e "${GREEN}✅ Added Assets/NFSW/ to .gitignore${NC}"
    else
        echo -e "${YELLOW}Assets/NFSW/ already in .gitignore${NC}"
    fi
fi

if confirm "Add Love/ to .gitignore for OSS release?"; then
    if ! grep -q "^Love/" .gitignore 2>/dev/null; then
        echo "Love/" >> .gitignore
        echo -e "${GREEN}✅ Added Love/ to .gitignore${NC}"
    else
        echo -e "${YELLOW}Love/ already in .gitignore${NC}"
    fi
fi

if confirm "Add Screenshot*.png to .gitignore for OSS release?"; then
    if ! grep -q "^Screenshot.*\\.png" .gitignore 2>/dev/null; then
        echo "Screenshot*.png" >> .gitignore
        echo -e "${GREEN}✅ Added Screenshot*.png to .gitignore${NC}"
    else
        echo -e "${YELLOW}Screenshot*.png already in .gitignore${NC}"
    fi
fi

echo ""
echo -e "${GREEN}======================================${NC}"
echo -e "${GREEN}Cleanup Summary${NC}"
echo -e "${GREEN}======================================${NC}"
echo ""
echo -e "${YELLOW}Completed cleanup steps:${NC}"
echo "  - Core documentation updated with relative paths"
echo "  - Technical files cleaned of absolute paths"
echo "  - OSS exclusions added to .gitignore"
echo ""
echo -e "${YELLOW}Manual steps remaining:${NC}"
echo "  1. Regenerate media outputs: python3 code/scripts/generate-media-assets.py media/config.yaml"
echo "  2. Review Ugly-Truth/ content for legal clearance"
echo "  3. Decision on git history cleanup (keep or BFG)"
echo "  4. Commit cleanup changes"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "  1. Review changes: git diff"
echo "  2. Run audit again: code/scripts/oss-audit-www-references.sh"
echo "  3. Commit if satisfied: git add -A && git commit -m 'OSS cleanup: remove internal paths'"
echo "  4. Follow OSS-RELEASE-READINESS.md checklist"
echo ""
