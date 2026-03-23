#!/usr/bin/env python3
import os
import re
import sys
import subprocess
import argparse

TARGET_FILES = [
    os.path.expanduser('~/.bashrc'),
    os.path.expanduser('~/.zshrc'),
    os.path.expanduser('~/.bash_profile'),
    os.path.expanduser('~/.bashrc.sh'),
    os.path.abspath(os.path.join(os.path.dirname(__file__), 'zshrc_backup.sh'))
]

SEARCH_DIRS = [
    os.path.abspath(os.path.dirname(__file__)),
    os.path.expanduser('~/W3/Code/sh'),
    os.path.expanduser('~/W3/Code/python'),
    os.path.expanduser('~/W3/WSO/JavaScript/bin')
]

def parse_rc_file(filepath):
    commands = {}
    if not os.path.exists(filepath):
        return commands

    with open(filepath, 'r') as f:
        content = f.read()

    # Find aliases
    for match in re.finditer(r'^alias\s+([^=]+)=(.+)$', content, re.MULTILINE):
        name = match.group(1).strip()
        val = match.group(2).strip().strip('\'"')
        commands[name] = {"type": "alias", "doc": val, "file": filepath, "executable": val}

    # Find functions
    for match in re.finditer(r'^(?:function\s+)?([a-zA-Z0-9_\-]+)\s*\(\)\s*\{', content, re.MULTILINE):
        name = match.group(1).strip()
        commands[name] = {"type": "function", "doc": f"Shell function found in {os.path.basename(filepath)}", "file": filepath, "executable": name}

    return commands

def scan_executable_scripts():
    commands = {}
    for d in SEARCH_DIRS:
        if not os.path.exists(d):
            continue
        for root, _, files in os.walk(d):
            for file in files:
                if file.endswith('.sh') or file.endswith('.py') or file.startswith('tom-wiz'):
                    path = os.path.join(root, file)
                    doc = f"Script: {file}"
                    try:
                        with open(path, 'r') as f:
                            lines = f.readlines()
                            for line in lines[:5]:
                                if line.startswith('#') and not line.startswith('#!'):
                                    doc = line.strip('# \n')
                                    break
                                elif line.startswith('"""') or line.startswith("'''"):
                                    doc = line.strip('\'" \n')
                                    break
                    except Exception:
                        pass

                    name = os.path.splitext(file)[0]
                    exec_cmd = f"bash {path}" if file.endswith('.sh') else f"python3 {path}"

                    commands[name] = {"type": "script", "doc": doc, "file": path, "executable": exec_cmd}
    return commands

def list_commands():
    cmds = {}
    for f in TARGET_FILES:
        cmds.update(parse_rc_file(f))
    cmds.update(scan_executable_scripts())

    print(f"{'Command':<30} | {'Type':<10} | {'Description'}")
    print("-" * 80)
    for name, info in sorted(cmds.items()):
        doc = info['doc'][:45] + "..." if len(info['doc']) > 45 else info['doc']
        print(f"{name:<30} | {info['type']:<10} | {doc}")
    return cmds

def run_command(name):
    cmds = {}
    for f in TARGET_FILES:
        cmds.update(parse_rc_file(f))
    cmds.update(scan_executable_scripts())

    if name not in cmds:
        print(f"Command '{name}' not found.")
        sys.exit(1)

    info = cmds[name]
    print(f"[{info['type'].upper()}] Executing: {info['executable']}\n")

    if info['type'] == 'alias':
        # Alias evaluation requires a shell properly sourcing it, tricky, so fallback to subprocess shell eval
        subprocess.run(info['executable'], shell=True)
    elif info['type'] == 'function':
        subprocess.run(f"source {info['file']} && {info['executable']}", executable='/bin/bash', shell=True)
    else:
        # Script
        subprocess.run(info['executable'], shell=True)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Automate and list commands/shell scripts")
    parser.add_argument('command', nargs='?', help="Command to run. Leave empty to list all.")
    parser.add_argument('-l', '--list', action='store_true', help="List all parsed commands")

    args = parser.parse_args()

    if args.list or not args.command:
        list_commands()
    else:
        run_command(args.command)
