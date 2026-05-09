# rcmvn
> # Selenium Automation Framework Generator

<p align="center">
  <strong>Stop setting up. Start testing.</strong><br/>
  An interactive CLI that scaffolds a complete, production-ready Maven automation framework in seconds.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/shell-bash-green?style=flat-square&logo=gnubash" />
  <img src="https://img.shields.io/badge/java-21-orange?style=flat-square&logo=openjdk" />
  <img src="https://img.shields.io/badge/maven-3.9+-blue?style=flat-square&logo=apachemaven" />
  <img src="https://img.shields.io/badge/platform-linux%20%7C%20mac%20%7C%20windows-lightgrey?style=flat-square" />
  <img src="https://img.shields.io/badge/license-CC%20BY--NC%204.0-red?style=flat-square" />
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
─────────────────────────────────────────────────
2-3 hours of setup     →   30 seconds
Manual pom.xml         →   Auto-generated with correct versions
Copy-paste boilerplate →   Fresh, clean code every time
Forgetting a file      →   Nothing missed, ever
No IDE? Stuck.         →   Full setup from terminal — no IDE needed
```

One command. Answer a few prompts. Your entire framework is ready.

---

## ⚡ Features

| Feature | Details |
|---|---|
| 🔁 **Second-run ready** | Run `rcmvn` again anytime — no reinstall needed, alias persists globally |
| 🌐 **No URL required** | Base URL is optional — sensible defaults provided, skip if not needed |
| ☕ **Auto Java install** | Detects if Java is missing and installs it automatically |
| 🔧 **Auto Maven install** | Detects if Maven is missing and installs it automatically |
| 🐙 **Auto Git install** | Detects if Git is missing and installs it automatically |
| 📌 **Version check** | Verifies installed tool versions at every run — no silent failures |
| 🔄 **Always latest** | Auto-pulls latest templates on every run — no manual update ever needed |
| 📡 **Offline fallback** | No internet? Runs on last downloaded version without crashing |
| 📂 **Download location printed** | Terminal prints exact path where your project is created |
| 🎮 **Full control** | Arrow-key interactive navigation — no typing needed for options |
| 🌿 **Git config support** | Sets up git config without needing any IDE |
| 🚗 **All drivers included** | Chrome, Firefox, Edge — all supported out of the box |
| 💡 **Hints at every step** | Input format hints shown at each prompt — nothing left to guess |

---

## 📦 Install

```bash
curl -fsSL https://raw.githubusercontent.com/rckukaswal/rcmvn/refs/heads/main/cli/setup.sh | bash
source ~/.bashrc
```

The `rcmvn` command is now available globally from anywhere on your system.

> **Requires:** `git`, `bash` — everything else (Java, Maven) is handled automatically.  
> **Supported OS:** Linux, macOS, Windows (Git Bash)

---

## 🚀 Usage

### First time or any time — same command

Navigate to the folder where you want your project created:

```bash
cd ~/projects
rcmvn
```

The CLI walks you through everything with arrow-key navigation:

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
  Input Format Guide:
    Project Name : company-purpose
    Group ID     : domain.company
    Base Package : domain.company.purpose

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

  Project Name : myapp-tests
  Project Dir  : /home/user/projects/myapp-tests
```

> **Project Dir** is printed in the terminal — you always know exactly where your project was created.

---

## 🔄 Auto-Update — Always Latest, Always Safe

Every time you run `rcmvn`, it checks if a newer version is available on GitHub.

**If up to date:**
```
  ✔  Already up to date — 07 May 2025 10:30 AM
```

**If update available — silently pulls latest:**
```
  ✔  Updated — 07 May 2025 10:32 AM
```

**If no internet — falls back gracefully:**
```
  ⚠  No network detected
  ℹ  Running current version
```

No crashes. No broken runs. Whether online or offline — `rcmvn` always works.

---

## ☕ Auto Tool Setup — Java, Maven, Git

`rcmvn` checks for required tools before generating your project. If anything is missing, it offers to install it for you — right from the terminal, no IDE needed.

```
  ⚠  java not found — required to use directly in Git Bash.
  Install now? [Y/n] : Y

  ℹ  Downloading Java 21...
  ✔  Java installed at ~/.devtools/java

  ✔  java found: openjdk 21.0.7 2025-04-15
```

**What gets auto-installed if missing:**

| Tool  | Version | Install Location        |
|-------|---------|-------------------------|
| Java  | 21 (Temurin) | `~/.devtools/java` |
| Maven | 3.9.9   | `~/.devtools/maven`     |
| Git   | Latest via package manager | System |

> PATH is updated automatically in `~/.bashrc` / `~/.bash_profile` — no manual config needed.

---

## 🌿 Git Config — Without an IDE

After project generation, `rcmvn` helps you set up Git for your project — entirely from the terminal.

No IDE required. Useful for CI environments, remote servers, or just preferring the terminal.

```bash
git config --global user.name  "Your Name"
git config --global user.email "you@example.com"
```

`rcmvn` guides you through this step interactively so you don't have to remember the commands.

---

## 🚗 Driver Support — All Browsers, Zero Config

`DriverFactory.java` is generated with full support for all major browsers. WebDriverManager handles driver binaries automatically — no manual `chromedriver` download ever needed.

```java
// Chrome (default)
driver = DriverFactory.getDriver("chrome");

// Firefox
driver = DriverFactory.getDriver("firefox");

// Edge
driver = DriverFactory.getDriver("edge");
```

Switching browsers is one word change. Cross-browser suite XML is also generated automatically.

---

## 🧩 Framework Levels

Choose the level that matches your project's needs. Each level builds on the previous one.

---

### 🟢 Beginner — Clean & Minimal

Best for: Learning Selenium, small projects, quick POCs.

```
pom.xml
  └── Dependencies : Selenium, TestNG
  └── Plugins      : Compiler, Surefire
  └── Java         : 21

src/
  └── DriverFactory.java     — Chrome, Firefox, Edge support
  └── BaseTest.java          — @BeforeMethod / @AfterMethod setup
  └── AppTest.java           — Sample test ready to run
  └── testng.xml             — Ready-to-run suite file
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

Best for: Enterprise projects, parallel execution, full reporting stack.

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

## 🖥️ Platform Support

| Platform                   | Status            |
|----------------------------|-------------------|
| Linux                      | ✅ Full support    |
| macOS                      | ✅ Full support    |
| Windows — Git Bash         | ✅ Full support    |
| Windows — CMD / PowerShell | ❌ Not supported  |

> On Windows, use [Git Bash](https://git-scm.com/downloads) or [WSL](https://learn.microsoft.com/en-us/windows/wsl/install).

---

## 🔧 Reinstall / Reset

To wipe and reinstall the latest version:

```bash
curl -fsSL https://raw.githubusercontent.com/rckukaswal/rcmvn/refs/heads/main/cli/setup.sh | bash
source ~/.bashrc
```

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

Copyright (c) 2026 Ramchandra Kukaswal

This project is licensed under the **GNU Affero General Public License v3.0 (AGPL-3.0)**.

You are free to:

* ✅ Use
* ✅ Modify
* ✅ Distribute

under the terms of the AGPL-3.0 license.

If you modify this software and make it publicly available
(including hosting it as a service), you must also make the
modified source code available under the same license.

See [LICENSE](./LICENSE) for full license terms.

For more details about AGPL:
https://www.gnu.org/licenses/agpl-3.0.en.html

If this project saved you time, consider giving it a ⭐ on GitHub!
