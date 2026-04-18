import os
import glob
import re
import struct
import zlib

PNG_SIGNATURE = b"\x89PNG\r\n\x1a\n"


def png_chunk(chunk_type: bytes, data: bytes) -> bytes:
    length = struct.pack(">I", len(data))
    chunk = chunk_type + data
    crc = struct.pack(">I", zlib.crc32(chunk) & 0xFFFFFFFF)
    return length + chunk + crc


def make_placeholder_png() -> bytes:
    ihdr = struct.pack(
        ">IIBBBBB",
        1,
        1,
        8,
        6,
        0,
        0,
        0,
    )
    image_data = b"\x00" + b"\xff\xff\xff\xff"
    idat = zlib.compress(image_data)
    return (
        PNG_SIGNATURE
        + png_chunk(b"IHDR", ihdr)
        + png_chunk(b"IDAT", idat)
        + png_chunk(b"IEND", b"")
    )


# 1. Rename all files with '_' to '-' across the entire repo
for root_dir, dirs, files in os.walk('.'):
    # skip .git
    if '.git' in root_dir:
        continue
    for f in files:
        if '_' in f:
            old_path = os.path.join(root_dir, f)
            new_file = f.replace('_', '-')
            new_path = os.path.join(root_dir, new_file)
            os.rename(old_path, new_path)
            print(f"Renamed {old_path} -> {new_path}")

# 2. Add images to root MD files, rename unnamed/make missing images, list them
md_files = glob.glob('*.md')
md_files.sort()

print("\n--- ROOT MD FILES ---")
for md in md_files:
    full_path = os.path.abspath(md)
    print(full_path)

    base_name = os.path.splitext(md)[0]
    img_dir = 'images'
    os.makedirs(img_dir, exist_ok=True)
    image_rel_path = f"{img_dir}/{base_name}.png"

    # 3. Add relevant image to each MD file
    try:
        with open(md, 'r') as file:
            content = file.read()

        img_markdown = f"![{base_name}]({image_rel_path})"
        if img_markdown not in content:
            with open(md, 'w') as file:
                file.write(img_markdown + "\n\n" + content)
    except Exception as e:
        print(f"Could not update {md}: {e}")

    # 4. Make missing images
    if not os.path.exists(image_rel_path):
        with open(image_rel_path, 'wb') as img:
            img.write(make_placeholder_png())

print("\nOperations completed.")
