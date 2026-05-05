#!/bin/bash

# ─── Tool Config ───────────────────────────────
declare -A TOOL_INSTALL_ID=(
    [java]="Microsoft.OpenJDK.21"
    [git]="Git.Git"
    # maven winget pe nahi hai, special install hai
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
            if [[ "$tool" == "maven" ]]; then
                install_maven_windows   # ← special case
            else
                winget install "$win_id"
            fi
            ;;
        *)
            log_warning "$(get_os): Skipping $tool installation"
            return 1
            ;;
    esac

    refresh_path
}

# ─── Maven Windows Special Install ────────────
install_maven_windows() {
    local maven_version="3.9.9"
    local maven_url="https://archive.apache.org/dist/maven/maven-3/${maven_version}/binaries/apache-maven-${maven_version}-bin.zip"
    local install_dir="$HOME/tools/maven"

    log_info "Downloading Maven ${maven_version}..."

    if ! curl -L -f "$maven_url" -o "/tmp/maven.zip"; then
        log_error "Maven download failed"
        return 1
    fi

    unzip -q "/tmp/maven.zip" -d "/tmp/maven_extract"
    
    # ✅ Pehle clean karo
    rm -rf "$install_dir"
    mkdir -p "$install_dir"
    
    mv /tmp/maven_extract/apache-maven-*/* "$install_dir/"
    rm -rf /tmp/maven.zip /tmp/maven_extract

    log_success "Maven installed at $install_dir"
}

# ─── Check ─────────────────────────────────────
check_tool() {
    local tool=$1
    local cmd="${TOOL_CHECK_CMD[$tool]:-$tool}"
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
        if install_tool "$tool"; then        # ✅ install check karo
            if check_tool "$tool"; then
                log_success "$tool installed successfully"
                return 0
            fi
            log_error "$tool installation failed"
            return 1
        else
            log_error "$tool installation failed"  
            return 1
        fi
    fi
    log_warning "Skipping $tool installation"
    return 1
}

# ─── Refresh PATH ──────────────────────────────
refresh_path() {
    case "$(get_os)" in
        windows)
            local paths=(
                "/c/Program Files/Microsoft/*/bin"
                "/c/Program Files/Java/*/bin"
                "$HOME/tools/maven/bin"        # ✅ Updated
                "/c/Program Files/Git/bin"
            )
            for p in "${paths[@]}"; do
                for expanded in $p; do
                    if [[ -d "$expanded" ]]; then
                        export PATH="$PATH:$expanded"
                    fi
                done
            done
            ;;
        linux|mac)
            export PATH="$PATH:/usr/local/bin:/usr/bin"
            ;;
    esac
}