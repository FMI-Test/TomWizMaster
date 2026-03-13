![README](images/README.png)

# Alliance to Empire Platform

**From Discord Feedback to AI-Powered Ideation Engine**

> Transform rough ideas into actionable execution plans through multi-agent LLM collaboration and iterative refinement.

---

## � Constitutional Inheritance

This project inherits from the root **GenAI-R&D Constitutional Framework**:

| Root Document | Purpose | This Project |
|---------------|---------|--------------|
| [../CONSTITUTION.md](../CONSTITUTION.md) | Core principles | Inherited |
| [../SHARED-RESPONSIBILITY.md](../SHARED-RESPONSIBILITY.md) | AI/Human roles | Inherited |
| [../GUARDRAILS.md](../GUARDRAILS.md) | Boundaries | Inherited |
| [../TONE-AND-INTENT.md](../TONE-AND-INTENT.md) | Communication | Inherited |
| [AI-PERSONA.md](AI-PERSONA.md) | Project-specific persona | **Extended** |
| [PRINCIPLES.md](PRINCIPLES.md) | Project-specific principles | **Extended** |

**Read root documents first for universal context.**

---

## 🚀 Quick Start

**New here? Start in this order:**

1. **[../MANIFESTO.md](../MANIFESTO.md)** → Why we build (root)
2. **[GETTING-STARTED.md](GETTING-STARTED.md)** → 30-minute setup guide
3. **[TODO.md](TODO.md)** → Your complete roadmap
4. **[SUMMARY.md](SUMMARY.md)** → Session overview & next steps
5. **[PRINCIPLES.md](PRINCIPLES.md)** → Project-specific decision framework

**Ready to build?** Follow the hour-by-hour guide in the CR document below.

---

## 📚 Core Documentation

### Planning & Strategy
- **[PRINCIPLES.md](PRINCIPLES.md)** - 12 guiding principles for all decisions
  - One-person development constraints
  - "Faster, better, cheaper" framework
  - **MoSCoW prioritization & MVP definitions** (NEW!)
  - Cost model with subscriptions
  - Technology selection criteria
  - AI-assisted development workflow

- **[alliance-to-empire-platform-v1.0.md](alliance-to-empire-platform-v1.0.md)** - Original comprehensive plan (REFERENCE ONLY)
  - Discord implementation concept
  - Startup analysis
  - Platform architecture vision
  - 12-week timeline (deprecated)
  
- **[alliance-to-empire-platform-v1.0-cr-REFINED.md](alliance-to-empire-platform-v1.0-cr-REFINED.md)** - **EXECUTE THIS**
  - Ultra-lean POC approach (2-4 hours)
  - Hour-by-hour implementation guide
  - Complete working code samples
  - Cost: $5-10 for POC session
  - Status: ✅ Approved and ready

### Implementation Guides
- **[GETTING-STARTED.md](GETTING-STARTED.md)** - Your first 30 minutes
  - Install Claude Code
  - Verify GitHub Copilot Pro
  - Set up Python environment
  - Create project structure
  - Test first AI-assisted session
  - Troubleshooting tips

- **[TODO.md](TODO.md)** - Complete task breakdown
  - Phase 0: Setup & Learning
  - Phase 1: POC (2-4 hours)
  - Phase 2: Beta (Week 1-2)
  - Phase 3: Deployment (Day 1-2)
  - Phase 4: Growth (Month 2+)
  - Success criteria per phase
  - Risk mitigation strategies

### Project Context
- **[SUMMARY.md](SUMMARY.md)** - What we've accomplished
  - Session achievements
  - Key decisions made
  - Budget tracker
  - Security checklist
  - When you return guide

- **[AI-PERSONA.md](AI-PERSONA.md)** - AI collaboration profile
  - AI's role and communication style
  - How to work together effectively
  - Prompt patterns that work
  - Evolution of collaboration

---

## 🎯 Project Status

**Current Phase:** Pre-POC Setup  
**Last Updated:** January 18, 2026  
**Next Milestone:** Complete setup, run 2-4 hour POC

### Completed ✅
- Comprehensive planning & documentation
- Ultra-lean POC plan (99% cost/time reduction)
- Setup guides & roadmap
- Principles & decision framework

