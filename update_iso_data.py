#!/usr/bin/env python3

import json
import urllib.request
import os

url = "https://raw.githubusercontent.com/lukes/ISO-3166-Countries-with-Regional-Codes/master/all/all.json"

print(f"Downloading from {url}...")
try:
    with urllib.request.urlopen(url) as response:
        data = json.loads(response.read().decode())
except Exception as e:
    print(f"Error downloading: {e}")
    exit(1)

# Transform data to match user's schema
countries = []
for item in data:
    countries.append({
        "name": item["name"],
        "alpha-2": item["alpha-2"],
        "alpha-3": item["alpha-3"],
        "numeric": item["country-code"]
    })

# output dictionary
output = {"countries": countries}

# Define paths
base_dir = "/Users/bamdad/www/WSO/GenAI-R&D"
json_path = os.path.join(base_dir, "iso-3166.json")
yaml_path = os.path.join(base_dir, "iso-3166.yaml")
jsonc_path = os.path.join(base_dir, "iso-3166.jsonc")

# 1. Write JSON
print(f"Writing {json_path}...")
with open(json_path, 'w', encoding='utf-8') as f:
    json.dump(output, f, indent=2, ensure_ascii=False)

# 2. Write YAML
print(f"Writing {yaml_path}...")
with open(yaml_path, 'w', encoding='utf-8') as f:
    f.write("# ISO 3166-1 Country Codes\n")
    f.write("# Generated from Luke's ISO 3166 dataset\n")
    f.write("countries:\n")
    for country in countries:
        f.write(f"  - name: \"{country['name']}\"\n")
        f.write(f"    alpha-2: \"{country['alpha-2']}\"\n")
        f.write(f"    alpha-3: \"{country['alpha-3']}\"\n")
        f.write(f"    numeric: \"{country['numeric']}\"\n")

# 3. Write JSONC
print(f"Writing {jsonc_path}...")
with open(jsonc_path, 'w', encoding='utf-8') as f:
    f.write("{\n")
    f.write("  // ISO 3166-1 Country Codes\n")
    f.write("  \"countries\": [\n")
    
    current_letter = ""
    for i, country in enumerate(countries):
        first_letter = country['name'][0].upper()
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

print("Done.")
