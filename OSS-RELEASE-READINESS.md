# OSS Release Readiness Framework

**Version:** 1.0.0
**Status:** Live
**Last Updated:** 2026-02-08
**Purpose:** Systematic framework for preparing private repositories for open-source release

> **Critical:** This framework ensures IP clearance, security review, and trace cleanup before transitioning private repositories to public OSS with Apache 2.0 license.

---

## 🎯 Overview

This document provides a **comprehensive checklist and workflow** for releasing projects as open-source software (OSS). It covers:

1. **Pre-Requisites** — IP clearance, security review, documentation
2. **Audit** — 10x audit for sensitive data, internal references, security stack
3. **Review** — Staged review (stg → uat → rc) before public release
4. **Release** — Visibility change, license application, community preparation
5. **Post-Release** — Trace cleanup, monitoring, community engagement

---

## ✅ OSS Release Checklist

### Phase 1: Pre-Requisites

- [ ] **Legal Clearance**
  - [ ] IP ownership confirmed (no third-party code without attribution)
  - [ ] Trademark clearance for project names
  - [ ] Patent review completed (if applicable)
  - [ ] Export control compliance verified (ITAR, EAR)
  - [ ] Apache 2.0 license compatibility checked for all dependencies

- [ ] **Security Stack Clearance**
  - [ ] No hardcoded credentials (API keys, passwords, tokens)
  - [ ] No internal network references (VPNs, internal IPs, domains)
  - [ ] No PII or sensitive user data
  - [ ] No proprietary algorithms or trade secrets
  - [ ] Dependency vulnerability scan completed (Dependabot, Snyk)

- [ ] **Documentation Readiness**
  - [ ] README.md with clear purpose, installation, usage
  - [ ] LICENSE file (Apache 2.0)
  - [ ] CONTRIBUTING.md for community guidelines
  - [ ] CODE_OF_CONDUCT.md
  - [ ] SECURITY.md for vulnerability reporting
  - [ ] CHANGELOG.md for version history

- [ ] **Code Quality**
  - [ ] All tests passing
  - [ ] Code coverage >70% (recommended)
  - [ ] Linting and formatting applied
  - [ ] No TODOs or FIXMEs referencing internal systems
  - [ ] Architecture documentation complete

### Phase 2: Audit (10x Review)

- [ ] **Automated Scans**
  - [ ] `git log` reviewed for sensitive commit messages
  - [ ] `git grep` for API keys, passwords, tokens
  - [ ] `git grep` for internal domains/IPs (e.g., `.internal`, `192.168`, `10.0`)
  - [ ] `git grep` for employee names, emails, internal org references
  - [ ] File path audit for sensitive directories (e.g., `/Users/`, `/home/`, company names)
  - [ ] Binary files audit (screenshots, PDFs, images with EXIF data)
  - [ ] Dependency audit (npm audit, pip-audit, bundle-audit)

- [ ] **Manual Review**
  - [ ] All markdown files reviewed for internal references
  - [ ] All code files reviewed for proprietary logic
  - [ ] Configuration files sanitized (no internal endpoints)
  - [ ] Test data sanitized (no real user data)
  - [ ] Comments reviewed for internal context leaks

- [ ] **History Audit**
  - [ ] Git history reviewed for sensitive commits
  - [ ] Decision: Keep history or squash/rewrite (BFG Repo-Cleaner if needed)
  - [ ] Large files removed (Git LFS or .gitignore)
  - [ ] Orphaned branches deleted

### Phase 3: Staging Review (private → private → private)

- [ ] **Stage 1: Development (stg branch)**
  - [ ] All audit issues resolved
  - [ ] Documentation updated
  - [ ] Tests passing
  - [ ] Peer review completed

- [ ] **Stage 2: UAT (uat branch, if applicable)**
  - [ ] External beta testers (trusted partners) review
  - [ ] Security review by external auditor (optional but recommended)
  - [ ] Legal final sign-off

- [ ] **Stage 3: Release Candidate (rc branch)**
  - [ ] Final smoke test
  - [ ] CHANGELOG.md finalized
  - [ ] Version tagged (v1.0.0)
  - [ ] Release notes prepared

### Phase 4: Release (private → public)

