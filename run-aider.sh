#!/usr/bin/env bash
set -euo pipefail

# run-aider.sh
# Shortcut to launch Aider after setup.
# The setup script will overwrite this file with your selected model/project path.

source "$HOME/aider-env/bin/activate"
export OLLAMA_API_BASE=http://127.0.0.1:11434
cd "$HOME/aider-test"
aider --model ollama_chat/gemma2:9b app.py
