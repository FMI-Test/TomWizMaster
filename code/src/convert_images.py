import os
import random
import glob
from PIL import Image

# Weights: most webp, some png, some jpeg, some jpg
formats = ['webp'] * 50 + ['png'] * 20 + ['jpeg'] * 15 + ['jpg'] * 15

def convert_image(input_path, output_path):
    """Convert image using Pillow."""
    try:
        with Image.open(input_path) as img:
            # Convert to RGB if necessary for JPEG
            if output_path.lower().endswith(('.jpg', '.jpeg')):
                img = img.convert('RGB')
            img.save(output_path, quality=85)  # Good quality for webp/jpeg
        return True
    except Exception as e:
        print(f"Failed to convert {input_path}: {e}")
        return False

def remove_image_references():
    """Remove all image references from MD files."""
    md_files = glob.glob('**/*.md', recursive=True)
    for md_file in md_files:
        try:
            with open(md_file, 'r', encoding='utf-8') as f:
                content = f.read()
            # Remove lines that contain ![ or <img
            lines = content.split('\n')
            new_lines = []
            for line in lines:
                if not ('![' in line or '<img' in line):
                    new_lines.append(line)
            new_content = '\n'.join(new_lines)
            if new_content != content:
                with open(md_file, 'w', encoding='utf-8') as f:
                    f.write(new_content)
                print(f"Removed image references from {md_file}")
        except Exception as e:
            print(f"Error processing {md_file}: {e}")

def main():
    # Find all PNG files
    png_files = []
    for root, dirs, files in os.walk('.'):
        if '.git' in root or '.venv' in root or 'node_modules' in root:
            continue
        for file in files:
            if file.lower().endswith('.png'):
                png_files.append(os.path.join(root, file))

    print(f"Found {len(png_files)} PNG files to process.")

    for png_path in png_files:
        # Choose random format
        new_format = random.choice(formats)
        base = os.path.splitext(png_path)[0]
        new_path = f"{base}.{new_format}"

        if new_format == 'png':
            # Keep as PNG, no conversion needed
            print(f"Keeping {png_path} as PNG")
            continue

        if convert_image(png_path, new_path):
            print(f"Converted {png_path} to {new_path}")
            # Remove the original PNG
            os.remove(png_path)
        else:
            print(f"Skipped {png_path}")

    # Remove image references from MD files
    remove_image_references()

    print("Conversion complete.")

if __name__ == "__main__":
    main()
