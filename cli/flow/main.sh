#!/bin/bash


BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# Common
source "$BASE_DIR/core/logger.sh"


#set -E
trap 'log_error "Failed in ${BASH_SOURCE[0]} at line $LINENO"' ERR


source "$BASE_DIR/core/helpers.sh"
source "$BASE_DIR/core/defaults.sh"

# OS Specific
source "$BASE_DIR/core/env/env.sh"  
source "$BASE_DIR/core/env/env.windows.sh"

# Input
source "$BASE_DIR/flow/prompt.sh"

# Prepare
source "$BASE_DIR/prepare/gitignore.sh"

# Generators
source "$BASE_DIR/maven/pom/pom_builder.sh"
source "$BASE_DIR/maven/framework/framework_builder.sh"

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
set_install_defaults
#init_git_repo

# Summary
log_step "Project Summary"
echo "  Project Name : $project_name"
echo "  Project Dir  : $base_dir/$project_name"
echo ""

# Next Steps
#show_next_steps