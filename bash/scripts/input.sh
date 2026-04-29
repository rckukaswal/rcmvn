#!/bin/bash

# ---------- NORMALIZE FUNCTIONS ----------
normalize_project_name() {
    echo "$1" \
    | tr '[:upper:]' '[:lower:]' \
    | tr ' ' '-' \
    | sed 's/[^a-z0-9-]//g' \
    | sed 's/-\+/-/g' \
    | sed 's/^-//' \
    | sed 's/-$//'
}

normalize_group_id() {
    echo "$1" \
    | tr '[:upper:]' '[:lower:]' \
    | tr ' ' '.' \
    | sed 's/[^a-z0-9.]//g' \
    | sed 's/\.\+/\./g' \
    | sed 's/^\.//' \
    | sed 's/\.$//'
}

# ---------- MAIN FUNCTION ----------
collect_user_input() {

    log_info "Input Format Guide:"
    echo "  Project Name : company-purpose"
    echo "  Group ID     : domain.company"
    echo "  Base Package : domain.company.purpose"

    base_dir=$(pwd)

    # -------- LEVEL --------
    log_step "Choose Framework Level"
    level_label=$(select_option "" "Beginner" "Intermediate" "Advanced")

    case "$level_label" in
        "Beginner") LEVEL="beginner" ;;
        "Intermediate") LEVEL="intermediate" ;;
        "Advanced") LEVEL="advanced" ;;
    esac

    # -------- URL --------
    log_step "Choose Base URL"
    url_label=$(select_option "" "Google" "Amazon" "Custom")

    case "$url_label" in
        "Google") TEST_URL="https://www.google.com" ;;
        "Amazon") TEST_URL="https://www.amazon.in" ;;
        "Custom")
            read -p "Enter Custom URL [https://www.google.com] : " TEST_URL </dev/tty
            TEST_URL=${TEST_URL:-https://www.google.com}
            ;;
    esac

    # -------- PROJECT NAME --------
    log_step "Project Details"

    read -p "Enter Project Name [my-project] : " project_name </dev/tty
    project_name=${project_name:-my-project}
    project_name=$(normalize_project_name "$project_name")

    # fallback if empty
    [ -z "$project_name" ] && project_name="my-project"

    while dir_exists "$base_dir/$project_name"; do
        log_warning "Project '$project_name' already exists"
        read -p "Enter a new project name [my-project] : " project_name </dev/tty
        project_name=${project_name:-my-project}
        project_name=$(normalize_project_name "$project_name")
    done

    # -------- GROUP ID --------
    read -p "Enter Group ID [com.rc] : " group_id </dev/tty
    group_id=${group_id:-com.rc}
    group_id=$(normalize_group_id "$group_id")

    # fallback
    [ -z "$group_id" ] && group_id="com.rc"

    # -------- DERIVED VALUES --------
    artifact_id="$project_name"
    artifact_last="${artifact_id##*-}"

    package_name="$group_id.$artifact_last"
    package_path=$(echo "$package_name" | tr '.' '/')

    # -------- EXPORT --------
    export LEVEL TEST_URL
    export project_name group_id artifact_id
    export package_name package_path base_dir

    # -------- SUMMARY --------
    log_step "Selected Configuration"

    printf "  ╭────────────────────────────────────────────╮\n"
    printf "  │ %-14s : %-25s │\n" "Level" "$LEVEL"
    printf "  │ %-14s : %-25s │\n" "Base URL" "$TEST_URL"
    printf "  │ %-14s : %-25s │\n" "Project" "$project_name"
    printf "  │ %-14s : %-25s │\n" "Group ID" "$group_id"
    printf "  │ %-14s : %-25s │\n" "Artifact" "$artifact_id"
    printf "  │ %-14s : %-25s │\n" "Base Package" "$package_name"
    printf "  ╰────────────────────────────────────────────╯\n"
    echo ""

    confirm_prompt "Proceed with generation?"
}