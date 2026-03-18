# Comprehensive Onboarding Guide

**Version:** 1.2.2
**Status:** Live
**Last Updated:** 2026-02-08

> **For rapid onboarding:** See [QUICK-START.md](QUICK-START.md) (3-10 min by role).  
> **For architecture deep dive:** See [DEEP-DIVE.md](DEEP-DIVE.md) (technical systems analysis).

---

## 🎯 Purpose

This guide provides **complete onboarding** for all personas: AI agents, developers, architects, policy makers, and contributors. By the end, you'll understand:

1. **What this repository is** (meta-framework for human-AI collaboration)
2. **Why it exists** (governance patterns for scalable AI workflows)
3. **How to use it** (constitutional layer + project-specific applications)
4. **Where to contribute** (open issues, gaps, and opportunities)

**Estimated Time:** 30-60 minutes (comprehensive); sections are modular—read what matters to you.

---

## 📚 Part 1: Repository Overview (10 min)

### What This Is

**GenAI Research & Development (TomWizMaster)** is a meta-framework for AI-assisted development that treats human-AI collaboration like systems architecture.

**Core Concept:** Just as AWS uses Organizations, SCPs, and Shared Responsibility to govern cloud infrastructure, this repo uses:
- **Constitutional Layer** (CONSTITUTION.md, GUARDRAILS.md, SHARED-RESPONSIBILITY.md)
- **Project Isolation** (Alliance-to-Empire, One-Shot, AI-Guardrails-and-Bias)
- **Audit Trail** (DESIGN.md, COMPLIANCE.md, Audit/)

### Why This Exists

**Problem:** AI collaboration is chaotic without governance. Teams repeat themselves, lose context, violate boundaries, and struggle to scale.

**Solution:** A constitutional framework that:
- Prevents orphan state (work without context)
- Enforces boundaries (GUARDRAILS.md)
- Clarifies accountability (SHARED-RESPONSIBILITY.md)
- Provides audit trail (DESIGN.md, CHANGELOG.md, Audit/)

**Guiding Principle:** Faster, Better, Cheaper—optimize all three without sacrificing any dimension.

### Repository Structure

```
TomWizMaster/
│
├── 📜 Constitutional Layer (Root)
│   ├── MANIFESTO.md           ← Why we exist
│   ├── CONSTITUTION.md        ← Immutable principles
│   ├── GUARDRAILS.md          ← Boundaries and red lines
│   ├── SHARED-RESPONSIBILITY.md ← Human vs. AI accountability
│   ├── COMPLIANCE.md          ← Compliance-as-code
│   ├── AUDIT-ARCHITECTURE.md  ← Audit integrity framework
│   ├── THINKING-VISIBILITY-PROTOCOL.md ← Tier-2 logs
│   ├── SECURITY-PROTOCOL.md   ← Gatekeeper and escalation
│   ├── FRICTION-PROTOCOL.md   ← Human ↔ AI collaboration
│   └── ...
│
├── 🏗️ Projects (Organizational Units)
│   ├── Alliance-to-Empire/    ← AI-powered ideation platform
│   ├── One-Shot/              ← R&D core and methodology
│   ├── AI-Guardrails-and-Bias/ ← Ethics and bias analysis
│   ├── Prince-of-Persia/      ← Narrative and metaphor research
│   ├── Ugly-Truth/            ← Critical analysis and commentary
│   └── US-Gov/                ← Government efficiency frameworks
│
├── 🔧 Workflows & Templates
│   ├── IaT/                   ← Infrastructure-as-Text workflow
│   ├── Audit/                 ← Audit logs and reports
│   ├── showtell/              ← Slide deck and summary generation
│   └── media/                 ← Media asset specs
│
└── 📦 Assets
    ├── images/
    ├── scripts/
    └── iso-3166.json          ← Reference data
```

### Key Documents (Must Read)

| **Category** | **Document** | **Purpose** | **Priority** |
|--------------|--------------|-------------|--------------|
| Vision | [MANIFESTO.md](MANIFESTO.md) | Why this exists | **High** |
| Principles | [CONSTITUTION.md](CONSTITUTION.md) | Core operating rules | **Critical** |
| Boundaries | [GUARDRAILS.md](GUARDRAILS.md) | Red lines | **Critical** |
| Accountability | [SHARED-RESPONSIBILITY.md](SHARED-RESPONSIBILITY.md) | Who owns what | **High** |
| Communication | [TONE-AND-INTENT.md](TONE-AND-INTENT.md) | How to interpret messages | **Medium** |
| Compliance | [COMPLIANCE.md](COMPLIANCE.md) | Governance approach | **Medium** |
| Architecture | [ARCHITECTURE-HIERARCHY.md](ARCHITECTURE-HIERARCHY.md) | System layers | **High** |
| Audit | [AUDIT-ARCHITECTURE.md](AUDIT-ARCHITECTURE.md) | Integrity framework | **Medium** |