### In Progress ⏳
- [ ] Study Boris Cherny's Claude Code setup
- [ ] Subscribe to Claude Code Pro/Max
- [ ] Install & configure tools
- [ ] Set up security/permissions

### Next Up 🔜
- WSO knowledge base transfer
- Configure AI as critical peer
- 2-4 hour POC session
- Demo video & decision point

---

## 💰 Cost Model

### Monthly Subscriptions (Fixed)
- **GitHub Copilot Pro:** $10/month ✅ (subscribed)
- **Claude Code Pro/Max:** $20-40/month ⏳ (to subscribe)
- **Total:** $30-50/month

### Per-Project (Marginal)
- **POC session (2-4 hrs):** $2-10 (LLM API calls)
- **Beta month:** $10-20
- **Deployed:** $0-10 (AWS free tier)

### One-Time (Optional)
- **Dev laptop:** $0-1500 (new MacBook Air for isolation)
- **Domain:** $12/year (deferred until deploy)

**Key Insight:** With subscriptions, experimentation is nearly free!

---

## 🛠 Tech Stack

### POC Phase (Local)
- **Language:** Python 3.11+
- **LLM APIs:** OpenAI + Anthropic
- **Storage:** Local JSON files
- **UI:** CLI + Flask (localhost)
- **Infrastructure:** None (runs on laptop)
- **Features:** See MoSCoW MUST/SHOULD in [PRINCIPLES.md](PRINCIPLES.md)

### Beta Phase (Still Local)
- **Database:** SQLite
- **UI:** Enhanced Flask with templates
- **Testing:** pytest

### Deployment (If Validated)
- **Compute:** AWS Lambda
- **Storage:** S3 + DynamoDB
- **API:** Lambda Function URLs
- **Monitoring:** CloudWatch

---

## 📖 Documentation Map

```
p00-alliance-to-empire/
│
├── README.md (← YOU ARE HERE - Hub for all docs)
│
├── 📘 Start Here
│   ├── GETTING-STARTED.md (30-min setup)
│   ├── TODO.md (complete roadmap)
│   └── SUMMARY.md (session overview)
│
├── 📋 Planning
│   ├── PRINCIPLES.md (decision framework)
│   ├── alliance-to-empire-platform-v1.0.md (original plan - reference)
│   └── alliance-to-empire-platform-v1.0-cr-REFINED.md (execute this!)
│
├── 🤖 Collaboration
│   └── AI-PERSONA.md (how to work with AI)
│
└── 🔧 Implementation (Created during POC)
    ├── ideaforge-poc/ (project directory)
    ├── data/ (results & outputs)
    └── docs/ (generated documentation)
```

---

## 🎓 Key Decisions

### Development Approach
- **Solo + AI:** One person with Claude Code + GitHub Copilot
- **POC First:** Validate in 2-4 hours before investing weeks
- **Local First:** Prove concept locally before cloud deployment
- **Progressive:** POC → Beta → Deploy (only if validated)

### Security Model
- **Option A:** New laptop for development isolation
- **Option B:** Secure guardrails on current MacBook Pro
  - VS Code Workspace Trust
  - Project RW access only
  - WSO read-only for KB transfer

### AI Collaboration
- **Claude Code:** Architecture, planning, code review
- **GitHub Copilot:** Line-by-line code completion
- **AI as Critical Peer:** Challenge assumptions, suggest alternatives
- **Learn Together:** Explain concepts, not just provide code

---

## 📊 Success Criteria

### POC Success (2-4 hours)
- ✅ Refines 5+ test ideas successfully
- ✅ Output meaningfully better than input
- ✅ Would use it weekly yourself
- ✅ Can demo in <5 minutes

### Beta Success (2 weeks)
- ✅ 5+ active users
- ✅ 3+ willing to pay $10/month
- ✅ 80%+ positive feedback

### Deployment Success (1 month)
- ✅ 50+ sign-ups
- ✅ 10+ paying users
- ✅ $100+ MRR
- ✅ Costs < revenue

---

## 🔗 External Resources

