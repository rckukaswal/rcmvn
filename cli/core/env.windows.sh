#!/bin/bash

# ─── Tool Config ───────────────────────────────
declare -A TOOL_CHECK_CMD=(
    [java]="java"
    [maven]="mvn"
)

declare -A TOOL_VERSION_CMD=(
    [java]="java -version"
    [maven]="mvn -version"
)

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
        log_error "Java download failed"; return 1
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
        log_error "Maven download failed"; return 1
    fi

    unzip -q "/tmp/maven.zip" -d "/tmp/maven_extract"
    rm -rf "$install_dir" && mkdir -p "$install_dir"
    mv /tmp/maven_extract/apache-maven-*/* "$install_dir/"
    rm -rf /tmp/maven.zip /tmp/maven_extract
    log_success "Maven installed at $install_dir"
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

log_info "Using IDE (IntelliJ/Eclipse)? Skip — IDE handles $tool."
log_info "Using Git Bash directly? Install now."

if skip_prompt "Install $tool?"; then
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