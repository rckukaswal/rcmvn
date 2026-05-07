# rcmvn — Maven Project Generator

<p align="center">
  <strong>Stop setting up. Start testing.</strong><br/>
  An interactive CLI that scaffolds a complete, production-ready Maven automation framework in seconds.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/shell-bash-green?style=flat-square&logo=gnubash" />
  <img src="https://img.shields.io/badge/java-21-orange?style=flat-square&logo=openjdk" />
  <img src="https://img.shields.io/badge/maven-3.9+-blue?style=flat-square&logo=apachemaven" />
  <img src="https://img.shields.io/badge/platform-linux%20%7C%20mac%20%7C%20windows-lightgrey?style=flat-square" />
  <img src="https://img.shields.io/badge/license-MIT-purple?style=flat-square" />
</p>

---

## 🤔 The Problem

Every time you start a new automation project, you go through the same painful cycle:

- Hunt for the right dependency versions for `pom.xml`
- Copy-paste the same `BaseTest`, `DriverFactory`, `WaitUtils` from your last project
- Manually create `src/main/java`, `src/test/java`, `resources` folders
- Set up TestNG XML, log4j2, config.properties — all over again
- Spend 2-3 hours on boilerplate before writing a single test

**This is wasted time. Every single project.**

---

## ✅ The Solution

`rcmvn` generates everything for you — interactively, in under 30 seconds.

```
Without rcmvn          →   With rcmvn
─────────────────────────────────────────
2-3 hours of setup     →   30 seconds
Manual pom.xml         →   Auto-generated with correct versions
Copy-paste boilerplate →   Fresh, clean code every time
Forgetting a file      →   Nothing missed, ever
```

One command. Answer a few prompts. Your entire framework is ready.

---

## 📦 Install

```bash
curl -fsSL https://raw.githubusercontent.com/rckukaswal/rcmvn/refs/heads/main/cli/setup.sh | bash
source ~/.bashrc
```

The `rcmvn` command is now available globally from anywhere on your system.

**Prerequisites**

