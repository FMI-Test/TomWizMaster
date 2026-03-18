#!/usr/bin/env python3
import argparse
import os
import shutil

# Configuration
TARGET_DIR = os.environ.get("ISTRIPPER_SCENES_DIR", "/workspaces/iStripper/data/scenes")
EXTENSIONS = {'.fsh', '.scn'}
REPLACEMENTS = {
    '1920': '3840',
    '1080': '2160',  # Common 1080p -> 4K
    'width="1920"': 'width="3840"', # XML/HTML specific safety
    'height="1080"': 'height="2160"',
    # Potential floats in shaders
    '1920.0': '3840.0',
    '1080.0': '2160.0',
    'vec2(1920, 1080)': 'vec2(3840, 2160)',
    'vec2(1920., 1080.)': 'vec2(3840., 2160.)',
    # Specific safe scene properties
    'size: 1920, 1080': 'size: 3840, 2160',
    'res: 1920, 1080': 'res: 3840, 2160'
}

def is_text_file(filepath):
    """Check if file is text by trying to read potential binary characters."""
    try:
        with open(filepath, 'rb') as f:
            chunk = f.read(1024)
            if b'\0' in chunk:
                return False
            return True
    except Exception:
        return False

def process_file(filepath):
    print(f"Checking: {filepath}")

    if not is_text_file(filepath):
        print(f"Skipping binary file: {filepath}")
        return

    try:
        with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
    except Exception as e:
        print(f"Error reading {filepath}: {e}")
        return

    modified = False

    # Simple replace
    new_content = content
    for old, new in REPLACEMENTS.items():
        if old in new_content:
            new_content = new_content.replace(old, new)
            modified = True
            print(f"  - Replaced {old} with {new}")

    if modified:
        # Create backup
        backup_path = filepath + ".bak"
        shutil.copy2(filepath, backup_path)
        print(f"  - Backup created: {backup_path}")

        # Write changes
        try:
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(new_content)
            print(f"  - Updated {filepath}")
        except Exception as e:
            print(f"Error writing {filepath}: {e}")
    else:
        print("  - No changes needed.")

def main():
    parser = argparse.ArgumentParser(
        description="Replace common 1080p dimensions with 4K dimensions in iStripper scene/shader text files."
    )
    parser.add_argument(
        "target_dir",
        nargs="?",
        default=TARGET_DIR,
        help="Directory to scan recursively (default: $ISTRIPPER_SCENES_DIR or /workspaces/iStripper/data/scenes)",
    )
    args = parser.parse_args()
    target_dir = args.target_dir

    if not os.path.exists(target_dir):
        print(f"Error: Directory not found: {target_dir}")
        print("Please check the path or pass a valid directory path.")
        raise SystemExit(1)

    print(f"Scanning directory: {target_dir}")
    print(f"Target extensions: {EXTENSIONS}")
    print("---")

    count = 0
    for root, dirs, files in os.walk(target_dir):
        for file in files:
            ext = os.path.splitext(file)[1].lower()
            if ext in EXTENSIONS:
                filepath = os.path.join(root, file)
                process_file(filepath)
                count += 1

    print(f"---\nProcessed {count} files.")

if __name__ == "__main__":
    main()
