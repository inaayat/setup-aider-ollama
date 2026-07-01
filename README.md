# Local Aider + Ollama Setup for macOS

This repository contains everything needed to set up a local AI coding assistant using:

```text
Aider → Ollama → Gemma 3 27B → Your Files
```

The goal is to create a free, local coding assistant that can read and edit files without consuming cloud AI credits.

---
# Quick Install

Run:

```bash
curl -fsSL https://raw.githubusercontent.com/inaayat/setup-aider-ollama/main/setup-aider-ollama-mac.sh | bash
```

---

# Quick Start (Once Setup Is Complete)

Open Terminal and run:

```bash
cd ~/my-project
./run-aider.sh
```

Replace `~/my-project` with the folder containing the files you want Aider to edit.

---

# Repository Contents

This repository should contain:

```text
README.md
setup-aider-ollama-mac.sh
run-aider.sh
verify-setup.sh
TROUBLESHOOTING.md
.gitignore
```

---

# Download the Files

Choose one option.

## Option 1: Download ZIP (Easiest)

1. Open this GitHub repository.
2. Click:

```text
Code → Download ZIP
```

3. Extract the ZIP file.
4. Open Terminal.
5. Navigate to the extracted folder:

```bash
cd ~/Downloads/setup-aider-ollama
```

Replace the path with your actual folder location if different.

---

## Option 2: Clone the Repository

If Git is installed:

```bash
git clone https://github.com/<your-github-username>/setup-aider-ollama.git

cd setup-aider-ollama
```

You should now see:

```text
README.md
setup-aider-ollama-mac.sh
run-aider.sh
verify-setup.sh
TROUBLESHOOTING.md
.gitignore
```

---

# Installation

Make the scripts executable:

```bash
chmod +x setup-aider-ollama-mac.sh run-aider.sh verify-setup.sh
```

Run setup:

```bash
./setup-aider-ollama-mac.sh
```

The setup script will:

- Install Homebrew (if needed)
- Install Ollama (if needed)
- Start Ollama
- Download Gemma 3 27B
- Install Python 3.12
- Create a Python virtual environment
- Install Aider
- Create a test project

---

# Verify Installation

Run:

```bash
./verify-setup.sh
```

You should see:

```text
SUCCESS: Ollama + Aider setup looks good.
```

---

# First Test

Create a project:

```bash
mkdir -p ~/my-project
cd ~/my-project

git init
```

Start Aider:

```bash
./run-aider.sh
```

Then try:

```text
Create a Python script called create_excel.py that generates sample.xlsx with sample data.
```

---

# Running Aider Every Time

Whenever you open a new terminal:

```bash
cd ~/my-project
./run-aider.sh
```

Replace `~/my-project` with the folder containing the files you want Aider to edit.

---

# Useful Commands

### Check installed models

```bash
ollama list
```

### Run Gemma directly

```bash
ollama run gemma3:27b
```

### Check Aider version

```bash
source ~/aider-env/bin/activate
aider --version
```

### Exit Aider

```text
/exit
```

---

# Switching Models

Download another model:

```bash
ollama pull llama3.2:latest
```

Launch Aider with it:

```bash
aider --model ollama_chat/llama3.2:latest
```

---

# Troubleshooting

### Aider cannot connect to Ollama

Run:

```bash
OLLAMA_CONTEXT_LENGTH=8192 ollama serve
```

Then open another terminal and run:

```bash
export OLLAMA_API_BASE=http://127.0.0.1:11434
```

---

### Aider not found

Activate the virtual environment:

```bash
source ~/aider-env/bin/activate
```

---

### Installation fails due to Python 3.14

Install Python 3.12:

```bash
brew install python@3.12
```

Then rerun the setup script.

---

### Check that Ollama is running

```bash
curl http://127.0.0.1:11434/api/tags
```

If you receive JSON output, Ollama is running correctly.

---

# Recommended Project Structure

```text
Projects/
├── aider-ollama-setup
├── jira-tools
├── excel-tools
├── automation-scripts
└── my-project
```

Run Aider from the project folder containing the files you want it to edit.

Example:

```bash
cd ~/Projects/excel-tools
./run-aider.sh
```

---

# Example Workflow

Create a project:

```bash
mkdir -p ~/Projects/example-project
cd ~/Projects/example-project
git init
```

Start Aider:

```bash
./run-aider.sh
```

Ask Aider:

```text
Create a Python script that compares two Excel files and outputs the differences.
```

Review the proposed changes and approve them if they look correct.
