#!/bin/bash

# Environment Setup and Checks
check_tool() {
    local tool=$1
    local cmd
    cmd=$(get_tool_cmd "$tool")

    if command_exists "$cmd"; then
        local version
        version=$($cmd --version 2>/dev/null | head -n1 || \
                  $cmd -version 2>/dev/null | head -n1 || \
                  $cmd -v 2>/dev/null)

        log_success "$tool found: ${version:-version unknown}"
        return 0
    fi
    return 1
}



install_tool() {
    local tool=$1
    local pkg
    APT_UPDATED=0
    pkg=$(get_tool_pkg "$tool")

    if command_exists apt; then
        if [ "$APT_UPDATED" -eq 0 ]; then
            sudo apt update -y
            APT_UPDATED=1
        fi
        sudo apt install -y "$pkg"
        
    elif command_exists dnf; then
        sudo dnf install -y "$pkg"
    elif command_exists yum; then
        sudo yum install -y "$pkg"
    elif command_exists pacman; then
        sudo pacman -S --noconfirm "$pkg"
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