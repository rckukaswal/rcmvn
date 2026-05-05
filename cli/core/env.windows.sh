#!/bin/bash

# ─── Tool Config ───────────────────────────────
declare -A TOOL_CHECK_CMD=(
    [java]="java"
    [maven]="mvn"
    [git]="git"
)

declare -A TOOL_VERSION_CMD=(
    [java]="java -version"
    [maven]="mvn -version"
    [git]="git --version"
)

# ─── PATH ──────────────────────────────────────
add_to_path() {
    [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]] && export PATH="$PATH:$1"
}

refresh_path() {
    local java_exe
    java_exe=$(find "/c/Program Files" -maxdepth 4 -name "java.exe" 2>/dev/null | head -1)
    [[ -n "$java_exe" ]] && add_to_path "$(dirname "$java_exe")"
    add_to_path "$HOME/tools/maven/bin"
    add_to_path "/c/Program Files/Git/bin"
    hash -r
}

# ─── Install ───────────────────────────────────
install_java_windows() {
    winget install Microsoft.OpenJDK.21
}

install_maven_windows() {
    local maven_version="3.9.9"
    local maven_url="https://archive.apache.org/dist/maven/maven-3/${maven_version}/binaries/apache-maven-${maven_version}-bin.zip"
    local install_dir="$HOME/tools/maven"

    log_info "Downloading Maven ${maven_version}..."
    if ! curl -L -f "$maven_url" -o "/tmp/maven.zip"; then
        log_error "Maven download failed"; return 1
    fi

    unzip -q "/tmp/maven.zip" -d "/tmp/maven_extract"
    rm -rf "$install_dir" && mkdir -p "$install_dir"
    mv /tmp/maven_extract/apache-maven-*/* "$install_dir/"
    rm -rf /tmp/maven.zip /tmp/maven_extract
    log_success "Maven installed at $install_dir"
}

install_git_windows() {
    winget install Git.Git
}

# ─── Install Tool ──────────────────────────────
install_tool() {
    local tool=$1
    install_${tool}_windows
    refresh_path
}

# ─── Check ─────────────────────────────────────
check_tool() {
    local tool=$1
    local cmd="${TOOL_CHECK_CMD[$tool]:-$tool}"
    local ver_cmd="${TOOL_VERSION_CMD[$tool]:-$tool --version}"

    if command_exists "$cmd"; then
        log_success "$tool found: $(${ver_cmd} 2>&1 | sed -n '1p')"
        return 0
    fi
    return 1
}

# ─── Ensure ────────────────────────────────────
ensure_tool() {
    local tool=$1

    refresh_path
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

refresh_path#!/bin/bash

# ─── Tool Config ───────────────────────────────
declare -A TOOL_CHECK_CMD=(
    [java]="java"
    [maven]="mvn"
    [git]="git"
)

declare -A TOOL_VERSION_CMD=(
    [java]="java -version"
    [maven]="mvn -version"
    [git]="git --version"
)

# ─── PATH ──────────────────────────────────────
add_to_path() {
    [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]] && export PATH="$PATH:$1"
}

refresh_path() {
    local java_exe
    java_exe=$(find "/c/Program Files" -maxdepth 4 -name "java.exe" 2>/dev/null | head -1)
    [[ -n "$java_exe" ]] && add_to_path "$(dirname "$java_exe")"
    add_to_path "$HOME/tools/maven/bin"
    add_to_path "/c/Program Files/Git/bin"
    hash -r
}

# ─── Install ───────────────────────────────────
install_java_windows() {
    winget install Microsoft.OpenJDK.21
}

install_maven_windows() {
    local maven_version="3.9.9"
    local maven_url="https://archive.apache.org/dist/maven/maven-3/${maven_version}/binaries/apache-maven-${maven_version}-bin.zip"
    local install_dir="$HOME/tools/maven"

    log_info "Downloading Maven ${maven_version}..."
    if ! curl -L -f "$maven_url" -o "/tmp/maven.zip"; then
        log_error "Maven download failed"; return 1
    fi

    unzip -q "/tmp/maven.zip" -d "/tmp/maven_extract"
    rm -rf "$install_dir" && mkdir -p "$install_dir"
    mv /tmp/maven_extract/apache-maven-*/* "$install_dir/"
    rm -rf /tmp/maven.zip /tmp/maven_extract
    log_success "Maven installed at $install_dir"
}

install_git_windows() {
    winget install Git.Git
}

# ─── Install Tool ──────────────────────────────
install_tool() {
    local tool=$1
    install_${tool}_windows
    refresh_path
}

# ─── Check ─────────────────────────────────────
check_tool() {
    local tool=$1
    local cmd="${TOOL_CHECK_CMD[$tool]:-$tool}"
    local ver_cmd="${TOOL_VERSION_CMD[$tool]:-$tool --version}"

    if command_exists "$cmd"; then
        log_success "$tool found: $(${ver_cmd} 2>&1 | sed -n '1p')"
        return 0
    fi
    return 1
}

# ─── Ensure ────────────────────────────────────
ensure_tool() {
    local tool=$1

    refresh_path
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

refresh_path