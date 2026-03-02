# OSS Release Preparation: TODO List

**Version:** 1.0.0
**Generated:** 2026-02-08
**Status:** Active
**Audit Report:** [WWW-AUDIT-2026-02-08-2200.md](Audit/output/WWW-AUDIT-2026-02-08-2200.md)

> **Total Issues Found:** 256 references to internal paths  
> **Priority:** High (blocks OSS release)  
> **Human-in-the-Loop:** ✅ Enabled (y/n confirmation at each step)

---

## 🚨 Critical Path: OSS Release Readiness

### Phase 1: Pre-Cleanup Decisions (Human Review Required)

- [ ] **1.1 Exclusion Decisions**
  - [ ] Exclude `Meta/` directory from OSS? (contains iStripper references)
  - [ ] Exclude `Assets/NFSW/` directory from OSS? (98 NSFW image references with C:\\ paths)
  - [ ] Exclude `Love/` directory from OSS? (personal content)
  - [ ] Review `Ugly-Truth/` content for legal clearance (Iran regime commentary)
  - [ ] Decision on Screenshot*.png files (may contain sensitive data)

- [ ] **1.2 Git History Strategy**
  - [ ] Option A: Keep full history (transparent evolution)
  - [ ] Option B: Squash history for clean slate
  - [ ] Option C: Use BFG Repo-Cleaner to remove sensitive files from history
  - [ ] **Decision:** `__________________`

- [ ] **1.3 Approvals**
  - [ ] Technical review of audit report complete
  - [ ] Legal review complete (especially Ugly-Truth/)
  - [ ] Security review complete
  - [ ] Sign-off from: `__________________`

### Phase 2: Automated Cleanup (Run Scripts)

- [ ] **2.1 Run Audit Script** (DONE ✅)
  ```bash
  scripts/oss-audit-www-references.sh
  ```
  
- [ ] **2.2 Review Audit Report**
  - [ ] Read [WWW-AUDIT-2026-02-08-2200.md](Audit/output/WWW-AUDIT-2026-02-08-2200.md)
  - [ ] Note high-priority files
  - [ ] Identify false positives (public URLs - OK to keep)

- [ ] **2.3 Run Cleanup Script** (with human confirmation)
  ```bash
  scripts/oss-cleanup-www-references.sh
  ```
  - [ ] Clean One-Shot/GEMINI-INVITE.md (y/n)
  - [ ] Clean One-Shot/GPT-RED-TEAM-INVITE.md (y/n)
  - [ ] Clean One-Shot/Google/JURY-DELIBERATION-PACKET.md (y/n)
  - [ ] Clean Alliance-to-Empire/AI-PERSONA.md (y/n)
  - [ ] Clean Alliance-to-Empire/TODO.md (y/n)
  - [ ] Clean Alliance-to-Empire/SUMMARY.md (y/n)
  - [ ] Clean HELLO-WORLD.md (y/n)
  - [ ] Clean AI-Guardrails-and-Bias/DEEP-DiVE.md (y/n)
  - [ ] Clean AI-Guardrails-and-Bias/LEGAL-RISK-AUDIT-xAI-Grok.md (y/n)
  - [ ] Clean media/README.md (y/n)
  - [ ] Clean code/term/Terminal_Setup.ipynb (y/n)

### Phase 3: Manual Cleanup Tasks