### Learning Resources
- **Boris Cherny's Claude Code Setup:** https://x.com/bcherny/status/2007179833990885678
- **Claude API Docs:** https://docs.anthropic.com/
- **GitHub Copilot Docs:** https://docs.github.com/copilot
- **VS Code Workspace Trust:** https://code.visualstudio.com/docs/editor/workspace-trust

### Community
- r/ClaudeAI (Reddit)
- r/OpenAI (Reddit)
- GitHub Copilot Discord
- AI Coding Twitter (#AIcoding)

---

## 🚦 Project Dependencies

### External Dependencies (Minimal by Design)
**Python Packages (POC Phase - only 3!):**
- `openai` - OpenAI API client
- `anthropic` - Anthropic API client
- `python-dotenv` - Environment variable management

**Optional (Beta Phase):**
- `flask` - Web UI
- `pytest` - Testing framework
- `sqlite3` - Database (built into Python)

**Cloud (Deployment Phase - only if validated):**
- AWS Lambda - Serverless compute
- S3 - Object storage
- DynamoDB - NoSQL database

### Internal Dependencies (Managed)
**Documentation:**
- README.md → Links to all other docs
- Each doc can be read independently
- Cross-references kept minimal

**Principle:** Add dependencies only when justified by value. Remove when no longer needed.

---

## 🔄 Keeping This README Updated

**When you add/change documentation:**

1. **New MD file created?** → Add link in "Documentation Map" section
2. **File renamed/moved?** → Update all links in this README
3. **Phase completed?** → Update "Project Status" section
4. **Decision made?** → Add to "Key Decisions" section
5. **Dependency added?** → Update "Project Dependencies" section
6. **New principle/framework added?** → Update "Philosophy" or relevant section

**MoSCoW for README Updates:**
- **MUST update:** New file, changed file location, major status change
- **SHOULD update:** New key decision, dependency change, phase transition
- **COULD update:** Minor tweaks, clarifications, examples
- **WON'T update:** Every tiny edit (batch updates instead)

**Quarterly review:** Check all links work, remove outdated content.

---

## 💡 Philosophy

> "Build the smallest thing that proves the concept, then scale if it works."

FromMoSCoW prioritization** - MUST/SHOULD/COULD/WON'T for every feature
- **MVP per phase** - Clear definition of minimum viable product
- ** [PRINCIPLES.md](PRINCIPLES.md):
- **Faster, better, cheaper** - Always ask
- **$10 spent > $1000 planned**
- **Working POC > perfect plan**
- **Ship > Perfect**
- **One person can build this**

---

## 🆘 Getting Help

### Good First Questions
1. "Where do I start?" → [GETTING-STARTED.md](GETTING-STARTED.md)
2. "What's the timeline?" → [TODO.md](TODO.md)
3. "How much will this cost?" → See "Cost Model" above
4. "What if it fails?" → See success criteria & pivot plans in [TODO.md](TODO.md)

### Working with AI
- See [AI-PERSONA.md](AI-PERSONA.md) for collaboration tips
- Ask specific questions, not vague ones
- Request explanations, not just code
- Challenge AI's suggestions
- Learn, don't just copy-paste

---

## 📝 Version History

- **v1.0** (Jan 18, 2026) - Comprehensive plan (over-engineered)
- **v1.1-CR** (Jan 18, 2026) - Ultra-lean POC approach (approved)
- **Current** - Pre-POC setup phase

---

## 🎯 Next Actions

**This Week:**
1. Study Boris Cherny's setup (30 min)
2. Decide on security approach (30 min)
3. Subscribe to Claude Code Pro/Max (15 min)
4. Install & configure (2 hours)
5. WSO KB transfer prep (1 hour)
6. Schedule 4-hour POC session

**See [TODO.md](TODO.md) for detailed checklist.**

---

## 📄 License & Ownership

**Status:** Personal project, not open source (yet)  
**Owner:** Bamdad  
**AI Assistance:** Claude Code + GitHub Copilot

---

**Ready to build?** Start with [GETTING-STARTED.md](GETTING-STARTED.md) 🚀

**Questions?** Check [AI-PERSONA.md](AI-PERSONA.md) for collaboration tips.

**Last Updated:** January 18, 2026
