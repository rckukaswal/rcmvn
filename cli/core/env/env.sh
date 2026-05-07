#!/bin/bash

 APT_UPDATED=0

# Environment Setup and Checks
check_tool() {
    local tool=$1
    local cmd
    cmd=$(get_tool_cmd "$tool")

    if command_exists "$cmd"; then
        local version
        version=$(get_tool_version "$cmd")
        log_success "$tool found: ${version:-version unknown}"
        return 0
    fi
    return 1
}


install_tool() {
    local tool=$1
    local pkg
   
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
    
}