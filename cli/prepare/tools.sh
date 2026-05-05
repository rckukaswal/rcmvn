






step_tools() {
    set +e
    ensure_tool java

    ensure_tool maven
   
    ensure_tool git

    set -e
}



map_tool() {
    local tool=$1

    case "$tool" in
        java)
            PKG="default-jdk"
            CMD="java"
            ;;
        maven)
            PKG="maven"
            CMD="mvn"
            ;;
        git)
            PKG="git"
            CMD="git"
            ;;
        *)
            PKG="$tool"
            CMD="$tool"
            ;;
    esac
    
}
