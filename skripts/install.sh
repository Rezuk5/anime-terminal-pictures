#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

set -e

sudo pacman -Syu --needed \
    python \
    git \
    python-pipx \
    rofi


find "$PROJECT_DIR/terminalGui" -type f -name "*.sh" -exec chmod +x {} \;

echo "==> Configuring TerminalPictures..."

PYTHON=""

for cmd in python3 python; do
    if command -v "$cmd" >/dev/null 2>&1; then
        PYTHON="$cmd"
        break
    fi
done

if [ -z "$PYTHON" ]; then
    echo "✗ Python not found."
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"$PYTHON" "$SCRIPT_DIR/install.py"

echo "✓ Configuration complete."

pipx install "$PROJECT_DIR"
echo "Making shell scripts executable..."

echo "Done!"