---

## 🧠 Part 2: Core Philosophy (10 min)

### The AWS Parallel

| **AWS Concept** | **This Framework** | **Purpose** |
|-----------------|-------------------|-------------|
| Organizations | GenAI-R&D repo | Central governance |
| SCPs | GUARDRAILS.md | Boundary policies |
| Shared Responsibility Model | SHARED-RESPONSIBILITY.md | Accountability |
| Regions/AZs | Project folders | Isolation & context |
| CloudTrail | DESIGN.md, CHANGELOG.md | Audit trail |

### The Constitutional Parallel

| **Government** | **This Framework** | **Purpose** |
|----------------|-------------------|-------------|
| Declaration of Independence | MANIFESTO.md | Why we exist |
| Constitution | CONSTITUTION.md | Immutable principles |
| Bill of Rights | GUARDRAILS.md | Protected boundaries |
| Separation of Powers | SHARED-RESPONSIBILITY.md | Checks & balances |
| Judicial Review | Audit/ | Compliance verification |

### Faster, Better, Cheaper

The guiding principle across all projects:

| **Dimension** | **Meaning** | **Guardrail** |
|---------------|-------------|---------------|
| **Faster** | Reduce idea → validated learning time | Don't sacrifice understanding |
| **Better** | Higher quality per unit effort | Don't gold-plate |
| **Cheaper** | Lower cost (time, money, cognitive) | Don't sacrifice core value |

**Balance Check:** If optimizing one significantly hurts another → STOP and reconsider.

---

## 👥 Part 3: Persona-Specific Onboarding (20 min)

### For AI Agents

**Your Role:** Execute tasks within GUARDRAILS.md; defer high-stake decisions to humans per SHARED-RESPONSIBILITY.md.

**Must Read:**
1. [CONSTITUTION.md](CONSTITUTION.md) — Operating principles
2. [SHARED-RESPONSIBILITY.md](SHARED-RESPONSIBILITY.md) — Your accountability boundaries
3. [TONE-AND-INTENT.md](TONE-AND-INTENT.md) — Interpret sarcasm, urgency, mixed language
4. [GUARDRAILS.md](GUARDRAILS.md) — Red lines you cannot cross
5. [SECURITY-PROTOCOL.md](SECURITY-PROTOCOL.md) — Escalation triggers

**Protocols to Learn:**
- [FRICTION-PROTOCOL.md](FRICTION-PROTOCOL.md) — AK/AAK signals for collaboration
- [THINKING-VISIBILITY-PROTOCOL.md](THINKING-VISIBILITY-PROTOCOL.md) — Tier-2 audit logging for P4-P7 work
- [AUDIT-ARCHITECTURE.md](AUDIT-ARCHITECTURE.md) — Output integrity and binding

**Project-Specific:**
- Check for `AI-PERSONA.md` in project folders for custom instructions
- Follow AAK signals (AAK GO, AAK BIND, AAK STOP) for high-stake work

**Start Here:** [Alliance-to-Empire/AI-PERSONA.md](Alliance-to-Empire/AI-PERSONA.md)

---

### For Developers

**Your Role:** Build, document, and maintain code and workflows within the framework.

**Must Read:**
1. [MANIFESTO.md](MANIFESTO.md) — Understand the vision
2. [GUARDRAILS.md](GUARDRAILS.md) — Know the boundaries
3. [SHARED-RESPONSIBILITY.md](SHARED-RESPONSIBILITY.md) — Your accountability vs. AI's
4. [MARKDOWN-STYLE.md](MARKDOWN-STYLE.md) — Documentation standards
5. [BRANCHING-STRATEGY.md](BRANCHING-STRATEGY.md) — Git workflow

**Workflows to Learn:**
- [IaT/README.md](IaT/README.md) — Infrastructure-as-Text intake and templates
- [CHANGELOG.md](CHANGELOG.md) — Version tracking
- [CURRENT_NOTES_AND_TODOS.md](CURRENT_NOTES_AND_TODOS.md) — Current work

**Projects to Explore:**
- [Alliance-to-Empire/](Alliance-to-Empire/) — Ideation platform
- [One-Shot/](One-Shot/) — R&D core
- [Prince-of-Persia/](Prince-of-Persia/) — Narrative research

**Start Here:** Pick a project, read its `README.md` and `TODO.md`, open an issue or PR.

---

### For Architects

**Your Role:** Design systems, review architecture, ensure scalability and resilience.

