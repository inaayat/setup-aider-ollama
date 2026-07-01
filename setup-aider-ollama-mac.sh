 #!/usr/bin/env bash
set -euo pipefail

# setup-aider-ollama-mac.sh
# Working macOS setup for Ollama + Aider using Python 3.12 virtual environment.
# This avoids Python 3.14 dependency issues seen when installing aider-chat.

MODEL=""
MODEL_SET="false"
PROJECT_DIR="$HOME/aider-test"
VENV_DIR="$HOME/aider-env"
PY312="/opt/homebrew/bin/python3.12"

usage() {
  cat <<EOF
Usage: ./setup-aider-ollama-mac.sh [options]

Options:
  --model MODEL       Skip menu and use a specific model
  --project PATH      Test project folder. Default: ~/aider-test
  --venv PATH         Python virtual environment folder. Default: ~/aider-env
  -h, --help          Show this help

Examples:
./setup-aider-ollama-mac.sh
./setup-aider-ollama-mac.sh --model gemma3:27b
./setup-aider-ollama-mac.sh --model gemma3:12b
./setup-aider-ollama-mac.sh --model qwen3-coder:30b

EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --model)
      MODEL="$2"
      MODEL_SET="true"
      shift 2
      ;;
    --project)
      PROJECT_DIR="$2"
      shift 2
      ;;
    --venv)
      VENV_DIR="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      usage
      exit 1
      ;;
  esac
done

# Show model menu if user didn't specify --model
if [[ "$MODEL_SET" != "true" ]]; then

  echo ""
  echo "============================================================"
  echo "Select an Ollama Model"
  echo "============================================================"
  echo ""

  echo "Recommended by RAM:"
  echo "  8GB+   → gemma3:4b"
  echo " 16GB+   → gemma3:12b"
  echo " 32GB+   → gemma3:27b"
  echo " 64GB+   → qwen3-coder:30b"
  echo ""

  echo "1) gemma3:4b         (smallest / fastest)"
  echo "2) gemma3:12b        (balanced)"
  echo "3) gemma3:27b        (recommended)"
  echo "4) qwen3-coder:30b   (best coding model)"
  echo "5) llama3.2:latest"
  echo "6) Custom model"
  echo ""

  read -rp "Choose a model [1-6]: " choice

  case "$choice" in
    1)
      MODEL="gemma3:4b"
      ;;
    2)
      MODEL="gemma3:12b"
      ;;
    3)
      MODEL="gemma3:27b"
      ;;
    4)
      MODEL="qwen3-coder:30b"
      ;;
    5)
      MODEL="llama3.2:latest"
      ;;
    6)
      read -rp "Enter Ollama model name: " MODEL
      ;;
    *)
      echo ""
      echo "Invalid choice. Using default:"
      echo "gemma3:27b"
      MODEL="gemma3:27b"
      ;;
  esac
fi

# Show model menu if user didn't specify --model
if [[ "$MODEL_SET" != "true" ]]; then

  echo ""
  echo "============================================================"
  echo "Select an Ollama Model"
  echo "============================================================"
  echo ""

  echo "Recommended by RAM:"
  echo "  8GB+   → gemma3:4b"
  echo " 16GB+   → gemma3:12b"
  echo " 32GB+   → gemma3:27b"
  echo " 64GB+   → qwen3-coder:30b"
  echo ""

  echo "1) gemma3:4b         (smallest / fastest)"
  echo "2) gemma3:12b        (balanced)"
  echo "3) gemma3:27b        (recommended)"
  echo "4) qwen3-coder:30b   (best coding model)"
  echo "5) llama3.2:latest"
  echo "6) Custom model"
  echo ""

  read -rp "Choose a model [1-6]: " choice

  case "$choice" in
    1)
      MODEL="gemma3:4b"
      ;;
    2)
      MODEL="gemma3:12b"
      ;;
    3)
      MODEL="gemma3:27b"
      ;;
    4)
      MODEL="qwen3-coder:30b"
      ;;
    5)
      MODEL="llama3.2:latest"
      ;;
    6)
      read -rp "Enter Ollama model name: " MODEL
      ;;
    *)
      echo ""
      echo "Invalid choice. Using default:"
      echo "gemma3:27b"
      MODEL="gemma3:27b"
      ;;
  esac
fi


