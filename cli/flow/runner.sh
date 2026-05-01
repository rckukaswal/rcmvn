#!/bin/bash
set -e

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$BASE_DIR/core/logger.sh"

CACHE_DIR="$HOME/.mvngen"
REPO_URL="https://github.com/rckukaswal/rcmvn.git"
MAIN_SCRIPT="$CACHE_DIR/cli/flow/main.sh"

clear

echo ""
echo "┌──────────────────────────────────────────────┐"
echo "│           Maven Project Generator            │"
echo "│           by Ramchandra Kukaswal             │"
echo "└──────────────────────────────────────────────┘"
echo ""

sync_latest() {
    log_info "Syncing latest version..."
    LATEST_HASH=$(git ls-remote "$REPO_URL" HEAD 2>/dev/null | cut -f1)
    CURRENT_HASH=$(cat "$CACHE_DIR/.git/refs/heads/main" 2>/dev/null || echo "none")

    if [[ "$LATEST_HASH" == "$CURRENT_HASH" ]]; then
        log_success "Already up to date"
        echo ""
    else
        TEMP_DIR=$(mktemp -d)
        if git clone --depth 1 -q "$REPO_URL" "$TEMP_DIR" >/dev/null 2>&1; then
            rm -rf "$CACHE_DIR"
            mv "$TEMP_DIR" "$CACHE_DIR"
            log_success "Updated"
            echo ""
        else
            rm -rf "$TEMP_DIR"
            log_warning "No network detected"
            log_info "Running current version"
        fi
    fi
}

sync_latest
bash "$MAIN_SCRIPT"