**Must Read:**
1. [ARCHITECTURE-HIERARCHY.md](ARCHITECTURE-HIERARCHY.md) — System → Platform → App layers
2. [DESIGN.md](DESIGN.md) — How this framework was built (audit trail)
3. [FULL-ANALYSIS.md](FULL-ANALYSIS.md) — Comprehensive systems thinking analysis
4. [COMPLIANCE.md](COMPLIANCE.md) — Governance and compliance approach
5. [AUDIT-ARCHITECTURE.md](AUDIT-ARCHITECTURE.md) — Audit integrity framework

**Deep Dives:**
- [DEEP-DIVE.md](DEEP-DIVE.md) — Architecture patterns and tradeoffs
- [IaT/REFERENCE-ARCHITECTURE.md](IaT/REFERENCE-ARCHITECTURE.md) — Reference architectures
- [IaT/DECISION-OPTIONS.md](IaT/DECISION-OPTIONS.md) — Decision frameworks

**Protocols to Master:**
- [THINKING-VISIBILITY-PROTOCOL.md](THINKING-VISIBILITY-PROTOCOL.md) — Tier-2 reasoning logs
- [SECURITY-PROTOCOL.md](SECURITY-PROTOCOL.md) — Gatekeeper and escalation
- [FRICTION-PROTOCOL.md](FRICTION-PROTOCOL.md) — Human ↔ AI collaboration

**Start Here:** Review [DESIGN.md](DESIGN.md) and [FULL-ANALYSIS.md](FULL-ANALYSIS.md).

---

### For Policy Makers / Compliance

**Your Role:** Ensure compliance, manage risk, verify governance.

**Must Read:**
1. [CONSTITUTION.md](CONSTITUTION.md) — Immutable principles
2. [GUARDRAILS.md](GUARDRAILS.md) — Boundary enforcement
3. [SHARED-RESPONSIBILITY.md](SHARED-RESPONSIBILITY.md) — Accountability model
4. [COMPLIANCE.md](COMPLIANCE.md) — Compliance-as-code approach
5. [SECURITY-PROTOCOL.md](SECURITY-PROTOCOL.md) — Risk gatekeeping