- [ ] **Repository Setup**
  - [ ] GitHub repository settings reviewed:
    - [ ] Description clear and public-friendly
    - [ ] Topics/tags added for discoverability
    - [ ] Default branch set (usually `main`)
    - [ ] Branch protection rules configured
  - [ ] LICENSE file at root (Apache 2.0)
  - [ ] SECURITY.md with vulnerability reporting process
  - [ ] CODE_OF_CONDUCT.md (Contributor Covenant recommended)
  - [ ] Issue templates configured (.github/ISSUE_TEMPLATE/)
  - [ ] PR templates configured (.github/PULL_REQUEST_TEMPLATE.md)

- [ ] **Visibility Change**
  - [ ] **CRITICAL: Final backup of private repo before visibility change**
  - [ ] Repository visibility changed to Public
  - [ ] Confirm public URL accessible
  - [ ] Confirm all files visible as expected

- [ ] **Community Preparation**
  - [ ] GitHub Discussions enabled (optional)
  - [ ] Initial issues created (e.g., "good first issue" labels)
  - [ ] README badges added (build status, license, version)
  - [ ] Social media announcement prepared (optional)
  - [ ] Hacker News/Reddit post prepared (optional)

### Phase 5: Post-Release Cleanup

- [ ] **Trace Removal from Original Private Repo**
  - [ ] Internal references cleaned from commit messages (if needed)
  - [ ] Internal branches deleted
  - [ ] Old forks archived
  - [ ] CI/CD secrets rotated
  - [ ] Internal DNS entries removed (if project had internal staging URLs)

- [ ] **Monitoring & Engagement**
  - [ ] GitHub watch notifications enabled
  - [ ] First issues/PRs responded to within 48 hours
  - [ ] Security vulnerability reports monitored
  - [ ] Community Code of Conduct enforced

---

## 🔍 Project-Specific Audit Checklists

### US-Gov/DOGE (Government Efficiency)

**Status:** Framework-first  
**OSS Readiness:** **NOT READY** — Contains policy-sensitive content

**Blockers:**
- [ ] Review for government agency attribution (may require neutral language)
- [ ] Confirm no FOUO (For Official Use Only) content
- [ ] Verify no specific budget numbers or internal agency data
- [ ] Review metaphor/branding for neutrality (DOGE may be politically charged)

**Recommendation:** Create sanitized version or publish as "Government Efficiency Framework (GEF)" with generic language.

---

### One-Shot Methodology

**Status:** R&D Core  
**OSS Readiness:** **READY** (with minor cleanup)

**Cleanup Required:**
- [x] Remove legacy WSO file path references (e.g., `/workspaces/WSO/`)
- [ ] Update GEMINI-INVITE.md, GPT-RED-TEAM-INVITE.md file paths to relative paths
- [ ] Remove personal computer screenshots (if any contain sensitive data)
- [ ] Sanitize file names with special characters (⚔️ emojis may cause issues on some systems)

**Recommendation:** Quick cleanup and release as "One-Shot Methodology for AI-Assisted Development"

---

### Alliance-to-Empire

**Status:** Ideation Platform  
**OSS Readiness:** **READY** (after review)

**Cleanup Required:**
- [ ] Review Tom-and-Jerry-2026.md for internal references
- [ ] Confirm no client/customer data in examples
- [ ] Update any internal architecture diagrams

**Recommendation:** Release as "Alliance-to-Empire: AI-Powered Ideation Platform"

---

### AI-Guardrails-and-Bias

**Status:** Ethics and Bias Analysis  
**OSS Readiness:** **READY**

**Cleanup Required:**
- [ ] Review case studies for attribution and citations
- [ ] Confirm no proprietary research data
- [ ] Add disclaimers for opinionated content (e.g., GPT5-FOOTNOTE-FAILURE-CASE-STUDY.md)

**Recommendation:** Release as "AI Guardrails and Bias: Case Studies and Analysis"

---

### Prince-of-Persia (Narrative Research)

**Status:** Draft  
**OSS Readiness:** **NOT READY** — Incomplete content

**Blockers:**
- [ ] Only CHAPTER-02 exists; missing CHAPTER-01 and context
- [ ] Purpose unclear for external audience

