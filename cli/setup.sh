#!/bin/bash
set -e
CACHE_DIR="$HOME/.mvngen"
REPO_URL="https://github.com/rckukaswal/rcmvn.git"
START_SCRIPT="$CACHE_DIR/cli/flow/runner.sh"

# Fresh install / reinstall
if [ -d "$CACHE_DIR" ]; then
    rm -rf "$CACHE_DIR"
fi

echo "⏳ Installing latest version..."
if git clone --depth 1 -q "$REPO_URL" "$CACHE_DIR" >/dev/null 2>&1; then
    echo "✅ Installed successfully"
else
    echo "❌ Installation failed. Check internet connection."
    exit 1
fi

# Update alias — overwrite if already exists

if [ -f "$HOME/.bashrc" ]; then
echo "already exists"
else
    touch "$HOME/.bashrc"
fi
sed -i '/alias rcmvn=/d' "$HOME/.bashrc"
echo "alias rcmvn='bash \$HOME/.mvngen/cli/flow/runner.sh'" >> "$HOME/.bashrc"
echo "✅ Alias 'rcmvn' updated"
echo "ℹ️  Run: source ~/.bashrc"
sleep 2m
bash "$START_SCRIPT"