#!/bin/bash

# Configuration
SOURCE_DIR=$(pwd)
TARGET_DIR="$HOME/GenAI-Courtroom-Protocols"
BROKEN_LINK_FILE="One-Shot/HUMAN-PROFILE-ANALYSIS.md"

show_help() {
    cat <<'EOF'
Usage: publish.sh [OPTIONS]

Copy repository content to a target directory and initialize a git repository.

Options:
  -h, --help               Show this help message and exit
  -s, --source-dir PATH    Source directory to copy (default: current directory)
  -t, --target-dir PATH    Target directory (default: $HOME/GenAI-Courtroom-Protocols)
  --skip-git-init          Skip git init/add/commit step
EOF
}

SKIP_GIT_INIT=0
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            show_help
            exit 0
            ;;
        -s|--source-dir)
            if [[ $# -lt 2 ]]; then
                echo "Error: --source-dir requires a value"
                exit 1
            fi
            SOURCE_DIR="$2"
            shift 2
            ;;
        -t|--target-dir)
            if [[ $# -lt 2 ]]; then
                echo "Error: --target-dir requires a value"
                exit 1
            fi
            TARGET_DIR="$2"
            shift 2
            ;;
        --skip-git-init)
            SKIP_GIT_INIT=1
            shift
            ;;
        *)
            echo "Error: Unknown option '$1'"
            show_help
            exit 1
            ;;
    esac
done

echo "🚀 Starting Publication Process..."
echo "Source: $SOURCE_DIR"
echo "Target: $TARGET_DIR"

# 1. Create Target Directory
if [ -d "$TARGET_DIR" ]; then
    echo "⚠️  Target directory exists. removing..."
    rm -rf "$TARGET_DIR"
fi
mkdir -p "$TARGET_DIR"

# 2. Copy Content
echo "📦 Copying files..."
cp -r "$SOURCE_DIR/"* "$TARGET_DIR/"

# 3. Clean up (Don't copy git metadata if any, or this script)
rm -f "$TARGET_DIR/code/scripts/publish.sh"
rm -f "$TARGET_DIR/PUBLISH_PREP.md" # Optional, but maybe we want to keep it? User said "only content of...". I'll keep it as it documents the process.

# 4. Patch Broken Links
echo "🔧 Patching external dependencies..."
if [ -f "$TARGET_DIR/$BROKEN_LINK_FILE" ]; then
    # Replace ../../JavaScript... with a note
    # using | as delimiter for sed to handle slashes
    sed -i '' 's|\[AI-Risks-Pioneers-Perspectives.md\](\.\./\.\./JavaScript/wiki/AI-Risks-Pioneers-Perspectives\.md)|[AI-Risks-Pioneers-Perspectives.md] (External Link Removed)|g' "$TARGET_DIR/$BROKEN_LINK_FILE"
    echo "   Fixed link in $BROKEN_LINK_FILE"
else
    echo "⚠️  Could not find $BROKEN_LINK_FILE to patch."
fi

# 5. Initialize Git
if [ "$SKIP_GIT_INIT" -eq 0 ]; then
    echo "git init..."
    cd "$TARGET_DIR"
    git init -b main

    # 6. Create Initial Commit
    git add .
    git commit -m "Initial commit from One-Shot Framework"
fi

echo "✅ Repository Ready at $TARGET_DIR"
echo " "
echo "Next Steps:"
echo "1. cd $TARGET_DIR"
echo "2. git remote add origin https://github.com/YOUR_USERNAME/GenAI-Courtroom-Protocols.git"
echo "3. git push -u origin main"
