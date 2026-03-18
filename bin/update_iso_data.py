#!/usr/bin/env python3
import argparse
import json
import urllib.request
from pathlib import Path

DEFAULT_URL = "https://raw.githubusercontent.com/lukes/ISO-3166-Countries-with-Regional-Codes/master/all/all.json"


def parse_args():
    parser = argparse.ArgumentParser(
        description="Download ISO-3166 country data and write JSON, YAML, and JSONC outputs."
    )
    parser.add_argument(
        "--url",
        default=DEFAULT_URL,
        help="Source URL for ISO data (default: official GitHub mirror)",
    )
    parser.add_argument(
        "--output-dir",
        type=Path,
        default=Path(__file__).resolve().parents[1],
        help="Directory where iso-3166.{json,yaml,jsonc} will be written (default: code)",
    )
    return parser.parse_args()


def download_iso_data(url):
    print(f"Downloading from {url}...")
    with urllib.request.urlopen(url) as response:
        return json.loads(response.read().decode())


def transform_countries(data):
    countries = []
    for item in data:
        countries.append(
            {
                "name": item["name"],
                "alpha-2": item["alpha-2"],
                "alpha-3": item["alpha-3"],
                "numeric": item["country-code"],
            }
        )
    return countries


def write_json(output, json_path):
    print(f"Writing {json_path}...")
    with json_path.open("w", encoding="utf-8") as f:
        json.dump(output, f, indent=2, ensure_ascii=False)


def write_yaml(countries, yaml_path):
    print(f"Writing {yaml_path}...")
    with yaml_path.open("w", encoding="utf-8") as f:
        f.write("# ISO 3166-1 Country Codes\n")
        f.write("# Generated from Luke's ISO 3166 dataset\n")
        f.write("countries:\n")
        for country in countries:
            f.write(f"  - name: \"{country['name']}\"\n")
            f.write(f"    alpha-2: \"{country['alpha-2']}\"\n")
            f.write(f"    alpha-3: \"{country['alpha-3']}\"\n")
            f.write(f"    numeric: \"{country['numeric']}\"\n")


def write_jsonc(countries, jsonc_path):
    print(f"Writing {jsonc_path}...")
    with jsonc_path.open("w", encoding="utf-8") as f:
        f.write("{\n")
        f.write("  // ISO 3166-1 Country Codes\n")
        f.write('  "countries": [\n')

        current_letter = ""
        for i, country in enumerate(countries):
            first_letter = country["name"][0].upper()
            if first_letter != current_letter:
                current_letter = first_letter
                f.write(f"\n    // --- {current_letter} ---\n")

            f.write("    {\n")
            f.write(f"      \"name\": \"{country['name']}\",\n")
            f.write(f"      \"alpha-2\": \"{country['alpha-2']}\",\n")
            f.write(f"      \"alpha-3\": \"{country['alpha-3']}\",\n")
            f.write(f"      \"numeric\": \"{country['numeric']}\"\n")

            if i < len(countries) - 1:
                f.write("    },\n")
            else:
                f.write("    }\n")

        f.write("  ]\n")
        f.write("}\n")


def main():
    args = parse_args()
    output_dir = args.output_dir.resolve()
    output_dir.mkdir(parents=True, exist_ok=True)

    try:
        data = download_iso_data(args.url)
    except Exception as e:
        print(f"Error downloading: {e}")
        raise SystemExit(1)

    countries = transform_countries(data)
    output = {"countries": countries}

    json_path = output_dir / "iso-3166.json"
    yaml_path = output_dir / "iso-3166.yaml"
    jsonc_path = output_dir / "iso-3166.jsonc"

    write_json(output, json_path)
    write_yaml(countries, yaml_path)
    write_jsonc(countries, jsonc_path)

    print("Done.")

if __name__ == "__main__":
    main()
