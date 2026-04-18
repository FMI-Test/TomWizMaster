import os
import struct
import zlib

PNG_SIGNATURE = b"\x89PNG\r\n\x1a\n"


def png_chunk(chunk_type: bytes, data: bytes) -> bytes:
    length = struct.pack(">I", len(data))
    chunk = chunk_type + data
    crc = struct.pack(">I", zlib.crc32(chunk) & 0xFFFFFFFF)
    return length + chunk + crc


def make_placeholder_png(prompt: str) -> bytes:
    """Create a valid 1x1 PNG file with metadata describing the missing image."""
    ihdr = struct.pack(
        ">IIBBBBB",
        1,  # width
        1,  # height
        8,  # bit depth
        6,  # color type RGBA
        0,  # compression method
        0,  # filter method
        0,  # interlace method
    )

    image_data = b"\x00" + b"\xff\xff\xff\xff"  # filter byte + white pixel RGBA
    idat = zlib.compress(image_data)

    text_data = f"Description\x00{prompt}".encode("utf-8", errors="replace")

    return (
        PNG_SIGNATURE
        + png_chunk(b"IHDR", ihdr)
        + png_chunk(b"tEXt", text_data)
        + png_chunk(b"IDAT", idat)
        + png_chunk(b"IEND", b"")
    )


def prompt_for_path(path: str) -> str:
    base_name = os.path.splitext(os.path.basename(path))[0]
    parent = os.path.basename(os.path.dirname(path))
    grandparent = os.path.basename(os.path.dirname(os.path.dirname(path)))
    return (
        f"Generate a clean, modern PNG illustration for '{base_name}' in the '{grandparent}/{parent}' section. "
        "Make it visually polished and consistent with the repository's documentation style."
    )


def find_empty_pngs(root_dir: str) -> list[str]:
    empty_files = []
    for root, dirs, files in os.walk(root_dir):
        if ".git" in root or ".venv" in root or ".worktrees" in root:
            continue
        for file in files:
            if file.lower().endswith(".png"):
                path = os.path.join(root, file)
                if os.path.getsize(path) == 0:
                    empty_files.append(path)
    return sorted(empty_files)


def write_prompt_file(replacements: dict[str, str], output_path: str) -> None:
    lines = ["# Missing Image Prompts", "", "This file lists the prompts used to generate placeholder PNGs for zero-byte image files.", "", "Each entry was auto-generated from the missing image path.", ""]
    for path, prompt in replacements.items():
        rel = os.path.relpath(path, os.getcwd())
        lines.append(f"## {rel}")
        lines.append("")
        lines.append(prompt)
        lines.append("")
    with open(output_path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))


def main() -> int:
    root_dir = os.getcwd()
    empty_pngs = find_empty_pngs(root_dir)
    if not empty_pngs:
        print("No zero-byte PNG files found.")
        return 0

    replacements: dict[str, str] = {}
    for path in empty_pngs:
        prompt = prompt_for_path(path)
        png_bytes = make_placeholder_png(prompt)
        with open(path, "wb") as f:
            f.write(png_bytes)
        replacements[path] = prompt
        print(f"Replaced empty PNG: {path}")

    prompt_file = os.path.join(root_dir, "MISSING_IMAGE_PROMPTS.md")
    write_prompt_file(replacements, prompt_file)
    print(f"Wrote prompts to: {prompt_file}")
    print(f"Fixed {len(empty_pngs)} empty PNG file(s).")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