- [ ] **3.1 Regenerate Media Outputs**
  ```bash
  python3 scripts/generate_media_assets.py media/config.yaml
  ```
  - [ ] media/output/MEDIA-PLAN.md
  - [ ] media/output/prompts/*.prompt.md

- [ ] **3.2 Update .gitignore for OSS Exclusions**
  - [ ] Add `Meta/` to .gitignore
  - [ ] Add `Assets/NFSW/` to .gitignore
  - [ ] Add `Love/` to .gitignore  
  - [ ] Add `Screenshot*.png` to .gitignore
  - [ ] Add `*.backup-*` to .gitignore (cleanup script backups)

- [ ] **3.3 Remove Excluded Directories from Git (if keeping history)**
  ```bash
  git rm -r --cached Meta/ Assets/NFSW/ Love/ Screenshot*.png
  ```

- [ ] **3.4 Clean Git History (if using BFG)**
  ```bash
  # Download BFG: https://rtyley.github.io/bfg-repo-cleaner/
  java -jar bfg.jar --delete-folders "{Meta,NFSW,Love}" .git
  java -jar bfg.jar --delete-files "Screenshot*.png" .git
  git reflog expire --expire=now --all
  git gc --prune=now --aggressive
  ```

### Phase 4: Verification

- [ ] **4.1 Re-run Audit Script**
  ```bash
  scripts/oss-audit-www-references.sh
  ```
  - [ ] Verify issue count reduced from 256 to <10
  - [ ] Review remaining references (should be external URLs only)

- [ ] **4.2 Manual Verification**
  ```bash
  # Search for any remaining internal paths
  git grep -E "/Users/|/home/|C:\\\\" | grep -v "Audit/output"
  
  # Verify excluded directories
  ls -la | grep -E "Meta|NFSW|Love"
  ```

- [ ] **4.3 Test Build**
  - [ ] Clone repo to fresh directory
  - [ ] Verify no broken links
  - [ ] Run tests (if any)
  - [ ] Check for missing images/assets

### Phase 5: Documentation Updates

- [ ] **5.1 Update README.md**
  - [ ] Add OSS release notice
  - [ ] Update installation instructions
  - [ ] Add contribution guidelines link
  - [ ] Add license badge

- [ ] **5.2 Update CHANGELOG.md**
  - [ ] Add entry for OSS preparation
  - [ ] Document removed directories (Meta, NFSW, Love)
  - [ ] Note path cleanup for portability

- [ ] **5.3 Verify Constitutional Docs**
  - [ ] CONSTITUTION.md has no internal references
  - [ ] GUARDRAILS.md has no internal references
  - [ ] SHARED-RESPONSIBILITY.md has no internal references
  - [ ] LICENSE is Apache 2.0

- [ ] **5.4 Add OSS-Specific Docs**
  - [ ] CONTRIBUTING.md exists
  - [ ] CODE_OF_CONDUCT.md exists
  - [ ] SECURITY.md exists
  - [ ] Issue templates in .github/ISSUE_TEMPLATE/
  - [ ] PR template in .github/PULL_REQUEST_TEMPLATE.md

### Phase 6: Final Preparation

- [ ] **6.1 Commit Cleanup Changes**
  ```bash
  git add -A
  git commit -m "OSS preparation: Remove internal paths and exclude sensitive directories"
  ```

- [ ] **6.2 Tag Release Candidate**
  ```bash
  git tag -a v1.3.0-rc1 -m "Release Candidate 1: OSS Preparation"
  git push origin rc --tags
  ```

- [ ] **6.3 Create Backup**
  - [ ] Backup private repo before visibility change
  - [ ] Store backup in secure location
  - [ ] Document backup location: `__________________`

- [ ] **6.4 Final Checklist**
  - [ ] All OSS-RELEASE-READINESS.md items complete
  - [ ] All human approvals obtained
  - [ ] No sensitive data in repo
  - [ ] All tests passing
  - [ ] Documentation complete

### Phase 7: Go Public

- [ ] **7.1 Change Repository Visibility**
  - [ ] GitHub Settings → Danger Zone → Change visibility
  - [ ] Select "Public"
  - [ ] Confirm understanding of implications
  - [ ] **Repository is now PUBLIC** ⚠️

- [ ] **7.2 Post-Release Verification**
  - [ ] Verify public URL accessible
  - [ ] Test anonymous clone
  - [ ] Check GitHub secret scanning alerts
  - [ ] Monitor for accidental commits

- [ ] **7.3 Announcement**
  - [ ] Create GitHub Release (v1.3.0)
  - [ ] Post to social media (optional)
  - [ ] Submit to Hacker News / Reddit (optional)
  - [ ] Update LinkedIn article

---

## 📊 Audit Summary (from WWW-AUDIT-2026-02-08-2200.md)

| Pattern | Count | Action |
|---------|-------|--------|
| `/workspaces` | 36 | ✅ Automated cleanup |
| `/Users/bamdad` | 40 | ✅ Automated cleanup |
| `/Users/` | 41 | ✅ Automated cleanup |
| `/home/` | 0 | ✅ None needed |
| `C:\\` | 98 | 🚨 **Exclude Assets/NFSW/** |
| `www/WSO` | 16 | ✅ Automated cleanup |
| `www/GenAI-RD` | 25 | ✅ Automated cleanup |

**Total:** 256 issues identified

---

## 🔧 Quick Commands Reference

### Audit Commands
```bash
# Full audit
scripts/oss-audit-www-references.sh

# Quick check for remaining issues
git grep -E "/Users/|/home/|www" | grep -v "Audit/output" | wc -l

# List affected files
git grep -l -E "/Users/|/home/|www" | grep -v "Audit/output"
```

### Cleanup Commands
```bash
# Interactive cleanup (with y/n prompts)
scripts/oss-cleanup-www-references.sh

# Review changes before committing
git diff

# Review backups created
ls -la **/*.backup-*
```

### Verification Commands
```bash
# Verify no secrets
git grep -i "password\|api_key\|secret\|token" --all

