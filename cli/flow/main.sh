#!/bin/bash
#set -e
BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# Common
source "$BASE_DIR/core/logger.sh"
source "$BASE_DIR/core/helpers.sh"
source "$BASE_DIR/core/env.sh"
source "$BASE_DIR/core/defaults.sh"


echo "DEBUG OS: $(get_os)"        # ← OS check
echo "DEBUG PATH: $PATH" 

# Input
source "$BASE_DIR/flow/prompt.sh"

# Prepare
source "$BASE_DIR/prepare/gitignore.sh"
source "$BASE_DIR/prepare/tools.sh"

# Generators
source "$BASE_DIR/maven/pom/builder.sh"
source "$BASE_DIR/maven/framework/builder.sh"

# Run Input
collect_user_input

# Dynamic Config
source "$BASE_DIR/config/default.config"
source "$BASE_DIR/config/$LEVEL.config"
set_config_defaults

log_step "Starting Maven Project Generation"

# Project Generation
create_dir "$base_dir/$project_name"
build_pom
build_framework "$base_dir/$project_name" "$package_path" "$package_name"


log_success "Project '$project_name' generated successfully!"
log_step "Environment checks and setup in progress...."

# Environment Check
create_gitignore
step_tools
#init_git_repo

# Summary
log_step "Project Summary"
echo "  Project Name : $project_name"
echo "  Project Dir  : $base_dir/$project_name"
echo ""

# Next Steps
show_next_steps