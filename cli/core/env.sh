#!/bin/bash

# ─── Tool Config ───────────────────────────────
declare -A TOOL_INSTALL_ID=(
    [java]="Microsoft.OpenJDK.21"
    [maven]="Apache.Maven"
    [git]="Git.Git"
)

declare -A TOOL_VERSION_CMD=(
    [java]="java -version"
    [maven]="mvn -version"
    [git]="git --version"
)

declare -A TOOL_CHECK_CMD=(
    [java]="java"
    [maven]="mvn"
    [git]="git"
)

# ─── Install ───────────────────────────────────
install_tool() {
    local tool=$1
    local win_id="${TOOL_INSTALL_ID[$tool]:-$tool}"

    case "$(get_os)" in
        linux)
            if command_exists apt; then
                sudo apt update && sudo apt install -y "$tool"
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
            ;;
        mac)
            brew install "$tool"
            ;;
        windows)
            winget install "$win_id"   # ✅ Sahi ID use hogi
            ;;
        *)
            log_warning "$(get_os): Skipping $tool installation"
            return 1
            ;;
    esac
}

# ─── Check ─────────────────────────────────────
check_tool() {
    local tool=$1
    local cmd="${TOOL_CHECK_CMD[$tool]:-$tool}"      # mvn for maven
    local ver_cmd="${TOOL_VERSION_CMD[$tool]:-$tool -version}"

    if command_exists "$cmd"; then
        local version
        version=$(${ver_cmd} 2>&1 | sed -n '1p')
        log_success "$tool found: $version"
        return 0
    fi
    return 1
}

# ─── Ensure ────────────────────────────────────
ensure_tool() {
    local tool=$1
    if check_tool "$tool"; then
        return 0
    fi
    log_warning "$tool not found"
    if skip_prompt "$tool is required. Install now?"; then
        log_info "Installing $tool..."
        install_tool "$tool" || return 0
        if check_tool "$tool"; then
            log_success "$tool installed successfully"
            return 0
        fi
        log_error "$tool installation failed"
        return 1
    fi
    log_warning "Skipping $tool installation"
    return 1
}