# Verify excluded directories
cat .gitignore | grep -E "Meta|NFSW|Love"

# Test fresh clone
cd /tmp && git clone /workspaces/TomWizMaster test-oss && cd test-oss
```

---

## ⚠️ Human Decision Points

### Decision 1: Directory Exclusions
**Question:** Which directories should be excluded from OSS release?

- `Meta/` - Contains iStripper references (personal software)
- `Assets/NFSW/` - Contains NSFW images with Windows path metadata
- `Love/` - Contains personal content (road trip plans)
- `Ugly-Truth/` - Contains political commentary (legal review needed)

**Recommended:** Exclude Meta, NFSW, Love. Review Ugly-Truth with legal counsel.

### Decision 2: Git History
**Question:** How should git history be handled?

- **Option A:** Keep full history (shows evolution, transparent)
- **Option B:** Squash to clean slate (hides mistakes, fresh start)
- **Option C:** BFG cleanup (removes sensitive files, keeps commit messages)

**Recommended:** Option A (keep history) unless legal mandates cleanup.

### Decision 3: Screenshot Files
**Question:** Should Screenshot*.png files be included in OSS?

**Risk:** May contain sensitive UI data, internal tools, or unreleased features.
**Recommended:** Exclude all Screenshot*.png files from OSS release.

---

## 📞 Escalation & Support

**For questions or blockers:**
- Technical: Review audit report and run scripts
- Legal: Consult counsel on Ugly-Truth/ content and history cleanup
- Security: Verify no credentials in git history

**Sign-offs Required:**
- [ ] Technical Lead: `__________________`
- [ ] Legal: `__________________`
- [ ] Security: `__________________`

---

**Last Updated:** 2026-02-08  
**Next Review:** After each phase completion  
**Status:** 🟡 In Progress

---

## 📚 Related Documents

- [OSS-RELEASE-READINESS.md](OSS-RELEASE-READINESS.md) - Full release framework
- [Audit/output/WWW-AUDIT-2026-02-08-2200.md](Audit/output/WWW-AUDIT-2026-02-08-2200.md) - Detailed findings
- [scripts/oss-audit-www-references.sh](scripts/oss-audit-www-references.sh) - Audit script
- [scripts/oss-cleanup-www-references.sh](scripts/oss-cleanup-www-references.sh) - Cleanup script

**Good luck! 🚀**
