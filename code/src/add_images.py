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

                if img_tag not in content and img_tag.lower() not in content:
                    with open(md_path, 'w', encoding='utf-8') as f:
                        f.write(img_tag + "\n\n" + content)
                    print(f"Added image tag to: {md_path}")
                    count += 1
            except Exception as e:
                print(f"Could not update {md_path}: {e}")

print(f"DONE. Found and injected {count} missing images.")