header() {
  echo ""
  echo "============================================================"
  echo "$1"
  echo "============================================================"
}

step() {
  echo ""
  echo "-- $1"
}

header "Aider + Ollama macOS Setup"
echo "Model:       $MODEL"
echo "Project dir: $PROJECT_DIR"
echo "Venv dir:    $VENV_DIR"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This setup script is for macOS only."
  exit 1
fi

step "Checking Homebrew"
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is not installed. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  echo "Homebrew found: $(brew --version | head -n 1)"
fi

step "Checking Ollama"
if ! command -v ollama >/dev/null 2>&1; then
  echo "Installing Ollama..."
  brew install ollama
else
  echo "Ollama found: $(ollama --version || true)"
fi

step "Starting Ollama if needed"
if ! curl -s http://127.0.0.1:11434/api/tags >/dev/null 2>&1; then
  echo "Starting Ollama service..."
  brew services start ollama >/dev/null 2>&1 || true
  sleep 3
fi

if ! curl -s http://127.0.0.1:11434/api/tags >/dev/null 2>&1; then
  echo "Ollama service was not reachable, starting direct server in background..."
  nohup env OLLAMA_CONTEXT_LENGTH=8192 ollama serve > "$HOME/.ollama-aider-setup.log" 2>&1 &
  sleep 5
fi

if ! curl -s http://127.0.0.1:11434/api/tags >/dev/null 2>&1; then
  echo "ERROR: Ollama is not reachable at http://127.0.0.1:11434"
  echo "Try running this in another terminal:"
  echo "  OLLAMA_CONTEXT_LENGTH=8192 ollama serve"
  exit 1
fi

echo "Ollama is reachable."

step "Pulling model: $MODEL"
ollama pull "$MODEL"

step "Installing Python 3.12"
if [[ ! -x "$PY312" ]]; then
  brew install python@3.12
else
  echo "Python 3.12 found: $($PY312 --version)"
fi

if [[ ! -x "$PY312" ]]; then
  echo "ERROR: Python 3.12 was not found at $PY312"
  exit 1
fi

step "Creating Python virtual environment"
"$PY312" -m venv "$VENV_DIR"

step "Activating virtual environment"
# shellcheck disable=SC1090
source "$VENV_DIR/bin/activate"

step "Upgrading pip/setuptools/wheel"
python -m pip install --upgrade pip setuptools wheel

step "Installing Aider"
python -m pip install --upgrade aider-chat

step "Creating test project"
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

if [[ ! -d .git ]]; then
  git init
fi

if [[ ! -f app.py ]]; then
  cat > app.py <<'PY'
print("hello")
PY
fi

if [[ ! -f README.md ]]; then
  cat > README.md <<EOF
# Aider Test Project

This project was created to test Aider + Ollama.

Try this prompt inside Aider:

\`\`\`text
Update app.py so it asks for my name and greets me.
\`\`\`
EOF
fi

if [[ ! -f AIDER_INSTRUCTIONS.md ]]; then
  cat > AIDER_INSTRUCTIONS.md <<'EOF'
# IMPORTANT

You are running inside Aider.

You are NOT a chat-only assistant.

You have repository access.

You can:
- create files
- edit files
- delete files
- rename files
- read files

Never respond with:

"I cannot create files"

or

"I am a text-based AI"

When a user asks for a file:
create or modify repository files.

When a user asks for an Excel file:
create the code and files required to generate the Excel file.

Assume repository access is always available.
EOF
fi

step "Writing local run helper"
RUN_HELPER="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/run-aider.sh"
cat > "$RUN_HELPER" <<EOF
#!/usr/bin/env bash
set -euo pipefail
source "$VENV_DIR/bin/activate"
export OLLAMA_API_BASE=http://127.0.0.1:11434
cd "$PROJECT_DIR"
aider AIDER_INSTRUCTIONS.md --model ollama_chat/$MODEL
EOF
chmod +x "$RUN_HELPER"

header "Setup complete"
echo "Aider version: $(aider --version)"
echo ""
echo "To launch Aider next time, run:"
echo "  cd $(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "  ./run-aider.sh"
echo ""
echo "Or manually run:"
echo "  source $VENV_DIR/bin/activate"
echo "  cd $PROJECT_DIR"
echo "  aider AIDER_INSTRUCTIONS.md --model ollama_chat/$MODEL"
