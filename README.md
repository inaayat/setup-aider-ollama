# Local Aider + Ollama Setup for macOS

This repo contains a single setup script that installs and configures a local AI coding workflow:

```text
Aider -> Ollama -> local coding model -> your files
```

The goal is to get a **free/local Claude-Code-like workflow** where an AI agent can read and edit files in a git repo without consuming a cloud/token budget.
## Quick Start Cheat Sheet
How to active after installation

source ~/aider-env/bin/activate
cd ~/aider-capabilities
aider --model ollama_chat/gemma3:27b

## What the script does

`setup-local-aider.sh` will:

1. Check that you are on macOS.
2. Install Homebrew if needed.
3. Install Ollama if needed.
4. Start the Ollama service.
5. Pull a local coding model.
6. Install Aider.
7. Add the Ollama API base URL to `~/.zshrc`.
8. Create a tiny test project so you can confirm Aider can edit files.

## Quick start

```bash
chmod +x setup-local-aider.sh
./setup-local-aider.sh
```

Then run:

```bash
cd ~/aider-ollama-test
aider --model ollama_chat/qwen2.5-coder:14b
```

Inside Aider, try:

```text
Update app.py so it asks for my name and greets me.
```

## Optional model choices

Default:

```bash
./setup-local-aider.sh --model qwen2.5-coder:14b
```

Smaller/faster:

```bash
./setup-local-aider.sh --model qwen2.5-coder:7b
```

Alternative coding model:

```bash
./setup-local-aider.sh --model deepseek-coder:6.7b-instruct-q4_K_M
```

## Optional project folder

```bash
./setup-local-aider.sh --project ~/Documents/local-ai-test
```

## Important notes

- This script does **not** download from Hugging Face.
- `ollama pull ...` downloads models through Ollama.
- Use local AI carefully. Do not point it at sensitive/company data unless your company policy explicitly allows that.
- Review all Aider changes before relying on them.

## Common commands

```bash
ollama list
ollama ps
ollama run qwen2.5-coder:14b
aider --model ollama_chat/qwen2.5-coder:14b
```

## Troubleshooting

If Aider cannot connect to Ollama, run:

```bash
OLLAMA_CONTEXT_LENGTH=8192 ollama serve
```

Then open another terminal and run:

```bash
export OLLAMA_API_BASE=http://127.0.0.1:11434
aider --model ollama_chat/qwen2.5-coder:14b
```

If `aider` is not found after install, open a new terminal or run:

```bash
source ~/.zshrc
```
