# Getting Started Guide
## IdeaForge POC - From Setup to First Refinement in 30 Minutes

**Last Updated:** January 18, 2026  
**Audience:** You (solo developer with AI pair programming)  
**Prerequisites:** VS Code installed, Python 3.11+, GitHub Copilot Pro active

---

## Step 1: Install Claude Code (10 minutes)

### Option A: VS Code Extension Marketplace
```
1. Open VS Code
2. Click Extensions icon (Cmd+Shift+X)
3. Search: "Claude" or "Anthropic"
4. Install the official Claude Code extension
5. Reload VS Code
```

### Option B: If Extension Doesn't Exist Yet
Claude Code might be:
- **Cline** (formerly Claude Dev) - community extension
- **Anthropic API integration** - via REST client
- **Claude CLI** - terminal-based tool

**Action:** Search VS Code marketplace for "Claude" and install the most popular AI assistant extension from Anthropic or trusted developers.

### Get API Key
```
1. Go to console.anthropic.com
2. Sign up / Log in
3. Navigate to API Keys section
4. Create new API key
5. Copy key (starts with sk-ant-...)
6. Store securely
```

### Configure in VS Code
```
1. Open VS Code Settings (Cmd+,)
2. Search for "Claude" or extension name
3. Paste API key in appropriate field
4. Save settings
```

### Subscribe to Claude Pro/Max
```
1. Go to claude.ai
2. Upgrade to Pro ($20/month) or Max (if available, ~$40/month)
3. This gives you:
   - Higher usage limits
   - Faster responses
   - Priority access
   - Better models
```

### Test Claude Code
```
1. Open new file: test.py
2. Invoke Claude (check extension docs for shortcut)
3. Ask: "Write a hello world in Python"
4. Verify it responds and generates code
5. ✅ If working, proceed!
```

---

## Step 2: Verify GitHub Copilot Pro (2 minutes)

### Check Copilot Status
```
1. Look for Copilot icon in VS Code status bar (bottom right)
2. Should show as active
3. If not: Click icon → Sign in
```

### Test Copilot
```python
# Create new file: test_copilot.py
# Type this comment and wait:

# Function to add two numbers

# Copilot should suggest:
def add(a, b):
    return a + b

# If you see suggestions, ✅ working!
```

---

## Step 3: Review Project Structure (3 minutes)

### Read These Files in Order:
1. **[PRINCIPLES.md](PRINCIPLES.md)** (5 min scan)
   - Understand guiding principles
   - Note the "faster, better, cheaper" mindset
   - Review cost model with subscriptions

2. **[alliance-to-empire-platform-v1.0-cr-REFINED.md](alliance-to-empire-platform-v1.0-cr-REFINED.md)** (10 min scan)
   - Understand the 2-4 hour POC plan
   - Review Hour 1-4 breakdown
   - Note the code examples

3. **[TODO.md](TODO.md)** (bookmark for reference)
   - See what comes after POC
   - Understand the phases
   - Review success criteria

---

## Step 4: Set Up POC Project (15 minutes)

### Create Project Directory
```bash
# From terminal or VS Code integrated terminal
mkdir ~/ideaforge-poc
cd ~/ideaforge-poc

# Initialize git (optional but recommended)
git init
```

### Set Up Python Virtual Environment
```bash
# Create virtual environment
python3 -m venv venv

# Activate it
source venv/bin/activate  # macOS/Linux
# or
venv\Scripts\activate  # Windows

# Upgrade pip
pip install --upgrade pip
```

### Install Dependencies
```bash
# Minimal dependencies (3 packages)
pip install openai anthropic python-dotenv

# Create requirements.txt
pip freeze > requirements.txt
```

### Create Project Structure
```bash
# Create directories
mkdir data templates

# Create empty files
touch main.py
touch ui.py
touch .env
touch .gitignore
touch README.md
```

### Configure Environment
```bash
# Edit .env file (use VS Code or nano)
code .env

# Add these lines (replace with your actual keys):
OPENAI_API_KEY=sk-proj-your-openai-key-here
ANTHROPIC_API_KEY=sk-ant-your-anthropic-key-here
```

### Create .gitignore
```bash
# Edit .gitignore
code .gitignore

# Add these lines:
venv/
.env
__pycache__/
*.pyc
.DS_Store
data/*.json
```

---

## Step 5: Your First AI-Assisted Coding Session (30 minutes)

### Open Project in VS Code
```bash
# From terminal
code .

# Or File → Open Folder → ideaforge-poc
```

### Hour 1 Sprint: Working Agent

**Minute 0-10: Invoke Claude Code**
```
1. Open main.py
2. Invoke Claude Code (keyboard shortcut from extension)
3. Paste this prompt:

"I'm building an LLM-powered idea refinement tool for a 2-4 hour POC. 
Help me write main.py that:
- Loads OpenAI and Anthropic API keys from .env
- Has an Agent class that can think() using either API
- Has an LLMCouncil class with 2 agents (analyst, critic)
- Has a refine() method that takes an idea and improves it
- Saves results to data/{timestamp}.json
- Has a main() function to run from CLI

Use the file structure from alliance-to-empire-platform-v1.0-cr-REFINED.md as reference.
Keep it simple - one file, ~150 lines, clear comments."
```

