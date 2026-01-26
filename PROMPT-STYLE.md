# Prompt Style — Fast, Clear, Multi‑Lingual

**Version:** 1.0
**Status:** Live
**Source of Truth:** https://github.com/FMI-Test/GenAI-RD/tree/main
**Last Updated:** 2026-01-25

---

## Goal
Make collaboration Faster • Better • Cheaper by standardizing prompt style across English, Persian (فارسی), Finglish, etc. (examples shown; concepts generalize across locales).

## Section Guide
- UI Input Behavior: editor/chat Enter/newline, keyboard setup, workspace defaults.
- AI Multilingual & Normalization: language tags, Finglish rules, `fa_clarify` phrasing.
- Interaction & Signals: AK/AAK signals, emoji compression, recall markers, minimal path.

---

## The 3‑Bullet Start (Always)
- **Goal:** One sentence on the outcome (e.g., "Audit Bias & Pitfalls; triad guidance").
- **Boundaries:** Constraints (e.g., "Docs only; respect GUARDRAILS; no code changes").
- **Evidence:** Required outputs (e.g., "Links, file paths, commit‑ready attestation placeholders").

---

## AI Multilingual & Normalization
## Multi‑Lingual Tags
- `en:` English
- `fa:` Persian (Unicode)
- `fa_finglish:` Persian written with Latin letters

Localization notes:
- Examples use English/Persian/Finglish; extend tags to other languages as needed.
- Some features are OS/locale dependent (e.g., autocorrect, input sources). Apply the same rules conceptually; adjust specifics per environment.

Ask AI to reply bilingually when needed: `reply: en + fa + fa_finglish`

### Translation Helper (Universal)
- When needed, include a live translation link (e.g., Google Translate) for the current snippet to reduce friction for mixed audiences.
- Treat emoji as a universal “decipher key”; pair emoji status with a brief text label.
- Avoid over‑translation; prefer concise bilingual outputs and consistent labels.

---

## Finglish Normalization (Quick Rules)
- Consonant clusters:
  - `kh` → خ
  - `gh` → ق / غ (use context; default ق)
  - `ch` → چ
  - `sh` → ش
  - `zh` → ژ
- Vowels:
  - `a` → ا
  - `â` / `aa` → آ
  - `e` / `eh` → ِ / ـه (context)
  - `i` / `ee` → ی
  - `o` / `ou` → و
  - `u` → و
- Specials:
  - `q` often maps to `ق` (use with care)
  - Final `h` can indicate ه or silent; ask if ambiguous
  - `x` sometimes used for `خ` in chats; normalize to `خ`

If ambiguous, AI should ask: `fa_clarify: منظور شما از این کلمه چیست؟`

---

## UI Input Behavior
## Keyboard Mapping Note
When typing Persian on an English keyboard: rely on `fa_finglish:` and let AI normalize. No need to switch OS keyboard if flow is faster.

---

## macOS Keyboard Setup & Fixes (Persian + Finglish)

### Input Sources
- Open System Settings → Keyboard → Input Sources → Add → Persian.
- Enable "Show Input menu in menu bar" to switch quickly.
- Optional: Keep English (US) + Persian; use Finglish in prompts and let AI normalize to Persian script when needed.

### Typing Aids
- Enable Keyboard Viewer (from the input menu) to see Persian layout live.
- Turn off aggressive auto-correct for mixed scripts: System Settings → Keyboard → Text Input → disable "Correct spelling automatically" for smoother Finglish.
- VS Code: disable inline ghost text if distracting (Settings → Editor: Inline Suggest Enabled = off).

### Quick Persian Mapping Cheat (common digraphs)
- sh → ش, ch → چ, kh → خ, gh → ق/غ, zh → ژ
- â/aa → آ, i/ee → ی, o/ou/u → و
- Ask AI to normalize ambiguity: `fa_clarify: منظور شما از این کلمه چیست؟`

Notes:
- Formal alternative: `fa_clarify: منظور شما از این واژه چیست؟`
- Colloquial alternative: `fa_clarify: منظورتون از این کلمه چیه؟`

---

## Magic Keyboard (2018) Troubleshooting (macOS)

### If not charging / not pairing (long idle)
- Clean the Lightning port gently (dust/oxidation can block charging).
- Try a known-good cable and power source; test charging on another device.
- Plug in via cable and attempt pairing; some keyboards wake better while wired.

### Reset Bluetooth pairing
- System Settings → Bluetooth → remove the keyboard → re-pair.
- If issues persist: toggle Bluetooth off/on; restart macOS.
- Older macOS: Shift+Option click Bluetooth menu → "Reset Bluetooth module" (may not exist on newer versions).

### Reset NVRAM/SMC (MacBook Pro 2018)
- Shut down completely.
- NVRAM: Power on and immediately hold Option+Command+P+R for ~20s.
- SMC (T2 Macs): Shut down → hold Right Shift + Left Option + Left Control for 7 seconds → keep holding and press Power for 7 more seconds → release → wait a few seconds → power on.

### After reset
- Reconnect keyboard; test wired first, then Bluetooth.
- If battery health is poor after years idle, consider replacement.

---

## Low‑Friction Chat in VS Code (Elegance)
- Use Copilot Chat in the side panel instead of inline chat to reduce editor noise.
- Pin chat view; collapse other panels during focused writing.
- Toggle Zen Mode when authoring docs; exit to converse.
- Prefer short, structured prompts (3‑Bullet Start) and request `reply: en + fa + fa_finglish` when meaning may not land.

### Input Mode Reminder
- Show a visible hint near the chat box: "Enter sends, Shift+Enter newline".
- Allow toggling "Enter sends" on/off to prevent accidental submits.

---

