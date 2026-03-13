import os

count = 0
for root, dirs, files in os.walk('.'):
    # Skip .git and worktrees to avoid clutter
    if '.git' in root or '.worktrees' in root:
        continue
    for file in files:
        if file.endswith('.md'):
            md_path = os.path.join(root, file)
            base_name = os.path.splitext(file)[0]
            img_tag = f"![{base_name}](images/{base_name}.png)"
            
            try:
                with open(md_path, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                # Check if this specific file already has its image tag
                if f"![{base_name}]" not in content and f"![{base_name.lower()}]" not in content:
                    with open(md_path, 'w', encoding='utf-8') as f:
                        f.write(img_tag + "\n\n" + content)
                    print(f"Added image tag to: {md_path}")
                    count += 1
            except Exception as e:
                print(f"Error reimport os

count = 0
for roo")
count =f"\for rootdd    # Skip .git and worktrees to avois.    if '.git' in root or '.worktrees' in rootma        python3 -c '
import os

count = 0
for root, dirs, files in os.walk("."):
    if ".git" in root or ".worktrees" in root:
        continue
    for file in files:
        if file.endswith(".md"):
            md_path = os.path.join(root, file)
            base_name = os.path.splitext(file)[0]
            img_tag = f"![{base_name}](images/{base_name}.png)"
            try:
                with open(md_path, "r", encoding="utf-8") as f:
                    content = f.read()
                if f"![{base_name}]" not in content and f"![{base_name.lower()}]" not in content:
                    with open(md_path, "w", encoding="utf-8") as f:
                        f.write(img_tag + "\n\n" + content)
                    print(f"Added image tag to {md_path}")
                    count += 1
            except Exception as e:
                pass
print(f"DONE. Found and injected {count} missing images.")
'
 EOF
python3 -c '
import os

count = 0
for root, dirs, files in os.walk("."):
    if ".git" in root or ".worktrees" in root:
        continue
    for file in files:
        if file.endswith(".md"):
            md_path = os.path.join(root, file)
            base_name = os.path.splitext(file)[0]
            img_tag = f"![{base_name}](images/{base_name}.png)"
            try:
                with open(md_path, "r", encoding="utf-8") as f:
                    content = f.read()
                if f"![{base_name}]" not in content and f"![{base_name.lower()}]" not in content:
                    with open(md_path, "w", encoding="utf-8") as f:
                        f.write(img_tag + "\n\n" + content)
                    print(f"Added image tag to {md_path}")
                    count += 1
            except Exception as e:
                pass
print(f"DONE. Found and injected {count} missing images.")
'
 EOF
