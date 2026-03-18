# Changelog

All notable changes to this repository are documented in this file.

## [1.3.0-rc1] - 2026-02-08

### Added
- **OSS-RELEASE-READINESS.md:** Comprehensive OSS release framework with 5-phase checklist, security clearance templates, Apache 2.0 license guidance, and staging workflow
- **OSS-RELEASE-TODO.md:** Actionable 15-task checklist with 7 phases (Decisions → Cleanup → Manual → Verification → Documentation → Preparation → Public)
- **code/scripts/oss-audit-www-references.sh:** 100x audit script for internal path references (256 issues identified)
- **code/scripts/oss-cleanup-www-references.sh:** Semi-automated cleanup script with human-in-the-loop y/n confirmations
- **Audit/output/WWW-AUDIT-2026-02-08-2200.md:** Comprehensive audit report identifying /Users/, /home/, C:\, and www/WSO references
- **Audit/logs/2026-02-08/2202-oss-audit-aak.md:** Tier-2 reasoning log for OSS audit session
- **CONTRIBUTING.md:** Contribution guidelines for OSS collaborators
- **CODE_OF_CONDUCT.md:** Community standards and reporting guidance
- **PAYMENT-RAILS-AVAILABILITY.csv/.yaml:** Wert supported countries availability matrix

### Changed
- Prepared repository for OSS release with comprehensive audit and cleanup automation
- Identified sensitive directories for exclusion (Meta/, Assets/NFSW/, Love/, Ugly-Truth/)
- Human review required for directory exclusions and git history strategy
- Updated payment rails availability from Wert supported countries (249 total, 185 fiat onramp, 227 NFT checkout)
- Ran OSS cleanup to remove internal path references and updated .gitignore exclusions
- Re-audited internal references after cleanup (see latest audit output)

### Project Readiness Assessment
- **One-Shot (WSO):** Ready with cleanup (16 path references identified)
- **Alliance-to-Empire:** Ready with cleanup (path references in AI-PERSONA.md, TODO.md, SUMMARY.md)
- **AI-Guardrails-and-Bias:** Ready (git command paths to clean)
- **US-Gov/DOGE (GE):** Not ready - policy-sensitive content needs review

## [1.2.3] - 2026-02-08

### Added
- **QUICK-START.md rewrite:** Persona-based fast tracks (AI Agent 2min, Developer 3min, Architect 5min, Policy 5min, Contributor 10min) with navigation table and clear next steps
- **ONBOARDING.md:** Comprehensive 30-60 minute onboarding guide covering all personas (AI, Dev, Architect, Policy, Contributor) with checklist, navigation guide, and deep learning resources
- **DEEP-DIVE.md:** Architecture deep dive (45-90 min) covering system design patterns, governance parallels, audit framework, workflow patterns, scalability constraints, and evolution roadmap

### Changed
- QUICK-START.md version bumped to 1.2.2
- Improved onboarding UX with time estimates and role-specific paths

## [1.2.2] - 2026-02-08

### Changed
- **README Cons section expanded:** 10 unresolved issues (Cons) + 10 accepted tradeoffs (Zero-Cons) with rationale and mitigation strategies
- Improved transparency on repository limitations and intentional design choices

## [1.2.1] - 2026-02-08

### Added
- Human context pillar in AUDIT-ARCHITECTURE.md (L14)
- AI use boundary pillar in AUDIT-ARCHITECTURE.md (L15)
- Auto-documentation section in AUDIT-ARCHITECTURE.md (L27-30)
- Internal dependencies list in AUDIT-ARCHITECTURE.md (L32-39)
- Human context snapshot section in THINKING-VISIBILITY-PROTOCOL.md (L23-27)
- AI training boundary section in THINKING-VISIBILITY-PROTOCOL.md (L29-31)
- Auto-documentation guidance in THINKING-VISIBILITY-PROTOCOL.md (L33-36)
- Internal dependencies in THINKING-VISIBILITY-PROTOCOL.md (L76-82)
- README Cons section documenting tradeoffs (L213-217)
- Prince of Persia Chapter 2 narrative draft
- Workspace notes and todos tracking file
- RC 1.2.1 release report with AAK binding
- Tier-2 reasoning log for RC 1.2.1

### Changed
- AUDIT-ARCHITECTURE.md Last Updated: 2026-02-08
- THINKING-VISIBILITY-PROTOCOL.md expanded with context capture requirements

### Fixed
- Clarified audit artifact exclusion to prevent recursive scanning

## [1.2.0] - 2026-01-29

### Added
- Audit script exclusion for generated artifacts (PR #17)
- Excluded Audit/logs and Audit/output from markdown scanning

### Fixed
- Prevented self-referential audit noise from generated reports