**Recommendation:** Hold until narrative research is complete or repurpose as examples.

---

## 🛡️ Security Stack Clearance (Template)

### Repository: `__________________`

**Audit Date:** `__________`  
**Auditor:** `__________`  
**Sign-Off:** `__________`

#### Clearance Checklist

- [ ] **Credentials Scan:**
  ```bash
  git grep -i "password\|api_key\|secret\|token\|bearer" --all
  ```
  Result: `__________________`

- [ ] **Internal Network References:**
  ```bash
  git grep -E "\\.internal|192\\.168|10\\.|corp\\." --all
  ```
  Result: `__________________`

- [ ] **Personal Data:**
  ```bash
  git grep -E "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}" --all
  ```
  Result: `__________________`

- [ ] **Hardcoded Paths:**
  ```bash
  git grep -E "/Users/|/home/|C:\\\\" --all
  ```
  Result: `__________________`

- [ ] **Dependency Vulnerabilities:**
  ```bash
  # Python
  pip-audit
  # Node.js
  npm audit
  # Ruby
  bundle audit
  ```
  Result: `__________________`

#### Sign-Off

- [ ] Security clearance approved by: `__________________`
- [ ] Legal clearance approved by: `__________________`
- [ ] Date: `__________________`

---

## 📋 Staging Workflow (Private → Public)

### Step 1: Private Staging (stg branch)

```bash
# Create OSS-ready branch
git checkout -b oss-prep
git branch stg-oss

# Apply all cleanup changes
# (Remove sensitive data, update docs, add LICENSE)

# Push to private repo for review
git push origin stg-oss
```

### Step 2: UAT Review (rc branch)

```bash
# Merge to RC for final review
git checkout rc
git merge stg-oss

# Tag RC version
git tag -a v1.0.0-rc1 -m "Release Candidate 1 for OSS"
git push origin rc --tags
```

### Step 3: Public Release

```bash
# After final approval, change repo visibility to Public via GitHub UI

# Verify public access
curl -I https://github.com/FMI-Test/TomWizMaster

# Announce release
# (Create GitHub Release, post to social media, etc.)
```

---

## 📜 Apache 2.0 License Setup

### Add LICENSE File

Create `LICENSE` at repository root:

```
Apache License
Version 2.0, January 2004
http://www.apache.org/licenses/

[Full Apache 2.0 license text]
```

**Note:** Current repo already has `LICENSE` file. Verify it contains Apache 2.0 text.

### Add License Headers to Source Files

For code files, add header:

```python
# Copyright 2026 [Your Organization]
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
```

### Update README Badge

Add license badge to README.md:

```markdown
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
```

---

## 🧹 Trace Cleanup Procedure

### Before Visibility Change

**CRITICAL:** Complete these steps before changing repository to public.

1. **Audit Git History:**
   ```bash
   # Review all commit messages
   git log --all --oneline | grep -i "internal\|private\|secret"
   
   # Review all file paths in history
   git log --all --name-only --pretty=format: | sort -u | grep -E "/Users/|/home/|C:\\\\"
   ```

2. **Remove Sensitive Files from History:**
   ```bash
   # Use BFG Repo-Cleaner for sensitive file removal
   java -jar bfg.jar --delete-files "{*.key,*.pem,secrets.*}" .git
   
   # Or use git filter-repo (recommended)
   git filter-repo --path-glob '*.key' --invert-paths
   ```

3. **Rewrite History (if needed):**
   ```bash
   # Squash commits to remove sensitive messages
   git rebase -i --root
   
   # Force push to rewrite history (DESTRUCTIVE!)
   git push origin --force --all
   git push origin --force --tags
   ```

4. **Remove Binary Files:**
   ```bash
   # Find large files
   git rev-list --objects --all | \
     git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | \
     awk '/^blob/ {print substr($0,6)}' | \
     sort -n -k 2 | tail -20
   
   # Remove screenshots with potential sensitive data
   git rm Screenshot*.png
   git commit -m "Remove screenshots before OSS release"
   ```

### After Visibility Change

1. **Verify Public Access:**
   ```bash
   # Test anonymous clone
   git clone https://github.com/FMI-Test/TomWizMaster test-public-access
   cd test-public-access
   
   # Verify no sensitive data
   grep -r "password\|secret\|api_key" .
   ```

