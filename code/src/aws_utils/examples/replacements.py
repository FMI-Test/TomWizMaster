"""
Comparison: Ansible 'lineinfile' / 'replace' vs CodeBuild (Python) implementation
"""

# ==========================================
# 1. Ansible Approach (The Old Way)
# ==========================================
# Typically used in a playbook.yaml
ansible_yaml = """
- name: Update API Endpoint in Config
  hosts: localhost
  tasks:
    - name: Replace placeholder with actual URL
      ansible.builtin.replace:
        path: /etc/app/config.json
        regexp: 'API_ENDPOINT_PLACEHOLDER'
        replace: 'https://api.internal.genai-rd.com/v1'

    - name: Ensure Debug Mode is Off
      ansible.builtin.lineinfile:
        path: /etc/app/config.ini
        regexp: '^DEBUG ='
        line: 'DEBUG = False'
"""

# ==========================================
# 2. CodeBuild / Python Approach (The New Way)
# ==========================================
# More flexible, testable, and doesn't require Ansible dependencies.

import os
import re
import fileinput

class ConfigReplacer:
    def __init__(self, file_path):
        self.file_path = file_path

    def replace_token(self, pattern, replacement):
        """
        Equivalent to ansible.builtin.replace
        """
        if not os.path.exists(self.file_path):
            print(f"File {self.file_path} not found.")
            return

        print(f"Replacing '{pattern}' with '{replacement}' in {self.file_path}")

        # Read-Modify-Write
        with open(self.file_path, 'r') as f:
            content = f.read()

        new_content = re.sub(pattern, replacement, content)

        with open(self.file_path, 'w') as f:
            f.write(new_content)

    def ensure_line(self, regex_pattern, line_content):
        """
        Equivalent to ansible.builtin.lineinfile
        """
        found = False
        updated_lines = []

        with open(self.file_path, 'r') as f:
            lines = f.readlines()

        for line in lines:
            if re.search(regex_pattern, line):
                updated_lines.append(line_content + '\n')
                found = True
            else:
                updated_lines.append(line)

        if not found:
            updated_lines.append(line_content + '\n')

        with open(self.file_path, 'w') as f:
            f.writelines(updated_lines)

# Usage Example
if __name__ == "__main__":
    # Create dummy config for demo
    with open("demo_config.ini", "w") as f:
        f.write("API_URL=API_ENDPOINT_PLACEHOLDER\nDEBUG = True\n")

    replacer = ConfigReplacer("demo_config.ini")

    # Ansible: replace API_ENDPOINT_PLACEHOLDER
    replacer.replace_token(r'API_ENDPOINT_PLACEHOLDER', 'https://api.prod.com')

    # Ansible: lineinfile DEBUG = False
    replacer.ensure_line(r'^DEBUG\s*=', 'DEBUG = False')

    print("--- Resulting Config ---")
    with open("demo_config.ini", "r") as f:
        print(f.read())

    # Cleanup
    os.remove("demo_config.ini")
