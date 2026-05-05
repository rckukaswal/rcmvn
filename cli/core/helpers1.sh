#!/bin/bash

command_exists() {
    command -v "$1" &> /dev/null
}

run_command() {
    "$@"
}

create_dir() {
    mkdir -p "$1"
}

copy_file() {
    cp "$1" "$2"
}

file_exists() {
    [[ -f "$1" ]]
}

dir_exists() {
    [[ -d "$1" ]]
}

confirm_prompt() {
    local message="${1:-Proceed?}"
    read -p "$message [Y/n] : " confirm </dev/tty
    confirm=${confirm:-Y}
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        log_warning "Generation cancelled"
        exit 0
    fi
}
skip_prompt() {
    local message="${1:-Skip this step?}"
    local choice

    read -p "$message [Y/n] : " choice </dev/tty
    choice=${choice:-Y}

    if [[ "$choice" =~ ^[Yy]$ ]]; then
        return 0
    fi

    return 1
}

select_option() {
    local prompt="$1"
    shift
    local options=("$@")
    local selected=0
    local key
    local lines=${#options[@]}

    local CYAN='\033[0;36m'
    local BOLD='\033[1m'
    local RESET='\033[0m'

    # Initial render (only options)
    for i in "${!options[@]}"; do
        if [[ $i -eq $selected ]]; then
            printf "${CYAN}${BOLD}❯ %s${RESET}\n" "${options[$i]}" >&2
        else
            printf "  %s\n" "${options[$i]}" >&2
        fi
    done

    while true; do
        read -rsn1 key </dev/tty

        case "$key" in
            $'\x1b')
                read -rsn2 key </dev/tty
                case "$key" in
                    "[A")
                        ((selected--))
                        [[ $selected -lt 0 ]] && selected=$((${#options[@]} - 1))
                        ;;
                    "[B")
                        ((selected++))
                        [[ $selected -ge ${#options[@]} ]] && selected=0
                        ;;
                esac

                # Move to option block start
                for ((i=0; i<lines; i++)); do
                    tput cuu1 >&2
                done

                # Clear option lines
                for ((i=0; i<lines; i++)); do
                    tput el >&2
                    tput cud1 >&2
                done

                # Move back again
                for ((i=0; i<lines; i++)); do
                    tput cuu1 >&2
                done

                # Redraw options
                for i in "${!options[@]}"; do
                    if [[ $i -eq $selected ]]; then
                        printf "${CYAN}${BOLD}❯ %s${RESET}\n" "${options[$i]}" >&2
                    else
                        printf "  %s\n" "${options[$i]}" >&2
                    fi
                done
                ;;
            "")
                printf '%s\n' "${options[$selected]}"
                return
                ;;
        esac
    done
}



get_os() {
    case "$(uname -s)" in
        Linux*)              echo "linux" ;;
        Darwin*)             echo "mac" ;;
        MINGW*|MSYS*|CYGWIN*) echo "windows" ;;
        *)                   echo "unknown" ;;
    esac
}

is_windows() {
    [[ "$(get_os)" == "windows" ]]
}

show_next_steps() {
    echo "Next Steps:"
    if is_windows; then
        echo "   $(get_os) detected"
        echo "   Open project in IntelliJ or Eclipse"
        echo "   Import as Maven project"
    else
        echo "   cd $project_name"
        echo "   mvn test"
    fi
    echo ""
}

install_tool() {
    local tool=$1
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
            winget install "$tool"
            ;;
        *)
            log_warning "$(get_os): Skipping $tool installation"
            return 1
            ;;
    esac
}

# ─────────────────────────────────────
install_java() {
    install_tool java
}

install_maven() {
    install_tool maven
}

install_git() {
    install_tool git
}

check_tool() {
    local tool=$1
    if command_exists "$tool"; then
        local version
        version=$("$tool" -version 2>&1 | sed -n '1p')
        log_success "$tool found: $version"
        return 0
    fi
    return 1
}

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