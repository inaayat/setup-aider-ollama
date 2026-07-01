# Troubleshooting Aider + Ollama Setup

## Problem: `aider: command not found`

Aider is installed inside the virtual environment at `~/aider-env`, so activate it first:

```bash
source ~/aider-env/bin/activate
aider --version
```

Or use:

```bash
./run-aider.sh
```

---

## Problem: Python 3.14 breaks Aider install

Symptoms may include:

```text
AttributeError: module 'pkgutil' has no attribute 'ImpImporter'
ERROR: Failed to build 'numpy'
```

Fix: use Python 3.12 in a virtual environment:

```bash
brew install python@3.12
/opt/homebrew/bin/python3.12 -m venv ~/aider-env
source ~/aider-env/bin/activate
pip install --upgrade pip setuptools wheel
pip install aider-chat
```

This repo's setup script already does this.

---

## Problem: `externally-managed-environment`

If you run this:

```bash
/opt/homebrew/bin/python3.12 -m pip install aider-chat
```

Homebrew may block the install because the Python environment is externally managed.

Fix: install inside a virtual environment instead:

```bash
/opt/homebrew/bin/python3.12 -m venv ~/aider-env
source ~/aider-env/bin/activate
pip install aider-chat
```

---

## Problem: Ollama is not reachable

Check whether Ollama is running:

```bash
curl http://127.0.0.1:11434/api/tags
```

If it fails, run:

```bash
OLLAMA_CONTEXT_LENGTH=8192 ollama serve
```

Then open another terminal and run Aider.

---

## Problem: `setup-local-aider.sh: command not found`

If you are inside the folder, run scripts with `./` in front:

```bash
./setup-aider-ollama-mac.sh
```

Not:

```bash
setup-aider-ollama-mac.sh
```

---

## Problem: model is too slow

Use a smaller model:

```bash
./setup-aider-ollama-mac.sh --model llama3.2:latest
```

or:

```bash
./setup-aider-ollama-mac.sh --model gemma2:9b
```

---

## Problem: I want to switch models

Pull the model:

```bash
ollama pull llama3.2:latest
```

Launch Aider with it:

```bash
source ~/aider-env/bin/activate
cd ~/aider-test
aider --model ollama_chat/llama3.2:latest app.py
```
