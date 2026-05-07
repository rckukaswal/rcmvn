#!/bin/bash


# ─── PATH ──────────────────────────────────────
add_to_path() {
    [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]] && export PATH="$PATH:$1"
}

refresh_path() {
    add_to_path "$HOME/.devtools/java/bin"
    add_to_path "$HOME/.devtools/maven/bin"
    hash -r

    local profile="$HOME/.bash_profile"
    grep -q ".devtools/java/bin" "$profile" 2>/dev/null || echo 'export PATH="$PATH:$HOME/.devtools/java/bin"' >> "$profile"
    grep -q ".devtools/maven/bin" "$profile" 2>/dev/null || echo 'export PATH="$PATH:$HOME/.devtools/maven/bin"' >> "$profile"
}

# ─── Install ───────────────────────────────────
install_java_windows() {
    local java_version="21"
    local java_url="https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.7%2B6/OpenJDK21U-jdk_x64_windows_hotspot_21.0.7_6.zip"
    local install_dir="$HOME/.devtools/java"

    log_info "Downloading Java ${java_version}..."
    if ! curl -L -f -# "$java_url" -o "/tmp/java.zip"; then

    log_error "Java download failed — Check your internet connection"
    log_info "Manual download: https://adoptium.net/temurin/releases"
    
    return 1
fi

    unzip -q "/tmp/java.zip" -d "/tmp/java_extract"
    rm -rf "$install_dir" && mkdir -p "$install_dir"
    mv /tmp/java_extract/jdk-*/* "$install_dir/"
    rm -rf /tmp/java.zip /tmp/java_extract
    log_success "Java installed at $install_dir"
}

install_maven_windows() {
    local maven_version="3.9.9"
    local maven_url="https://archive.apache.org/dist/maven/maven-3/${maven_version}/binaries/apache-maven-${maven_version}-bin.zip"
    local install_dir="$HOME/.devtools/maven"

    log_info "Downloading Maven ${maven_version}..."
    if ! curl -L -f -# "$maven_url" -o "/tmp/maven.zip"; then

    log_error "Maven download failed — Check your internet connection"
    log_info "Manual download (Adoptium): https://adoptium.net/temurin/releases"
    log_info "Manual download (Maven):    https://maven.apache.org/download.cgi"

    return 1
fi

    unzip -q "/tmp/maven.zip" -d "/tmp/maven_extract"
    rm -rf "$install_dir" && mkdir -p "$install_dir"
    mv /tmp/maven_extract/apache-maven-*/* "$install_dir/"
    rm -rf /tmp/maven.zip /tmp/maven_extract
    log_success "Maven installed at $install_dir"
}

# ─── Install Tool ──────────────────────────────
install_win_tool() {
    local tool=$1
    install_${tool}_windows
    refresh_path
}

# ─── Check ─────────────────────────────────────
check_win_tool() {
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

# ─── Ensure ────────────────────────────────────
ensure_win_tool() {
    local tool=$1
    refresh_path
    check_win_tool "$tool" && return 0
echo ""


log_warning "$tool not found — required to use directly in Git Bash."
if skip_prompt "Proceed?"; then

    if install_win_tool "$tool" && check_win_tool "$tool"; then
        log_success "$tool installed successfully"
        return 0
    fi
    log_error "$tool installation failed"
    return 1
fi
log_warning "Skipping $tool installation"
return 1
}

refresh_path