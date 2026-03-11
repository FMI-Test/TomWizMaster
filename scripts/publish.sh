#!/bin/bash

# Configuration
SOURCE_DIR=$(pwd)
TARGET_DIR="$HOME/GenAI-Courtroom-Protocols"
BROKEN_LINK_FILE="One-Shot/HUMAN-PROFILE-ANALYSIS.md"

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
rm -f "$TARGET_DIR/publish.sh"
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
echo "git init..."
cd "$TARGET_DIR"
git init -b main

# 6. Create Initial Commit
git add .
git commit -m "Initial commit from One-Shot Framework"

echo "✅ Repository Ready at $TARGET_DIR"
echo " "
echo "Next Steps:"
echo "1. cd $TARGET_DIR"
echo "2. git remote add origin https://github.com/YOUR_USERNAME/GenAI-Courtroom-Protocols.git"
echo "3. git push -u origin main"
