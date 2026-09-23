# Agent Guidelines for pfsmorigo/dotfiles

This document outlines core principles, operational conventions, and security rules for AI coding agents (such as Antigravity, Copilot, Cursor, etc.) working on this repository.

---

## 🚨 CRITICAL DIRECTIVE: ZERO SENSITIVE INFORMATION LEAKS

> [!CAUTION]
> **THIS IS A PUBLIC OPEN-SOURCE REPOSITORY.**
> Never commit, stage, log, or hardcode any private or sensitive information. Once pushed, git history is public and permanent.

### 1. Prohibited Items
Under no circumstances should any of the following be added to tracked files:
- **API Keys & Authentication Tokens**: OpenRouter, OpenAI, Home Assistant, Healthchecks, Telegram, GitHub, AWS, Launchpad, etc.
- **Private Keys & Certificates**: SSH keys (`id_rsa`, `id_ed25519`, `id_*.pub` with private counterparts), SSL/TLS keys (`*.pem`, `*.key`), GPG private keys (`*.gpg`).
- **Passwords & Hashes**: Hardcoded plaintext passwords, PINs, or hash values.
- **Secret Stores**: Password store databases (`~/.password-store`), GnuPG keyrings, `.netrc`, `.env` files, browser/app cookies (`git/cookies`).
- **Internal / Confidential Data**: Sensitive personal identifiable information (PII), proprietary internal URLs/IPs not intended for public disclosure, private email credentials.

### 2. Required Secret Handling Patterns
If a configuration requires credentials, always use one of the following approaches:
- **Runtime Secret Evaluation via Password Manager**:
  Use `pass` or command substitution at runtime (e.g. `$(pass openrouter/api)` or `$(pass homeassistant/api)`, as demonstrated in `snakedeck/main.yaml`).
- **Environment Variables**:
  Read credentials from environment variables populated securely outside git tracking.
- **Untracked Local Overrides (`.gitignore`)**:
  Place host-specific or private configurations in gitignored local override files (e.g., `git/.config/git/local` or `~/.config/bash/local.sh`).

### 3. Agent Verification Checklist Before Any Commit
Before staging or committing any changes, agents **MUST**:
1. Run `git status` to verify no untracked private files or directories (e.g., keys, tokens, session caches) are present.
2. Run `git diff` or `git diff --staged` and review line by line for accidental credential leaks.
3. Check that newly added packages or files do not store runtime state, caches, cookies, or credentials.
4. Ensure `.gitignore` is updated if new tools produce local state, history, or cache files.

---

## Repository Architecture & GNU Stow Conventions

### 1. Modular GNU Stow Structure
- Every top-level directory (except repository-level metadata like `.git`, `README.md`, `AGENTS.md`, `LICENSE`) is a **GNU Stow package**.
- The internal structure of each package mirrors the target filesystem layout relative to the user's `$HOME`:
  - `package/.config/app/config` -> symlinked to `~/.config/app/config`
  - `package/.bashrc` -> symlinked to `~/.bashrc`
  - `package/.vim/` -> symlinked to `~/.vim/`
- System-level packages that target root (`/`) or `/etc/` should either:
  - Provide a `Makefile` with a `sudo make install` target (e.g., `firewalld`, `NetworkManager`, `lxdm`), OR
  - Clearly document deployment via `sudo stow -t / <package>` (e.g., `apt-mirror`, `bluetooth`).

### 2. XDG Base Directory Specification
- Respect and maintain XDG compliance wherever feasible:
  - User configuration: `~/.config/`
  - Cache files: `~/.cache/`
  - Data files & state: `~/.local/share/` and `~/.local/state/`
- Do not introduce dotfiles directly into the root of `$HOME` unless mandatory for legacy tools.

### 3. Clean State & Ephemeral Files
Never commit:
- Editor swap files (`*.swp`, `*.swo`) or session histories (`.netrwhist`, `viminfo`).
- Package manager clones or build gadgets (`vim/.vim/plugged/`, Neovim `lazy/` clones).
- Shell history files (`.bash_history`, `fish_history`).
- Binary blobs, caches, or runtime sockets.

---

## Configuration & Tooling Guidelines

### 1. Shells (`fish`, `bash`)
- **Fish**: Maintained under `fish/.config/fish/`. Plugins are managed via [Fisher](https://github.com/jorgebucaran/fisher) (`fish_plugins`). Custom functions live in `functions/`.
- **Bash**: Maintained under `bash/`. Enforces XDG environment variables, auto-discovers SSH agent sockets, and exports aliases to `~/.bash_aliases` for Fish interoperability. Local scripts should be sourced dynamically from `~/.config/bash/`.

### 2. Editors (`nvim`, `vim`)
- **Neovim (`nvim/`)**: Configured exclusively in Lua (`nvim/.config/nvim/init.lua`) with `lazy.nvim` as plugin manager.
- **Classic Vim (`vim/`)**: Configured in Vimscript (`vim/.vim/vimrc`) with `vim-plug`. Templates are kept in `vim/.vim/templates/` and custom syntax files in `vim/.vim/syntax/`.
- Keep Neovim and classic Vim configurations distinct and independent.

### 3. Desktop Environments
- **Wayland / Hyprland (`hypr`, `waybar`, `rofi`)**:
  - Keep `hypr/.config/hypr/hyprland.conf` syntactically valid and modular.
  - Keep `waybar/.config/waybar/config.jsonc` valid JSONC with comments.
- **X11 / i3 (`i3`, `x11`, `gtk`)**:
  - Maintain workspace naming conventions and emoji markers.
  - Per-host i3blocks configurations live under `i3/.config/i3blocks/config-<hostname>` (`reno`, `oslo`, `pisa`, `rome`).

### 4. Hardware & Stream Deck (`snakedeck`)
- Snakedeck configurations live in `snakedeck/.config/snakedeck/*.yaml`.
- All Home Assistant, Healthchecks, or API keys must use dynamic lookup (`$(pass ...)`), never raw tokens.

---

## Documentation Integrity

- When adding, renaming, or removing a package, always update [README.md](README.md) to reflect the new module in the catalog.
- If introducing local override mechanisms, document them under the **Customization & Host-Specific Overrides** section in [README.md](README.md).
