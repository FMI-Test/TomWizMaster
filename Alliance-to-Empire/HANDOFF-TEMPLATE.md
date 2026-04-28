# Cross-Device Session Handoff Card

Fill this out before switching devices. One card per session. Paste it into your next device's editor or notes app and pick up from there.

---

## Handoff Card — [DATE] [TIME]

### Device I am leaving
<!-- e.g. MacBook, Windows laptop, Samsung Galaxy, iPhone, iPad -->

### Device I am switching to
<!-- e.g. MacBook, Windows laptop, Samsung Galaxy, iPhone, iPad -->

---

### Current goal
<!-- One sentence. What am I trying to finish in this session? -->

### Last command or action completed
```
# paste the last terminal command, edit, or action here
```

### Current blocker (if any)
<!-- What is stopped, failing, or unclear? "None" is a valid answer. -->

### Definition of done for this session
<!-- What does "finished" look like for today's work? -->

### Branch and last commit
```
git status --short && git log --oneline -3
```
<!-- paste output here -->

### Files actively changed
<!-- List 1-5 file paths that are in-flight or dirty -->

### Next three actions (in order)
1. 
2. 
3. 

---

## Device Role Reference

| Device | Role |
|--------|------|
| MacBook | Primary build and finalization machine — terminal, VS Code, tests, PRs |
| Windows laptop | Secondary environment — cross-platform validation, enterprise tooling |
| Samsung Galaxy | Mobile continuity — capture, voice notes, GitHub notifications, PR review |
| iPhone Pro Max | Apple-ecosystem continuity — iMessage, AirDrop handoff, Notes sync |
| iPad | Review and planning board — long-form reading, markup, session planning |

---

## Leaner Setup Recommendation

| Need | Best device count | Devices |
|------|------------------|---------|
| Solo builder, single platform | 3 | Laptop + Phone + Tablet |
| Cross-platform validation needed | 4 | MacBook + Windows + Phone + iPad |
| Both Android and iPhone actively used weekly | 5 | All of the above |

> More devices do not automatically create a better multi-agent workflow. Better handoff discipline does.

---

## State Continuity Rules

- Push a checkpoint commit before switching. Never carry local-only state.
- Keep one canonical task list in a single tracked Markdown file.
- Always paste the last three git log lines into the handoff card.
- The handoff card is the single source of truth — not memory, not chat history.
