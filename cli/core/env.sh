#!/bin/bash


declare -A TOOL_MAP=(
    [maven]=mvn
    [java]=java
    [git]=git
)

# ─── Check ─────────────────────────────────────
check_tool() {
    local tool=$1
    local tool_version=${TOOL_MAP[$tool]:-$tool}
    if command_exists "$tool_version"; then
        log_success "$tool found: $($tool_version --version 2>&1 | sed -n '1p')"
        return 0
    fi
    return 1
}

# ─── Install ───────────────────────────────────
install_tool() {
    local tool=$1
    if command_exists apt; then
        sudo apt install -y "$tool"
    elif command_exists dnf; then
        sudo dnf install -y "$tool"
    elif command_exists yum; then
        sudo yum install -y "$tool"
    elif command_exists pacman; then
        sudo pacman -S "$tool"
    else
        log_warning "Package manager not found"
        return 1
    fi
}

# ─── Ensure ────────────────────────────────────
ensure_tool() {
    local tool=$1

if is_windows;then
    ensure_win_tool "$tool" && return 0
else

    check_tool "$tool" && return 0

    log_warning "$tool not found"
    if skip_prompt "$tool is required. Install now?"; then
        log_info "Installing $tool..."
        if install_tool "$tool" && check_tool "$tool"; then
            log_success "$tool installed successfully"
            return 0
        fi
        log_error "$tool installation failed"
        return 1
    fi
    log_warning "Skipping $tool installation"
    return 1
    fi
}