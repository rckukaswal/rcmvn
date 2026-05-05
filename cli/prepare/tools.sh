step_tools() {
    set +e
    ensure_tool java

    ensure_tool maven
   
    ensure_tool git

    set -e
}