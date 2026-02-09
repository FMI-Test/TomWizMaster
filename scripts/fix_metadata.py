#!/usr/bin/env python3
import os
import re
from pathlib import Path
from datetime import datetime

ROOT = Path(__file__).resolve().parents[1]
MD_EXT = {'.md'}

def add_metadata_to_file(file_path):
    with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
        content = f.read()

    lines = content.split('\n')
    # Check if metadata already present
    has_version = any('Version:' in line for line in lines[:10])
    has_status = any('Status:' in line for line in lines[:10])
    has_last_updated = any('Last Updated:' in line for line in lines[:10])

    metadata_lines = []
    if not has_version:
        metadata_lines.append('Version: 1.0')
    if not has_status:
        metadata_lines.append('Status: draft')
    if not has_last_updated:
        metadata_lines.append(f'Last Updated: {datetime.now().strftime("%Y-%m-%d")}')

    if metadata_lines:
        new_content = '\n'.join(metadata_lines) + '\n\n' + content
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Added metadata to {file_path}")

def main():
    for root, dirs, files in os.walk(ROOT):
        for file in files:
            if Path(file).suffix in MD_EXT:
                file_path = Path(root) / file
                add_metadata_to_file(file_path)

if __name__ == '__main__':
    main()
