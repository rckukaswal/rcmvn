generate_driver_manager() {
    local output_dir="$1"
    local package_name="$2"
    mkdir -p "$output_dir"
    cat <<EOF > "$output_dir/DriverManager.java"
package ${package_name}.manager;

import org.openqa.selenium.WebDriver;

public class DriverManager {

    private static ThreadLocal<WebDriver> driver = new ThreadLocal<>();

    private DriverManager() {}

    public static WebDriver getDriver() {
        return driver.get();
    }

    public static void setDriver(WebDriver driverRef) {
        driver.set(driverRef);
    }

    public static void quitDriver() {
        if (driver.get() != null) {
            driver.get().quit();
            driver.remove();
        }
    }
}
EOF
}