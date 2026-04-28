#!/bin/bash

generate_testng() {
    local output_dir="$1"
    local package_name="$2"
    cat <<EOF > "$output_dir/testng.xml"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE suite SYSTEM "https://testng.org/testng-1.0.dtd">
<suite name="Automation Suite" verbose="1">
    <listeners>
        <listener class-name="$package_name.listeners.TestListener"/>
    </listeners>
    <parameter name="browser" value="chrome"/>
    <parameter name="url"     value="$TEST_URL"/>
    <test name="App Tests">
        <classes>
            <class name="$package_name.tests.AppTest"/>
        </classes>
    </test>
</suite>
EOF
    log_success "testng.xml generated"
}