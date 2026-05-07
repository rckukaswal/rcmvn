#!/bin/bash

POM_COMPONENTS="$CLI_DIR/maven/pom/components"

source "$POM_COMPONENTS/versions.sh"
source "$POM_COMPONENTS/dependencies.sh"
source "$POM_COMPONENTS/plugins.sh"
source "$POM_COMPONENTS/render.sh"

properties=""
dependencies=""
plugins=""

property_flags=(
    "SELENIUM_VERSION:selenium.version"
    "WEBDRIVERMANAGER_VERSION:webdrivermanager.version"
    "TESTNG_VERSION:testng.version"
    "ASSERTJ_VERSION:assertj.version"
    "JUNIT_VERSION:junit.version"
    "MOCKITO_VERSION:mockito.version"
    "LOG4J_VERSION:log4j.version"
    "LOGBACK_VERSION:logback.version"
    "EXTENT_VERSION:extent.version"
    "ALLURE_VERSION:allure.version"
    "POI_VERSION:poi.version"
    "JACKSON_VERSION:jackson.version"
    "GSON_VERSION:gson.version"
    "ITEXT_VERSION:itext.version"
    "PDFBOX_VERSION:pdfbox.version"
    "RESTASSURED_VERSION:restassured.version"
    
    "WIREMOCK_VERSION:wiremock.version"
    "MYSQL_VERSION:mysql.version"
    "POSTGRES_VERSION:postgres.version"
    "APPIUM_VERSION:appium.version"
    "LOMBOK_VERSION:lombok.version"

    "COMPILER_PLUGIN_VERSION:maven.compiler.plugin.version"
    "SUREFIRE_PLUGIN_VERSION:maven.surefire.plugin.version"
    "FAILSAFE_PLUGIN_VERSION:maven.failsafe.plugin.version"
    "ALLURE_PLUGIN_VERSION:allure.maven.version"
)

dependency_flags=(
    "SELENIUM:selenium"
    "WEBDRIVERMANAGER:webdrivermanager"
    "TESTNG:testng"
    "ASSERTJ:assertj"
    "JUNIT:junit"
    "MOCKITO:mockito"
    "LOG4J:log4j"
    "LOGBACK:logback"
    "EXTENT:extent"
    "ALLURE:allure"
    "POI:poi"
    "JACKSON:jackson"
    "GSON:gson"
    "ITEXT:itext"
    "PDFBOX:pdfbox"
    "RESTASSURED:restassured"
    "WIREMOCK:wiremock"
    "MYSQL:mysql"
    "POSTGRES:postgres"
    "APPIUM:appium"
    "LOMBOK:lombok"
)

plugin_flags=(
    "COMPILER_PLUGIN:compiler_plugin"
    "SUREFIRE_PLUGIN:surefire_plugin"
    "FAILSAFE_PLUGIN:failsafe_plugin"
    "ALLURE_PLUGIN:allure_plugin"
)

# Build properties
build_properties() {
    properties=""

    for item in "${property_flags[@]}"; do
        var_name="${item%%:*}"         # TESTNG_VERSION
        property_name="${item##*:}"    # testng.version

        base_name="${var_name%_VERSION}"  # TESTNG

        # agar flag true hai
        if [[ "${!base_name}" == true ]]; then

            # agar version nahi diya to default use karo
            if [[ -z "${!var_name}" ]]; then
                default_var="DEFAULT_${var_name}"
                eval "$var_name=\${$default_var}"
            fi

            properties="$properties
        <$property_name>${!var_name}</$property_name>"
        fi
    done
}

# Build dependencies
build_dependencies() {
    dependencies=""
    for item in "${dependency_flags[@]}"; do
        flag_name="${item%%:*}"
        dep_name="${item##*:}"
        if [[ "${!flag_name}" == true ]]; then
            dependencies="$dependencies
${!dep_name}
"
        fi
    done
}

# Build plugins
build_plugins() {
    plugins=""
    for item in "${plugin_flags[@]}"; do
        flag_name="${item%%:*}"
        plugin_name="${item##*:}"
        if [[ "${!flag_name}" == true ]]; then
            plugins="$plugins
${!plugin_name}
"
        fi
    done
}

# Build POM
build_pom() {
    log_step "Generate POM"
    build_properties
    build_dependencies
    build_plugins
    generate_pom "$base_dir/$project_name"
    log_success "pom.xml generated"
}