**Risk & Limitations:**
- [BIAS-AND-PITFALLS.md](BIAS-AND-PITFALLS.md) — Known limitations
- [README.md Cons](README.md#⚠️-cons-unresolved-issues) — Unresolved issues + accepted tradeoffs
- [AI-Guardrails-and-Bias/](AI-Guardrails-and-Bias/) — Ethics case studies

**Audit Trail:**
- [AUDIT-ARCHITECTURE.md](AUDIT-ARCHITECTURE.md) — Audit framework
- [Audit/output/](Audit/output/) — Audit reports
- [CHANGELOG.md](CHANGELOG.md) — Version history

**Start Here:** Read [COMPLIANCE.md](COMPLIANCE.md) and review [Audit/output/](Audit/output/).

---

### For Contributors

**Your Role:** Improve documentation, fix bugs, propose enhancements.

**Must Read:**
1. [README.md](README.md) — Full overview
2. [MANIFESTO.md](MANIFESTO.md) — Vision
3. [DESIGN.md](DESIGN.md) — Construction history
4. [MARKDOWN-STYLE.md](MARKDOWN-STYLE.md) — Doc standards
5. [BRANCHING-STRATEGY.md](BRANCHING-STRATEGY.md) — Git workflow

**Contribution Areas:**
- **Documentation:** Fix typos, improve clarity, add examples
- **Architecture:** Propose system improvements
- **Audit:** Enhance audit scripts, add checks
- **Narrative:** Contribute to storytelling research
- **Ethics:** Add case studies to AI-Guardrails-and-Bias

**Workflow:**
1. Fork the repo
2. Create a feature branch (e.g., `feature/improve-onboarding`)
3. Make your changes
4. Submit PR with clear description
5. Reference CONSTITUTION.md and GUARDRAILS.md alignment

**Start Here:** Read [CURRENT_NOTES_AND_TODOS.md](CURRENT_NOTES_AND_TODOS.md) for open items.

---

## 🗺️ Part 4: Navigation Guide (5 min)

### Finding What You Need

**By Topic:**
- **Vision & Principles** → Root constitutional docs (MANIFESTO, CONSTITUTION, GUARDRAILS)
- **Architecture** → ARCHITECTURE-HIERARCHY.md, DESIGN.md, DEEP-DIVE.md
- **Compliance & Risk** → COMPLIANCE.md, SECURITY-PROTOCOL.md, AUDIT-ARCHITECTURE.md
- **Projects** → Alliance-to-Empire, One-Shot, AI-Guardrails-and-Bias, Prince-of-Persia
- **Workflows** → IaT/, Audit/, showtell/, media/
- **Audit Trail** → CHANGELOG.md, DESIGN.md, Audit/output/

**By File Type:**
- `.md` — Markdown documentation (most files)
- `.yaml` / `.json` — Configuration and data
- `.py` — Python scripts (audit, media generation)
- `.sh` — Shell scripts (audit wrapper)

**Search Tips:**
- Use GitHub search or `grep` for keywords
- Check `README.md` files in each folder for orientation
- Review `TODO.md` files for open work

---

## 🚀 Part 5: Getting Started Checklist (5 min)

### Onboarding Checklist

- [ ] Read [MANIFESTO.md](MANIFESTO.md) — Understand the vision
- [ ] Read [CONSTITUTION.md](CONSTITUTION.md) — Learn core principles
- [ ] Read [GUARDRAILS.md](GUARDRAILS.md) — Know the red lines
- [ ] Read [SHARED-RESPONSIBILITY.md](SHARED-RESPONSIBILITY.md) — Understand accountability
- [ ] Review [README.md](README.md) — Get full overview
- [ ] Pick a persona track:
  - [ ] AI Agent → Read TONE-AND-INTENT.md, FRICTION-PROTOCOL.md
  - [ ] Developer → Read MARKDOWN-STYLE.md, BRANCHING-STRATEGY.md
  - [ ] Architect → Read ARCHITECTURE-HIERARCHY.md, DESIGN.md
  - [ ] Policy → Read COMPLIANCE.md, BIAS-AND-PITFALLS.md
  - [ ] Contributor → Read CURRENT_NOTES_AND_TODOS.md
- [ ] Explore one project folder (Alliance-to-Empire, One-Shot, etc.)
- [ ] Review [CHANGELOG.md](CHANGELOG.md) for recent changes
- [ ] Check [Audit/output/GENERAL-AUDIT-REPORT.md](Audit/output/GENERAL-AUDIT-REPORT.md) for repo health

### First Tasks

**Immediate:**
1. Read the constitutional layer (MANIFESTO, CONSTITUTION, GUARDRAILS)
2. Pick a project or area of interest
3. Read that project's README.md and TODO.md

**First Week:**
1. Complete your persona-specific reading list
2. Open your first issue or PR
3. Review a recent audit report

**Ongoing:**
1. Monitor CHANGELOG.md for updates
2. Participate in discussions or PRs
3. Contribute improvements based on CURRENT_NOTES_AND_TODOS.md

---

## 📖 Part 6: Deep Learning Resources

### Advanced Topics

| **Topic** | **Resource** | **Audience** |
|-----------|--------------|--------------|
| **Architecture Deep Dive** | [DEEP-DIVE.md](DEEP-DIVE.md) | Architects |
| **One-Shot Methodology** | [One-Shot/README.md](One-Shot/README.md) | Researchers |
| **Show & Tell** | [SHOW-AND-TELL.md](SHOW-AND-TELL.md) | Communicators |
| **IaT Workflow** | [IaT/README.md](IaT/README.md) | Architects, Developers |
| **Friction Removal** | [FRICTION-PROTOCOL.md](FRICTION-PROTOCOL.md) | AI Agents, Humans |
| **Thinking Visibility** | [THINKING-VISIBILITY-PROTOCOL.md](THINKING-VISIBILITY-PROTOCOL.md) | High-Stake Work |
| **Security Gatekeeping** | [SECURITY-PROTOCOL.md](SECURITY-PROTOCOL.md) | Policy, Security |

### Case Studies

- **xAI Grok Analysis** → [AI-Guardrails-and-Bias/xAI-LM-Arena-Story.md](AI-Guardrails-and-Bias/xAI-LM-Arena-Story.md)
- **GPT-5 Footnote Failure** → [AI-Guardrails-and-Bias/GPT5-FOOTNOTE-FAILURE-CASE-STUDY.md](AI-Guardrails-and-Bias/GPT5-FOOTNOTE-FAILURE-CASE-STUDY.md)
- **One-Shot Court Transcript** → [One-Shot/COURT_TRANSCRIPT.md](One-Shot/COURT_TRANSCRIPT.md)

---

## ✅ Summary

By now, you should:
1. **Understand** what this repository is and why it exists
2. **Know** where to find constitutional docs, projects, and workflows
3. **Be able to** navigate by persona (AI, Dev, Architect, Policy, Contributor)
4. **Have a checklist** for getting started

**Next Steps:**
- For rapid start → [QUICK-START.md](QUICK-START.md)
- For architecture → [DEEP-DIVE.md](DEEP-DIVE.md)
- For projects → Pick a folder and read its README.md
- For contribution → Read [CURRENT_NOTES_AND_TODOS.md](CURRENT_NOTES_AND_TODOS.md) and open a PR

**Questions?** Open an issue or refer to [TONE-AND-INTENT.md](TONE-AND-INTENT.md) for communication norms.

---

**Welcome to the framework. Let's build something resilient.** 🚀