## Interaction & Signals
## Interaction Signals (Simple, Street‑Smart)
- **AK GO:** Proceed autonomously within stated boundaries.
- **AK STOP:** Pause immediately. Do not suggest steps. Return:
  - 3‑line TL;DR of current state
  - Two choices: `⚡ Quick Fix` vs `🧪 Deep Fix` (one line each)
  - Ask 1 clarifying question max, then wait
- **🛑 STOP NOW:** Halt. No output except “Stopped.”
- **🎯 Re‑scope coming:** Acknowledge and wait; ask 1 scope question.
- **⚡ Quick Fix mode:** Minimal path only (one step at a time).
- **🧪 Deep Fix mode:** Diagnostic path; declare costs/benefits upfront.

### Raw Input Mode (Authenticity)
- When authenticity matters, the assistant should capture a verbatim copy of the user’s input and reference it in the audit.
- If normalization/autocorrect is used, keep a separate normalized version and provide a short diff summary.
- Suggest: “AAK BIND raw:<short-id>” to link the raw input to the output document or commit.
- No silent corrections: surface changes (Yellow) for review when feasible.

---

## Audit Signals (AAK)
- **AAK GO:** Begin audit logging for the current task.
- **AAK STOP:** Stop audit logging (retain the file; no more entries).
- **AAK BIND <id>:** Bind the audit log to the main output by ID.
- **AAK SAVE:** Flush/checkpoint the current log block.

When AAK signals are active, add a short “Reasoning Summary” block:
- Context: goal and constraints
- Actions: tools/files touched and why
- Result: outcome and verification
- Next: follow‑up or risk

See [THINKING-VISIBILITY-PROTOCOL.md](THINKING-VISIBILITY-PROTOCOL.md) and [audit/README.md](audit/README.md) for details and templates.

---

## Enter/Newline Behavior (Editor vs Chat)

### Editor (Markdown/Text)
- Press Enter → inserts a newline.
- If Enter accepts suggestions instead of newline, set:
  - VS Code Settings → Editor: Accept Suggestion On Enter = off
  - Or in `settings.json`:
```
{
  "editor.acceptSuggestionOnEnter": "off",
  "editor.wordWrap": "on",
  "editor.inlineSuggest.enabled": false,
  "files.eol": "\n"
}
```

### Copilot Chat input
- Enter → sends message (by default).
- Shift+Enter → adds a newline without sending.
- Cmd+Enter → send (useful if you disable “Enter to send”).
 - Windows: Ctrl+Enter → send (optional shortcut).
- Toggle “Enter to send” in the chat input menu (three dots or keyboard icon).

Tip: When writing multi‑paragraph prompts, use Shift+Enter to break lines; send only when ready.

### Repo Workspace Defaults
This repository includes workspace settings to reduce friction:
- See [.vscode/settings.json](.vscode/settings.json) for editor Enter/newline, wrapping, and whitespace defaults.
- See [.editorconfig](.editorconfig) for line endings and formatting consistency.
These affect the repo only (not your global VS Code). Adjust locally as needed.
---

## Minimal Path Mode (Cost/Value Aligned)
- Default to `⚡ Quick Fix` when user signals time/energy low.
- Never list more than 1 actionable step at a time in this mode.
- After each step, confirm: “Continue or stop?”

### Triad Check (Shortcut)
- Ask: "Is it Better & Cheaper or Faster?"
- If Yes → proceed (AK GO). If No → throttle via Cost/Value Gate and clarify once.

## Low‑Friction Structure (Template)
```
AK GO
Goal: <one line>
Boundaries: <bullets>
Evidence: <links/paths/attestation>
lang: en + fa_finglish
reply: en + fa + fa_finglish
```

---

## Protocol Switches (Language)
- Mixed script confusion → AI provides bilingual outputs (en + fa) and a `fa_finglish` mirror.
- Emotional context → Emoji summary line first, then structured bullets.
- Coin‑not‑dropping (دوزاری نمی‌افته) → AI sends a 3‑line TL;DR + asks one clarifying question.

## Emoji Compression (Quick Status)
- First line: 1–3 emojis from the recommended palette to signal status.
- Follow with structured bullets: **Goal**, **Action**, **Result**, **Next**.
- Keep accessibility: add text labels; don’t rely on emoji alone.
- See [EMOJI-COMPRESSION.md](EMOJI-COMPRESSION.md) for palette and examples.

### Recall Markers & Signals
- Use 📌 to mark context; 🌙 indicates rest; 🧠 signals recall; ✨ indicates eureka.
- Signals: **AK MARK <tag>**, **AK RECALL <tag>** to manage recall workflows.
- Bind recall events via **AAK BIND recall:<id>**; include a short Reasoning Summary.
- See [NEUROSCIENCE-WORKFLOW.md](NEUROSCIENCE-WORKFLOW.md) for the end‑to‑end process.

---

## Example
```
AK GO
Goal: Update DOGE.md with SRT analogy and guardrails.
Boundaries: Docs only; add references; no endorsement; keep KPIs primary.
Evidence: file path, section header, links.
lang: en + fa_finglish
reply: en + fa + fa_finglish
```

---

## Ally Tone (Not Code Monkey)
- Mirror intent, propose options, ask one smart clarifying question.
- Offer 2–3 concrete edits with paths; don’t drown in exposition.
- Close with next actions (stage commit? audit? review?).

## Markdown Consistency
- See [MARKDOWN-STYLE.md](MARKDOWN-STYLE.md) for headings, bullets, links, and tone.
- Repo defaults: [.vscode/settings.json](.vscode/settings.json), [.editorconfig](.editorconfig), [.markdownlint.json](.markdownlint.json).

---

## Attestation (fill after commit)
- Commit ID: [to be filled after commit]
- File SHA‑256: [to be filled after commit]
- Curator: [Human]
- Date: [YYYY‑MM‑DD]
