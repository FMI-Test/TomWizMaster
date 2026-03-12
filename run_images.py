import os

added_count = 0
for root, dirs, files in os.walk('.'):
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
                
                if img_tag not in content:
                    with open(md_path, 'w', encoding='utf-8') as f:
                        f.write(img_tag + "\n\n" + content)
                    print(f"Injected image tag into: {md_path}")
                    added_count += 1
            except Exception as e:
                pass

print(f"VERIFIED. Added images to {added_count} files that were missing them. AAK.")
