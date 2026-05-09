# Contributing to rcmvn

Thank you for your interest in contributing to **rcmvn** — a CLI tool that scaffolds production-ready Maven automation frameworks in seconds.

---

## Before You Start

- Check [existing issues](https://github.com/rckukaswal/rcmvn/issues) — your idea or bug might already be reported
- For big changes, open an issue first and discuss before writing code
- All contributions go to the `develop` branch — **never open a PR against `main`**

---

## How to Contribute

### 1. Fork the repo

```bash
git clone https://github.com/rckukaswal/rcmvn.git
cd rcmvn
```

### 2. Create your branch from `develop`

```bash
git checkout develop
git checkout -b feature/your-feature-name
```

Branch naming:
- New feature → `feature/short-description`
- Bug fix → `fix/short-description`
- Docs → `docs/short-description`

### 3. Make your changes

- Keep changes focused — one feature or fix per PR
- Test your changes on Linux, macOS, and Windows (Git Bash) if possible
- Follow the existing code style in shell scripts

### 4. Commit with a clear message

```bash
git commit -m "feat: add support for XYZ"
git commit -m "fix: correct Java version in beginner config"
git commit -m "docs: update install instructions"
```

Commit message format:
- `feat:` — new feature
- `fix:` — bug fix
- `docs:` — documentation only
- `chore:` — cleanup, refactor, no logic change

### 5. Push and open a Pull Request

```bash
git push origin feature/your-feature-name
```

Open PR against `develop` branch — not `main`.

---

## What to Contribute

Looking for ideas? Check issues labeled:

- `good first issue` — beginner friendly
- `help wanted` — needs attention
- `enhancement` — feature requests

---

## Code Style

- Shell scripts use `#!/bin/bash`
- Use existing logger functions — `log_info`, `log_success`, `log_warning`, `log_error`
- Keep functions small and focused
- Add comments for non-obvious logic

---

## Reporting Bugs

Use the [bug report template](https://github.com/rckukaswal/rcmvn/issues/new?template=bug_report.md) — it helps resolve issues faster.

---

## License

By contributing, you agree that your contributions will be licensed under the [GNU AGPL v3.0](./LICENSE).

---

**Author:** Ramchandra Kukaswal — [@rckukaswal](https://github.com/rckukaswal)
