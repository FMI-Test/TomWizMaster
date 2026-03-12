import os
import glob
import shutil

# Step 1: define fallback image
fallback = None
unnameds = glob.glob('images/unnamed*.jpg')
if unnameds:
    fallback = unnameds[0]
else:
    pngs = glob.glob('images/*.png')
    if pngs:
        fallback = pngs[0]

if not fallback:
    print("No fallback image found!")
    exit(1)

md_files = []
for root, dirs, files in os.walk('.'):
    if '.git' in root or 'node_modules' in root or '.worktrees' in root:
        continue
    for f in files:
        if f.endswith('.md'):
            md_files.append(os.path.join(root, f))

for filepath in md_files:
    # normalize path
    nc_filepath = os.path.normpath(filepath)
    filename = os.path.basename(nc_filepath)
    base = filename[:-3] # remove .md
    if not base:
        continue

    # 1. Make missing image in root images/ directory
    img_target = f"images/{base}.png"
    if not os.path.exists(img_target):
        shutil.copy(fallback, img_target)
        try:
            print(f"[{nc_filepath}] -> Created image: {img_target}")
        except:
            pass

    # 2. Add header tag to MD
    parts = nc_filepath.split(os.sep)
    # usually parts are like ['Love', 'LA-Seattle-Rooad-Trip.md']
    depth = len(parts) - 1
    rel_path = "../" * depth + f"images/{base}.png"
    
    with open(nc_filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # check if there's already a markdown image matching the base exactly at the top or anywhere
    if f"![{base}](" not in content:
        new_content = f"![{base}]({rel_path})\n\n" + content
        with open(nc_filepath, 'w', encoding='utf-8') as f:
            f.write(new_content)
        try:
            print(f"[{nc_filepath}] -> Injected header: ![{base}]({rel_path})")
        except:
            pass

print("Done.")
