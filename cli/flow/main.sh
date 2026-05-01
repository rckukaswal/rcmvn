#!/bin/bash
set -e
BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# Common
source "$BASE_DIR/core/logger.sh"
source "$BASE_DIR/core/helpers.sh"
source "$BASE_DIR/core/defaults.sh"

# Input
source "$BASE_DIR/flow/prompt.sh"

# Prepare
source "$BASE_DIR/prepare/java.sh"
source "$BASE_DIR/prepare/maven.sh"
source "$BASE_DIR/prepare/git.sh"
source "$BASE_DIR/prepare/gitignore.sh"

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
create_gitignore

log_success "Project '$project_name' generated successfully!"
log_step "Environment checks and setup in progress...."

# Environment Check
ensure_java
ensure_maven
ensure_git
init_git_repo

# Summary
log_step "Project Summary"
echo "  Project Name : $project_name"
echo "  Project Dir  : $base_dir/$project_name"
echo ""

# Next Steps
echo "Next Steps:"
echo "   cd $project_name"
echo "   mvn test"
echo ""