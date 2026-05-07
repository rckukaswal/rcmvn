#!/bin/bash

# ── Config Defaults ───────────────────────

set_allure_defaults() {
    # If Allure dependency is enabled, automatically enable Allure plugin
    if [[ "$ALLURE" == true ]]; then
        ALLURE_PLUGIN=true
    fi
}

# ── Apply All Config Defaults ─────────────

set_config_defaults() {
    set_allure_defaults
}

set_install_defaults() {
   WIN_TOOLS=(java maven git)
    LINUX_TOOLS=(java maven git)
   
   install_tools
}