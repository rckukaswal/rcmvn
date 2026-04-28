#!/bin/bash

generate_regression_suite() {
    local output_dir="$1"
    local package_name="$2"

    mkdir -p "$output_dir"

    cat <<EOF > "$output_dir/regression.xml"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE suite SYSTEM "https://testng.org/testng-1.0.dtd">

<suite name="Regression Suite" verbose="1" parallel="none">

    <listeners>
        <listener class-name="${package_name}.listeners.TestListener"/>
    </listeners>

    <test name="Regression Tests">
        <parameter name="browser" value="chrome"/>
        <parameter name="url"     value=""/>
        <classes>
            <class name="${package_name}.tests.AppTest"/>
        </classes>
    </test>

</suite>
EOF
}