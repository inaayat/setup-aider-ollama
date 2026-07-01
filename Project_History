# Aider + Ollama Complete Handbook

## Executive Summary
This handbook captures the complete journey of setting up Aider + Ollama locally, including the final recommended configuration, failures encountered, troubleshooting performed, design decisions, lessons learned, and how we would rebuild it from scratch.

---

# Final Recommended Setup

- Ollama installed locally
- Python 3.12 virtual environment (`~/aider-env`)
- Aider installed inside the venv
- Interactive model selection in setup script
- AIDER_INSTRUCTIONS.md loaded automatically
- Global launcher/alias (`aider-local`)
- GitHub repository containing setup assets

---

# Complete Installation Walkthrough

## Install Ollama
```bash
brew install ollama
ollama serve
```

Verify:
```bash
curl http://127.0.0.1:11434/api/tags
```

## Install Python 3.12
```bash
brew install python@3.12
```

## Create Virtual Environment
```bash
/opt/homebrew/bin/python3.12 -m venv ~/aider-env
source ~/aider-env/bin/activate
```

## Install Aider
```bash
pip install --upgrade pip setuptools wheel
pip install aider-chat
```

## Download a Model
```bash
ollama pull gemma3:27b
```

Alternatives:
```bash
ollama pull gemma3:12b
ollama pull gemma3:4b
ollama pull qwen3-coder:30b
```

---

# GitHub Repository Contents

```text
README.md
setup-aider-ollama-mac.sh
run-aider.sh
verify-setup.sh
TROUBLESHOOTING.md
AIDER_INSTRUCTIONS.md
.gitignore
```

---

# Daily Workflow

```bash
cd ~/Projects/my-project
source ~/aider-env/bin/activate
aider --model ollama_chat/gemma3:27b
```

or use alias:

```bash
aider-local
```

---

# Everything We Tried That Failed

## System Python
Problem:
- Python 3.14 dependency issues
- package install failures

Fix:
- Standardize on Python 3.12

## Hardcoded app.py
Original:
```bash
aider --model ollama_chat/gemma3:27b app.py
```

Problem:
- Every session anchored to one file
- Confused project navigation

Fix:
```bash
aider AIDER_INSTRUCTIONS.md --model ollama_chat/$MODEL
```

## Hardcoded Model
Original:
```text
gemma2:9b
```

Problem:
- Not suitable for all machines

Fix:
- Interactive model menu
- --model override support

## Duplicate Model Menu
Problem:
- Prompt appeared twice

Cause:
- Duplicate menu block accidentally added

Fix:
- Delete duplicate block

## Broken if/fi Structure
Problem:
```text
syntax error near unexpected token fi
```

Cause:
- Missing matching if statement

Fix:
- Reintroduce correct if block
- Validate using:
```bash
bash -n setup-aider-ollama-mac.sh
```

## Git Problems
Encountered:
- 403 permission errors
- refspec mismatch
- merge conflicts
- index.lock issues

Fixes:
- git add
- git commit
- git push origin main
- git merge --abort
- git pull origin main
- remove stale lock file

## Aider Forgot It Could Create Files
Symptom:
```text
I am a text-based AI and cannot create files
```

Fix:
- Create AIDER_INSTRUCTIONS.md
- Load it at startup

---

# Why AIDER_INSTRUCTIONS.md Exists

Purpose:
- Remind local models they are running inside Aider
- Reinforce file creation and editing capabilities
- Reduce chatbot-style responses

Key guidance:
- Create files when requested
- Modify repository content
- Avoid claiming inability to create files

---

# Testing Prompts

## File Creation
```text
Create a file named hello.txt containing Hello World.
```

## File Modification
```text
Update app.py so it asks for my name and greets me.
```

## Excel Test
```text
Create a Python script called create_excel.py that generates sample.xlsx.
```

## Repository Awareness
```text
What files exist in this repository?
```

## Multi-File Project
```text
Create a Python project with main.py, config.py, and README.md.
```

---

# Lessons Learned

1. Python 3.12 is more reliable for Aider installs.
2. Do not hardcode app.py.
3. Do not force users into aider-test.
4. AIDER_INSTRUCTIONS.md improves behavior.
5. Always validate scripts before executing them.
6. GitHub and local repositories drift over time.
7. Coding-focused models often behave better in Aider.

---

# Running Aider From Anywhere

Add to ~/.zshrc:

```bash
alias aider-local='source ~/aider-env/bin/activate && export OLLAMA_API_BASE=http://127.0.0.1:11434 && aider ~/aider-test/AIDER_INSTRUCTIONS.md --model ollama_chat/gemma3:27b'
```

Reload:

```bash
source ~/.zshrc
```

Use:

```bash
aider-local
```

---

# If We Rebuilt Everything From Scratch

## Use Qwen as Default Coding Model

Preferred:
```text
qwen3-coder:30b
```

Fallback:
```text
gemma3:27b
```

## Global Instructions Location

Instead of:
```text
~/aider-test/AIDER_INSTRUCTIONS.md
```

Use:
```text
~/.aider/AIDER_INSTRUCTIONS.md
```

## Global Launcher

```text
~/bin/aider-local
```

instead of project-specific launchers.

## Auto RAM Detection

Recommend model automatically:

| RAM | Model |
|------|------|
| <16GB | gemma3:4b |
| 16-32GB | gemma3:12b |
| 32GB+ | gemma3:27b |
| 64GB+ | qwen3-coder:30b |

## No Demo Project Dependency

Avoid:
```text
~/aider-test
```

Use:
```text
~/Projects/
```

## Separate Config From Projects

```text
~/.aider/
~/bin/
~/Projects/
```

---

# Recommended Architecture v2

```text
~/
├── aider-env/
├── .aider/
│   └── AIDER_INSTRUCTIONS.md
├── bin/
│   └── aider-local
└── Projects/
    ├── excel-tools
    ├── jira-tools
    ├── automation-scripts
    └── personal-projects
```

Daily use:

```bash
cd ~/Projects/excel-tools
aider-local
```

---

# Future Improvements

- Automatic model recommendation
- Global configuration management
- Better coding-model defaults
- Smarter repo detection
- Simplified installer
- Self-healing launcher generation

---

# Appendix

Useful commands:

```bash
ollama list
ollama serve
curl http://127.0.0.1:11434/api/tags
bash -n setup-aider-ollama-mac.sh
find ~ -name "run-aider.sh"
git status
git pull origin main
git push origin main
```
