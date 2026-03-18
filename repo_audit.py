import os
import re
import urllib.request
import urllib.error
import ssl
import concurrent.futures
from urllib.parse import urlparse

# Avoid hidden directories, node_modules, etc.
IGNORE_DIRS = {'.git', '.venv', 'node_modules', '__pycache__', '.github'}

def find_md_files(root_dir):
    md_files = []
    IGNORE_FILES = {'REPO-INTEGRITY-AUDIT.md'}
    for dirpath, dirnames, filenames in os.walk(root_dir):
        dirnames[:] = [d for d in dirnames if d not in IGNORE_DIRS]
        for f in filenames:
            if f.endswith('.md') and f not in IGNORE_FILES:
                md_files.append(os.path.join(dirpath, f))
    return md_files

def extract_links_and_issues(filepath):
    with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
        content = f.read()
    
    # Simple regex for http(s) urls
    url_pattern = re.compile(r'https?://[^\s)\]">]+')
    urls = url_pattern.findall(content)
    # Clean trailing punctuation
    urls = [re.sub(r'[.,;:*`\047]$', '', u) for u in urls]
    
    issues = []
    # Arbitrary standard checks
    if not content.strip():
        issues.append("File is empty")
    elif not content.lstrip().startswith('#'):
        issues.append("Missing top-level H1 header")
    
    if "TODO" in content or "TBD" in content:
        issues.append("Contains TODO or TBD mentions")
        
    return urls, issues

def check_url(url):
    ctx = ssl.create_default_context()
    ctx.check_hostname = False
    ctx.verify_mode = ssl.CERT_NONE
    req = urllib.request.Request(
        url, 
        headers={'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)'}
    )
    try:
        # Use HEAD request if possible
        req.get_method = lambda: 'HEAD'
        urllib.request.urlopen(req, timeout=10, context=ctx)
        return url, 200
    except urllib.error.HTTPError as e:
        # Fallback to GET on some strict servers
        if e.code in (403, 405):
            try:
                req.get_method = lambda: 'GET'
                urllib.request.urlopen(req, timeout=10, context=ctx)
                return url, 200
            except urllib.error.HTTPError as e2:
                return url, e2.code
            except Exception:
                return url, "Error"
        return url, e.code
    except Exception as e:
        return url, "Failed"

def main():
    root_dir = os.getcwd()
    md_files = find_md_files(root_dir)
    print(f"Found {len(md_files)} markdown files.")
    
    all_urls = set()
    file_issues = {}
    file_urls_map = {}
    
    for f in md_files:
        urls, issues = extract_links_and_issues(f)
        if issues:
            file_issues[f] = issues
        if urls:
            file_urls_map[f] = urls
            all_urls.update(urls)
            
    print(f"Extracted {len(all_urls)} unique URLs.")
    
    print("Checking URLs concurrently...")
    url_results = {}
    with concurrent.futures.ThreadPoolExecutor(max_workers=10) as executor:
        futures = {executor.submit(check_url, u): u for u in all_urls}
        for future in concurrent.futures.as_completed(futures):
            u, status = future.result()
            url_results[u] = status
            
    broken_links = {u: s for u, s in url_results.items() if s != 200}
    
    print(f"Found {len(broken_links)} broken links.")
    
    # Write report
    report_path = "REPO-INTEGRITY-AUDIT.md"
    with open(report_path, "w", encoding="utf-8") as f:
        f.write("# Repo-Wide Integrity & Link Audit\n\n")
        f.write("## Broken or Unreachable Links\n")
        if broken_links:
            for url, status in broken_links.items():
                f.write(f"- `{url}` (Status: {status})\n")
                # find files containing this
                linked_in = [p for p, urls in file_urls_map.items() if url in urls]
                for p in linked_in:
                    f.write(f"  - Found in: {os.path.relpath(p, root_dir)}\n")
        else:
            f.write("No broken links found repo-wide!\n")
            
        f.write("\n## Structural Issues & Missing Content\n")
        if file_issues:
            for p, issues in file_issues.items():
                rel_p = os.path.relpath(p, root_dir)
                f.write(f"### {rel_p}\n")
                for issue in issues:
                    f.write(f"- {issue}\n")
        else:
            f.write("No structural issues or placeholders found.\n")

    print(f"Audit complete. Report generated at {report_path}")

if __name__ == "__main__":
    main()
