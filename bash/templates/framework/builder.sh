#!/bin/bash


build_framework() {
    project_dir="$1"
    package_path="$2"
    package_name="$3"
    
    log_step "Building Framework"

    local tmj="$BASE_DIR/templates/framework/src/main/java"
    local ttj="$BASE_DIR/templates/framework/src/test/java"
    local ttr="$BASE_DIR/templates/framework/src/test/resources"

    source "$tmj/factory/driver_factory.sh"
    source "$tmj/manager/driver_manager.sh"
    source "$tmj/pages/base_page.sh"
    source "$tmj/pages/app_page.sh"
    source "$tmj/utils/log_utils.sh"
    source "$tmj/utils/wait_utils.sh"
    source "$tmj/utils/screenshot_utils.sh"
    source "$tmj/utils/extent_manager.sh"
    source "$tmj/utils/excel_utils.sh"

    source "$ttj/base/base_test.sh"
    source "$ttj/tests/app_test.sh"
    source "$ttj/listeners/test_listener.sh"

    source "$ttr/suites/testng.sh"
    source "$ttr/suites/smoke_suite_xml.sh"
    source "$ttr/suites/regression_suite_xml.sh"
    source "$ttr/suites/cross_browser_xml.sh"

    source "$ttr/log4j2_xml.sh"

    source "$ttr/testdata/properties/config_properties.sh"
    source "$ttr/testdata/properties/messages_properties.sh"
    source "$ttr/testdata/excel/testdata_excel.sh"
    source "$ttr/testdata/json/testdata_json.sh"
    source "$ttr/testdata/json/locators_json.sh"
    source "$ttr/testdata/csv/users_csv.sh"

    generate_framework_files

    log_success "Framework generated"
}

generate_framework_files() {
   


    local mj="$project_dir/src/main/java/$package_path"
    local mr="$project_dir/src/main/resources"
    local tj="$project_dir/src/test/java/$package_path"
    local tr="$project_dir/src/test/resources"

    # Always
    mkdir -p "$mj/factory" "$mj/manager" "$mj/pages"
    mkdir -p "$tj/base" "$tj/tests"
    mkdir -p "$tr/suites" 

    generate_driver_factory    "$mj/factory"             "$package_name"
    generate_driver_manager    "$mj/manager"             "$package_name"
    generate_base_page         "$mj/pages"               "$package_name"
    generate_app_page          "$mj/pages"               "$package_name"
    generate_base_test         "$tj/base"                "$package_name"  "$TEST_URL"
    generate_app_test          "$tj/tests"               "$package_name"
    generate_testng            "$tr/suites"              "$package_name"

    # Utils
    [[ "$GEN_LOG_UTILS"        == "true" ]] && mkdir -p "$mj/utils" && generate_log_utils        "$mj/utils" "$package_name"
    [[ "$GEN_WAIT_UTILS"       == "true" ]] && mkdir -p "$mj/utils" && generate_wait_utils       "$mj/utils" "$package_name"
    [[ "$GEN_SCREENSHOT_UTILS" == "true" ]] && mkdir -p "$mj/utils" && generate_screenshot_utils "$mj/utils" "$package_name"
    [[ "$GEN_EXTENT_MANAGER"   == "true" ]] && mkdir -p "$mj/utils" && generate_extent_manager   "$mj/utils" "$package_name"
    [[ "$GEN_EXCEL_UTILS"      == "true" ]] && mkdir -p "$mj/utils" && generate_excel_utils      "$mj/utils" "$package_name"

    # Listeners
    [[ "$GEN_TEST_LISTENER"       == "true" ]] && mkdir -p "$tj/listeners" && generate_test_listener    "$tj/listeners" "$package_name"

    # Suites
    [[ "$GEN_SMOKE_SUITE"         == "true" ]] && generate_smoke_suite         "$tr/suites" "$package_name"
    [[ "$GEN_REGRESSION_SUITE"    == "true" ]] && generate_regression_suite    "$tr/suites" "$package_name"
    [[ "$GEN_CROSS_BROWSER_SUITE" == "true" ]] && generate_cross_browser_suite "$tr/suites" "$package_name"

   # Resources
   # [[ "$GEN_LOG4J2_XML"          == "true" ]] && mkdir -p "$mr" && generate_log4j2_xml          "$mr"
    [[ "$GEN_LOG4J2_XML"          == "true" ]] && mkdir -p "$tr" && generate_log4j2_xml          "$tr"


    # Testdata
    [[ "$GEN_USERS_CSV"      == "true" ]] && mkdir -p "$tr/testdata/csv"   && generate_users_csv      "$tr/testdata/csv"
    [[ "$GEN_TESTDATA_EXCEL" == "true" ]] && mkdir -p "$tr/testdata/excel" && generate_testdata_excel "$tr/testdata/excel"

    [[ "$GEN_TESTDATA_JSON"        == "true" ]] && mkdir -p "$tr/testdata/json"  && generate_testdata_json  "$tr/testdata/json"
    [[ "$GEN_LOCATORS_JSON"      == "true" ]] && mkdir -p "$tr/testdata/json"  && generate_locators_json  "$tr/testdata/json"

    

   [[ "$GEN_CONFIG_PROPERTIES" == "true" ]] && mkdir -p "$tr/testdata/properties" && generate_config_properties "$tr/testdata/properties" "$TEST_URL"
    [[ "$GEN_MESSAGES_PROPERTIES" == "true" ]] && mkdir -p "$tr/testdata/properties" && generate_messages_properties "$tr/testdata/properties"
}
   