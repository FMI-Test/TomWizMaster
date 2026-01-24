# Constitution: Core Principles

**Version:** 1.0  
**Created:** January 22, 2026  
**Status:** Foundational (Rarely Changed)  
**Scope:** All projects in GenAI-R&D

---

## Preamble

These principles are **universal across all projects**. They are the immutable laws that guide decision-making, technology selection, and collaboration patterns. Project-specific principles may extend but never contradict these.

---

## Article I: The "Faster, Better, Cheaper" Doctrine

### Section 1: The Question
Before choosing ANY technology, approach, or solution, ask:
> "Isn't there a faster, better, cheaper option?"

### Section 2: Definitions
| Dimension | Definition | Metric |
|-----------|------------|--------|
| **Faster** | Time from idea to validated learning | Hours, not weeks |
| **Better** | Quality of output per unit effort | Usefulness, not perfection |
| **Cheaper** | Total cost (time, money, cognitive load) | Minimized without sacrificing value |

### Section 3: The Better Paradox

<!-- IMAGE PLACEHOLDER: better-paradox
     Prompt: Three cartoon mice at voting booth wearing different hats: "Faster" mouse (running shoes, stopwatch), "Cheaper" mouse (piggy bank, calculator), "Better" mouse (small crown, Jerry's colors). Better in middle with trophy, others pointing at him. Tom (cat) as referee nodding. Text: "Better Always Wins"
     Generate with: Nano Banana
     Theme: Tom & Jerry Collaboration
-->
<!-- ![Better Paradox](images/better-paradox.png) -->

Imagine three advocates voting with equal weight, majority wins:
- **Yas** → Faster advocate
- **Ven** → Cheaper advocate
- **Tom** → Better advocate

| Coalition | Votes | Result |
|-----------|-------|--------|
| Faster + Better | 2 > 1 | ✅ Better wins |
| Better + Cheaper | 2 > 1 | ✅ Better wins |
| Faster + Cheaper | 2 > 1 | ✅ Wins numerically, but... |

**The Irony:** When Faster + Cheaper wins without Better:
- You get something fast ✅
- You get something cheap ✅
- But is it... **better**? ❌

**The Tautology:** "Better" always wins because anything that isn't better... *isn't better*.

The word itself contains the verdict. A 5-year-old understands this. **Better is the kingmaker.**

### Section 4: The Balance Check
- If optimizing ONE significantly hurts ANOTHER → **STOP and reconsider**
- If ALL THREE improve together → **GREEN LIGHT**
- If ONE improves without hurting others → **PROCEED**

---

## Article II: Progressive Enhancement

### Section 1: The Sequence
```
POC (Prove it works) → Beta (Prove it scales) → Production (Optimize)
```

### Section 2: Phase Definitions
| Phase | Duration | Infrastructure | Success Criteria |
|-------|----------|----------------|------------------|
| **POC** | 2-4 hours | None (local) | Working demo |
| **Beta** | 1-2 weeks | Minimal (local) | 5+ users validate |
| **Production** | Ongoing | As needed | Revenue or impact |

### Section 3: The Rule
> "Do not build Phase 3 infrastructure for Phase 1 problems."

---

## Article III: Simplicity Over Complexity

### Section 1: The Bias
**Default to simplicity.** Complexity requires justification.

### Section 2: Complexity Justification
Complexity is allowed ONLY when it provides:
- Measurable user value
- Cost savings at scale
- Security requirements
- Regulatory compliance

### Section 3: Red Flags
- Multiple databases when one suffices
- Microservices for monolith problems
- Over-engineering for hypothetical scale
- Tools that require tools to manage

### Section 4: Green Flags
- Single data store with clear access patterns
- Monolith that can split later if needed
- Boring, proven technology
- Managed services over self-hosted

---

## Article IV: One-Person Maintainability

### Section 1: The Reality
This is solo development with AI assistance.

### Section 2: The Filter
Every tool, technology, and process must pass:
> "Can I build, deploy, and maintain this alone?"

### Section 3: Implications
- Choose managed services over self-hosted
- Automate repetitive tasks
- Document as you go
- Prefer convention over configuration

---

## Article V: MoSCoW Prioritization

### Section 1: The Framework
All features and tasks are categorized:

| Priority | Meaning | Action |
|----------|---------|--------|
| **M**ust | Non-negotiable for success | Build first |
| **S**hould | Important but not critical | Build if time |
| **C**ould | Nice to have | Defer to next phase |
| **W**on't | Explicitly out of scope | Don't build (this phase) |

### Section 2: Red Flag Phrases
- "While we're at it..." → Scope creep
- "It would be cool if..." → Probably COULD/WON'T
- "Users might want..." → Validate first, build later
- "Just a small feature..." → Death by 1000 cuts

### Section 3: Green Flag Phrases
- "Without this, POC fails..." → MUST have
- "This directly proves the concept..." → MUST/SHOULD
- "Users explicitly requested..." → Validate, then prioritize

---

## Article VI: AI as Critical Peer

### Section 1: Role Definition
AI is a **critical peer assistant**, not a code generator:
- ✅ Challenges assumptions
- ✅ Suggests alternatives
- ✅ Reviews code critically
- ✅ Asks "What could go wrong?"
- ✅ Explains concepts, not just provides solutions
- ❌ NOT a "yes-man" that blindly agrees

### Section 2: The Contract
| AI Does | Human Does |
|---------|------------|
| Propose architecture | Decide architecture |
| Draft code | Review code |
| Flag risks | Approve risks |
| Suggest improvements | Accept/reject improvements |
| Explain reasoning | Verify understanding |

### Section 3: Collaboration Modes
1. **Quick Answer** — Simple questions, direct responses
2. **Guided Implementation** — Step-by-step with code
3. **Critical Review** — Feedback and alternatives
4. **Collaborative Planning** — Options and trade-offs
5. **Teaching/Explaining** — Concepts with examples

---

## Article VII: Ship Over Perfect

### Section 1: The Principle
> "A working prototype is worth more than a perfect plan."

### Section 2: The Math
```
$10 spent on POC > $1,000 spent on planning
Working demo > Beautiful documentation
User feedback > Assumptions
```

### Section 3: The Caveat
"Ship" doesn't mean "ship garbage." Minimum quality standards:
- Code runs without crashing
- Basic error handling exists
- Output is useful to someone
- You'd use it yourself

---

## Article VIII: Documentation as Infrastructure

### Section 1: The Principle
Documentation is not optional. It's infrastructure.

### Section 2: Required Documents
Every project must have:
- `README.md` — What, why, how to start
- `PRINCIPLES.md` or inherit from root — Decision framework
- `TODO.md` — What's next

### Section 3: Optional but Recommended
- `AI-PERSONA.md` — Project-specific AI instructions
- `CHANGELOG.md` — What changed
- `DESIGN.md` — How decisions were made

---

## Article IX: Security by Default

### Section 1: The Principle
Security is not a phase. It's a property.

### Section 2: Non-Negotiables
- Never hardcode credentials
- Use environment variables for secrets
- Limit file access to what's needed
- Review AI-generated code before running
- Use `.gitignore` for sensitive files

### Section 3: Permission Model
| Access | Scope |
|--------|-------|
| Read-Write | Current project only |
| Read-Only | Reference materials |
| No Access | Sensitive/unrelated files |

---

## Article X: Validate Before Investing

### Section 1: The Principle
> "Don't build Phase 3 solutions for Phase 1 problems."

### Section 2: Validation Gates
| Phase | Must Validate Before Next |
|-------|---------------------------|
| POC → Beta | Does it actually work? |
| Beta → Staging | Do users actually want it? |
| Staging → Production | Will users actually pay/use it? |

### Section 3: Kill Criteria
If any of these are true, reconsider:
- You wouldn't use it yourself
- No one else wants to try it
- Cost exceeds value
- It doesn't solve the stated problem

---

## Article XI: Evolution Over Rigidity

### Section 1: The Principle
These principles are living guidelines, not carved in stone.

### Section 2: Amendment Process
1. Identify principle that needs updating
2. Document the reason for change
3. Propose new language
4. Review against other principles for conflicts
5. Update with version increment

### Section 3: What Doesn't Change
- The commitment to simplicity
- The focus on user value
- The requirement for maintainability
- The respect for ethical boundaries

---

## Article XII: The Anti-Patterns

### Section 1: Don't Do This
1. **Premature Optimization** — Building for 1M users with 0 users
2. **Resume-Driven Development** — Choosing tech because it's trendy
3. **Not Invented Here** — Building what you could buy/use free
4. **Analysis Paralysis** — Researching forever, building never
5. **Tool Obsession** — More time on tools than product
6. **Complexity Theatre** — Looking sophisticated vs. working
7. **Forgetting the User** — Building what YOU want vs. what THEY need

### Section 2: Do This Instead
1. **Start Simple** — Simplest thing that could possibly work
2. **Boring Technology** — Proven, stable, well-documented
3. **Leverage Platforms** — Managed services over DIY
4. **Ship Fast** — Working prototype over perfect plan
5. **Minimal Tooling** — Only tools you use daily
6. **Clear Architecture** — Easy to understand = easy to maintain
7. **User Feedback** — Talk to users weekly

---

## Signatures

This Constitution is adopted by:

**Human (Jerry 🐭):** Bamdad  
**AI (Tom 🐱):** Claude / GitHub Copilot  
**Date:** January 22, 2026

---

*These principles are living guidelines. Update as you learn. Review before major decisions.*