| Tool   | Required For              | Install                        |
|--------|---------------------------|--------------------------------|
| `git`  | Install & auto-update     | Pre-installed on most systems  |
| `bash` | Run the CLI               | Pre-installed on most systems  |
| `java` | Build the generated project | [adoptium.net](https://adoptium.net) |
| `mvn`  | Run tests                 | [maven.apache.org](https://maven.apache.org/download.cgi) |

> `java` and `mvn` are only needed to build and run the generated project — not to generate it.

---

## 🚀 Usage

Go to the directory where you want your project created, then run:

```bash
rcmvn
```

The CLI walks you through everything:

```
┌──────────────────────────────────────────────┐
│           Maven Project Generator            │
│           by Ramchandra Kukaswal             │
└──────────────────────────────────────────────┘

  ▶  Choose Framework Level
  ──────────────────────────────────────────
❯ Beginner
  Intermediate
  Advanced


  ▶  Choose Base URL
  ──────────────────────────────────────────
❯ Google
  Amazon
  Custom


  ▶  Project Details
  ──────────────────────────────────────────
  Enter Project Name [my-project]  : myapp-tests
  Enter Group ID     [com.rc]      : com.mycompany


  ╭────────────────────────────────────────────╮
  │ Level          : intermediate               │
  │ Base URL       : https://www.google.com     │
  │ Project        : myapp-tests                │
  │ Group ID       : com.mycompany              │
  │ Artifact       : myapp-tests                │
  │ Base Package   : com.mycompany.tests        │
  ╰────────────────────────────────────────────╯

  Proceed with generation? [Y/n] : Y

  ✔  pom.xml generated
  ✔  Framework generated
  ✔  .gitignore ready
  ✔  Project 'myapp-tests' generated successfully!
```

Open the project in your IDE and start writing tests.

---

## 🧩 Framework Levels

Choose the level that matches your project's needs. Each level builds on top of the previous one.

---

### 🟢 Beginner — Clean & Minimal

Best for: Learning Selenium, small projects, quick POCs.

**What you get:**

```
pom.xml
  └── Dependencies : Selenium, TestNG
  └── Plugins      : Compiler, Surefire
  └── Java         : 21

src/
  └── DriverFactory.java     — Chrome, Firefox, Edge support
  └── BaseTest.java          — @BeforeMethod / @AfterMethod setup
  └── AppTest.java           — Sample test to start from
  └── testng.xml             — Ready-to-run suite
```

---

### 🔵 Intermediate — Reporting & Data Ready

Best for: Real projects, team setups, CI/CD pipelines.

**Everything in Beginner, plus:**

```
pom.xml
  └── + ExtentReports, Allure, REST Assured
  └── + Apache POI, Jackson, Gson
  └── + Failsafe Plugin

src/
  └── utils/
  │     ├── Log.java              — Log4j2 wrapper
  │     ├── WaitUtils.java        — Explicit wait helpers
  │     ├── ScreenshotUtils.java  — Auto screenshot on failure
  │     ├── ExtentManager.java    — HTML report manager
  │     └── ExcelUtils.java       — Read/write Excel test data
  └── listeners/
  │     └── TestListener.java     — Pass/Fail/Skip hooks
  └── suites/
        ├── smoke.xml
        ├── regression.xml
        └── cross_browser.xml

testdata/
  ├── config.properties     — Browser, URL, timeouts
  ├── messages.properties   — Expected messages/validations
  ├── locators.json         — Element locators
  ├── data.json             — Test data
  ├── users.csv             — CSV test data
  └── testdata.xlsx         — Excel test data
```

---

### 🔴 Advanced — Production Grade

Best for: Enterprise projects, parallel execution, full reporting.

**Everything in Intermediate, plus:**

```
src/
  └── manager/
  │     └── DriverManager.java    — ThreadLocal WebDriver (parallel-safe)
  └── pages/
  │     ├── BasePage.java         — PageFactory + smart waits + JS executor
  │     └── AppPage.java          — Page Object template
  └── log4j2.xml                  — Console + rolling file logging
  └── env.properties              — Environment-specific config
```

**Full dependency list available in `cli/config/advanced.config`**

---

## 📁 Full Generated Structure (Advanced)

```
your-project/
├── pom.xml
├── .gitignore
└── src/
    ├── main/
    │   └── java/com/example/project/
    │       ├── factory/
    │       │   └── DriverFactory.java
    │       ├── manager/
    │       │   └── DriverManager.java
    │       ├── pages/
    │       │   ├── BasePage.java
    │       │   └── AppPage.java
    │       └── utils/
    │           ├── Log.java
    │           ├── WaitUtils.java
    │           ├── ScreenshotUtils.java
    │           ├── ExtentManager.java
    │           └── ExcelUtils.java
    └── test/
        ├── java/com/example/project/
        │   ├── base/
        │   │   └── BaseTest.java
        │   ├── tests/
        │   │   └── AppTest.java
        │   └── listeners/
        │       └── TestListener.java
        └── resources/
            ├── suites/
            │   ├── testng.xml
            │   ├── smoke.xml
            │   ├── regression.xml
            │   └── cross_browser.xml
            ├── log4j2.xml
            └── testdata/
                ├── properties/
                │   ├── config.properties
                │   └── messages.properties
                ├── json/
                │   ├── data.json
                │   └── locators.json
                ├── csv/
                │   └── users.csv
                └── excel/
                    └── testdata.xlsx
```

---

## 🔄 Auto-Update

Every time you run `rcmvn`, it silently checks if a newer version is available. If yes, it pulls the latest changes before running. You always get the latest templates — no manual reinstall needed.

```
  ✔  Already up to date — 07 May 2025 10:30 AM
```

or

```
  ✔  Updated — 07 May 2025 10:30 AM
```

---

## 🖥️ Platform Support

| Platform                  | Status           |
|---------------------------|------------------|
| Linux                     | ✅ Full support   |
| macOS                     | ✅ Full support   |
| Windows — Git Bash        | ✅ Full support   |
| Windows — CMD / PowerShell | ❌ Not supported |

> On Windows, use [Git Bash](https://git-scm.com/downloads) or [WSL](https://learn.microsoft.com/en-us/windows/wsl/install).

---

## 🔧 Reinstall / Reset

```bash
curl -fsSL https://raw.githubusercontent.com/rckukaswal/rcmvn/refs/heads/main/cli/setup.sh | bash
source ~/.bashrc
```

This will wipe the existing install and pull the latest version fresh.

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

1. Fork the repo
2. Create your branch — `git checkout -b feature/your-feature`
3. Commit your changes — `git commit -m 'Add your feature'`
4. Push to the branch — `git push origin feature/your-feature`
5. Open a Pull Request

Have an idea or found a bug? [Open an issue](https://github.com/rckukaswal/rcmvn/issues) — all feedback is appreciated.

---

## 👤 Author

**Ramchandra Kukaswal**

- GitHub: [@rckukaswal](https://github.com/rckukaswal)

---

## 📄 License

MIT License — see [LICENSE](./LICENSE) for details.

Free to use, modify, and distribute. If this saved you time, consider giving it a ⭐ on GitHub!