2. **Rotate Secrets:**
   - Rotate all API keys referenced in old commits
   - Update CI/CD secrets
   - Revoke old access tokens

3. **Monitor for Leaks:**
   - Set up GitHub secret scanning
   - Monitor for accidental commits of `.env` files
   - Review PRs for security issues

---

## 🚀 Release Announcement Template

### GitHub Release Notes

```markdown
# [Project Name] v1.0.0 - Initial Open Source Release

We're excited to announce the first public release of [Project Name]!

## 🎯 What is [Project Name]?

[Brief description of the project and its purpose]

## ✨ Features

- Feature 1
- Feature 2
- Feature 3

## 📚 Documentation

- [README](link)
- [Getting Started](link)
- [Contributing Guidelines](link)

## 🤝 Contributing

We welcome contributions! Please see our [CONTRIBUTING.md](link) for details.

## 📜 License

This project is licensed under the Apache 2.0 License - see the [LICENSE](link) file for details.

## 🙏 Acknowledgments

[Thank contributors, inspiration, etc.]
```

---

## 📊 OSS Release Status Dashboard

| Project | IP Clear | Security Clear | Docs Ready | License | Public | Status |
|---------|----------|----------------|------------|---------|--------|--------|
| **TomWizMaster (Core)** | ✅ | ⏳ | ✅ | ✅ | ❌ | Audit Phase |
| **One-Shot** | ✅ | ⏳ | ✅ | ✅ | ❌ | Cleanup Phase |
| **Alliance-to-Empire** | ✅ | ⏳ | ✅ | ✅ | ❌ | Review Phase |
| **AI-Guardrails-and-Bias** | ✅ | ⏳ | ✅ | ✅ | ❌ | Ready |
| **US-Gov/DOGE** | ⚠️ | ⚠️ | ✅ | ✅ | ❌ | Blocked (Policy Sensitive) |
| **Prince-of-Persia** | ✅ | ✅ | ❌ | ✅ | ❌ | Not Ready (Incomplete) |

**Legend:**  
✅ Complete | ⏳ In Progress | ⚠️ Needs Review | ❌ Not Started

---

## 🔧 Automation Scripts

### Scan for Hardcoded Secrets

```bash
#!/bin/bash
# scan-secrets.sh

echo "Scanning for hardcoded secrets..."

patterns=(
  "password"
  "api_key"
  "api[-_]?key"
  "secret"
  "token"
  "bearer"
  "auth"
  "credentials"
)

for pattern in "${patterns[@]}"; do
  echo "Checking for: $pattern"
  git grep -i "$pattern" --all || echo "  ✅ None found"
done

echo "Scan complete."
```

### Clean Internal References

```bash
#!/bin/bash
# clean-internal-refs.sh

echo "Cleaning internal file path references..."

# Find and list files with /Users/ or /home/ paths
git grep -l -E "/Users/|/home/|C:\\\\" | while read file; do
  echo "Found internal path in: $file"
  # Manual review required - don't auto-replace
done

echo "Review complete. Manual cleanup required."
```

---

## ✅ Final Pre-Release Checklist

- [ ] All automated scans completed
- [ ] All manual reviews completed
- [ ] All blockers resolved
- [ ] Legal sign-off obtained
- [ ] Security sign-off obtained
- [ ] LICENSE file present
- [ ] README.md complete
- [ ] CONTRIBUTING.md present
- [ ] CODE_OF_CONDUCT.md present
- [ ] SECURITY.md present
- [ ] All tests passing
- [ ] Version tagged
- [ ] Release notes prepared
- [ ] Backup of private repo created
- [ ] **Ready to change visibility to Public**

---

## 📞 Contact & Escalation

**For questions or escalations:**
- Technical: [Maintainer Contact]
- Legal: [Legal Contact]
- Security: [Security Contact]

**Approval Required From:**
- [ ] Technical Lead
- [ ] Legal Counsel
- [ ] Security Team
- [ ] Executive Sponsor (if applicable)

---

**Last Updated:** 2026-02-08  
**Next Review:** Before each OSS release