**Minute 10-20: Let Copilot Help**
- Claude Code will generate the structure
- As you type, Copilot will suggest completions
- Accept suggestions with Tab
- Edit where needed

**Minute 20-30: Test First Run**
```bash
# Run the script
python main.py

# It should prompt you for an idea
# Enter: "Create a Discord bot for gaming alliance feedback"

# Watch it refine the idea!
```

### Troubleshooting
**If API error:**
- Check .env file has correct keys
- Verify keys are valid in respective consoles
- Check you have credits/quota

**If import error:**
- Verify virtual environment is activated
- Re-run `pip install openai anthropic python-dotenv`

**If Claude Code not working:**
- Check extension is properly installed
- Verify API key is configured
- Try reloading VS Code

---

## Step 6: Celebrate & Review (5 minutes)

### If It Worked ✅
- You just built an AI-powered idea refinement tool in 30 minutes!
- Review the JSON output in `data/` directory
- Compare original idea vs refined version
- **Decision:** Is it meaningfully better?

### Next Steps
1. Try refining 4 more different ideas
2. If quality is good → Proceed to Hour 2 (add more agents)
3. If quality is poor → Adjust prompts and retry
4. If fundamentally broken → Debug or pivot

### Update TODO.md
```bash
# Open TODO.md
code ~/path/to/TODO.md

# Check off:
- [x] Install Claude Code
- [x] Verify GitHub Copilot Pro
- [x] Set up Python Environment
- [x] Create project directory
- [x] Test first LLM agent call
- [x] Refine one test idea end-to-end
```

---

## Tips for AI Pair Programming

### Working with Claude Code
- **Be specific:** "Write a function that..." not "Help me with..."
- **Provide context:** Reference files, requirements, constraints
- **Iterate:** Ask for improvements: "Make this more concise"
- **Learn shortcuts:** Memorize the invoke command for speed

### Working with GitHub Copilot
- **Write comments first:** Describe what you want, let Copilot implement
- **Accept/reject fast:** Tab to accept, Esc to reject, keep flow going
- **Use in-line chat:** For quick refactors without leaving editor
- **Review suggestions:** Don't blindly accept, ensure correctness

### Best Workflow
```
1. Claude Code: "What should I build next?"
   → Get architectural guidance
   
2. You: Write function signature and docstring
   
3. Copilot: Suggests implementation
   → Accept if correct, edit if not
   
4. You: Test the function
   
5. Claude Code: "Review this code for issues"
   → Get critique and improvements
   
6. Iterate until working
```

---

## What Success Looks Like

### After 30 Minutes:
- ✅ Claude Code installed and working
- ✅ Copilot generating helpful suggestions
- ✅ main.py exists and runs without errors
- ✅ One idea refined from input to better output
- ✅ Result saved to JSON

### After 2-4 Hours (Full POC):
- ✅ 4-agent council working
- ✅ Web UI at localhost:5000
- ✅ 5+ test refinements completed
- ✅ Demo video recorded
- ✅ Clear decision: proceed or pivot

---

## Resources

### Documentation
- Claude API: https://docs.anthropic.com/
- OpenAI API: https://platform.openai.com/docs
- GitHub Copilot: https://docs.github.com/copilot
- Python dotenv: https://pypi.org/project/python-dotenv/

### Community
- r/ClaudeAI (Reddit)
- r/OpenAI (Reddit)
- GitHub Copilot Discord
- AI Coding Twitter (#AIcoding)

### Troubleshooting
- GitHub Issues for extensions
- Stack Overflow (tag: claude, copilot)
- Anthropic Discord (if exists)
- OpenAI Community Forum

---

## FAQ

**Q: Do I need both OpenAI and Anthropic APIs?**
A: For the POC, you can start with just one. The multi-model approach is for production diversity. Start with whichever you have credits for.

**Q: What if I don't have Claude Code yet?**
A: Use any AI coding assistant (Cursor, Cody, etc.) or even ChatGPT in a browser for architecture planning. The key is AI-assisted development, not specific tools.

**Q: Can I skip the web UI in Hour 3?**
A: Yes! If CLI works and you're happy, ship that. UI is nice-to-have, not must-have for POC.

**Q: What if 2-4 hours isn't enough?**
A: That's fine! The timeline is aspirational. If you need 6-8 hours, that's still 99% faster than the 12-week original plan.

**Q: Should I write tests for the POC?**
A: Not required for POC. Manual testing is fine. Add automated tests in Beta phase if you proceed.

**Q: What if the idea refinement quality is poor?**
A: Iterate on prompts, try different models, adjust the council composition. Quality tuning is expected.

---

**Ready to build?** Open VS Code, invoke Claude Code, and let's create something amazing! 🚀

**Next:** [TODO.md](TODO.md) for what comes after your first 30 minutes.
