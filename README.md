# Local Aider + Ollama Setup for macOS

This repository contains everything needed to set up a local AI coding assistant using:

```text
Aider → Ollama → Gemma 3 27B → Your Files
```

The goal is to create a free, local coding assistant that can read and edit files without consuming cloud AI credits.

---

# Quick Start (Once Setup Is Complete)

Open Terminal and run:

```bash
cd ~/my-project
source ~/aider-env/bin/activate && aider --model ollama_chat/gemma3:27b
```

Replace `~/my-project` with the folder you want Aider to work on.

---

# Repository Contents

The repository should contain:

```text
README.md
setup-aider-ollama-mac.sh
run-aider.sh
verify-setup.sh
TROUBLESHOOTING.md
.gitignore
```

---

# Download the Repository

## Option 1: Download ZIP

On GitHub:

```text
Code → Download ZIP
```

Extract the ZIP and open Terminal in the extracted folder.

## Option 2: Clone the Repository

```bash
git clone https://github.com/<your-username>/setup-aider-ollama.git

cd setup-aider-ollama
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
