#!/usr/bin/env bash
set -euo pipefail

VENV_DIR="$HOME/aider-env"

echo "Checking Ollama..."

if ! command -v ollama >/dev/null 2>&1; then
  echo "FAIL: ollama command not found"
  exit 1
fi

ollama --version || true

if ! curl -s http://127.0.0.1:11434/api/tags >/dev/null 2>&1; then
  echo "FAIL: Ollama is not reachable at http://127.0.0.1:11434"
  echo "Try: OLLAMA_CONTEXT_LENGTH=8192 ollama serve"
  exit 1
fi

echo "Ollama is reachable."

echo ""
echo "Installed models:"
ollama list

echo ""
echo "Checking Python 3.12..."

if [[ ! -x /opt/homebrew/bin/python3.12 ]]; then
  echo "FAIL: /opt/homebrew/bin/python3.12 not found"
  exit 1
fi

/opt/homebrew/bin/python3.12 --version

echo ""
echo "Checking virtual environment..."

if [[ ! -f "$VENV_DIR/bin/activate" ]]; then
  echo "FAIL: Virtual environment not found at $VENV_DIR"
  exit 1
fi

source "$VENV_DIR/bin/activate"

echo ""
echo "Checking Aider..."

if ! command -v aider >/dev/null 2>&1; then
  echo "FAIL: Aider not found"
  exit 1
fi

aider --version

echo ""
echo "SUCCESS ✅"
echo "Ollama is running."
echo "Python 3.12 is installed."
echo "Aider is installed."
echo "At least one Ollama model is available."
echo ""
echo "Start Aider with:"
echo ""
echo "  ./run-aider.sh"
echo ""
