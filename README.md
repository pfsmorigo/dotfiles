# pfsmorigo's Dotfiles

Personal dotfiles and configuration ecosystem for Linux workstations, curated and maintained by [Paulo Flabiano Smorigo](https://github.com/pfsmorigo).

This repository organizes configuration files into modular packages managed with [GNU Stow](https://www.gnu.org/software/stow/). It enables consistent, reproducible environments across physical and virtual machines, covering modern Wayland compositors, X11 tiling window managers, terminal environments, Neovim/Vim setups, systemd user services, and hardware integrations (such as Elgato Stream Deck with Home Assistant).

---

## Table of Contents

- [Overview & Philosophy](#overview--philosophy)
- [Prerequisites](#prerequisites)
- [Installation & Usage](#installation--usage)
  - [1. Clone Repository](#1-clone-repository)
  - [2. Deploying User Configurations with GNU Stow](#2-deploying-user-configurations-with-gnu-stow)
  - [3. Deploying System Configurations](#3-deploying-system-configurations)
  - [4. Managing Changes (Restow / Unstow)](#4-managing-changes-restow--unstow)
- [Module Catalog](#module-catalog)
  - [Desktop & Window Management](#desktop--window-management)
  - [Shells & Terminal Emulators](#shells--terminal-emulators)
  - [Editors & Development](#editors--development)
  - [Hardware & Smart Home Integrations](#hardware--smart-home-integrations)
  - [Productivity & Utilities](#productivity--utilities)
  - [System Services & Daemons](#system-services--daemons)
- [Customization & Host-Specific Overrides](#customization--host-specific-overrides)
- [AI Agent Guidelines](#ai-agent-guidelines)
- [License](#license)

---

## Overview & Philosophy

- **Modular Packages**: Every application or domain has its own directory tree designed to be stowed independently. You only install what you need on any given system.
- **XDG Base Directory Compliance**: Configs and shell startup scripts enforce clean `$HOME` hygiene by directing caches, histories, and data files to standard XDG directories (`~/.config`, `~/.cache`, `~/.local/share`).
- **Dual Desktop Paradigms**: Complete configurations for both modern Wayland ([Hyprland](https://hyprland.org/) + [Waybar](https://github.com/Alexays/Waybar)) and battle-tested X11 ([i3](https://i3wm.org/) + [i3blocks](https://github.com/vivien/i3blocks)).
- **Hardware Integration**: Includes home automation dashboards, 3D printer monitoring, and hardware triggers tailored for Stream Deck via Snakedeck.

---

## Prerequisites

- **Git**
- **GNU Stow** (version 2.x+)
- Target tools depending on which packages you deploy (`fish`, `nvim`, `tmux`, `kitty`, `hyprland`, `i3`, etc.)

On Debian/Ubuntu-based distributions:

```bash
sudo apt update
sudo apt install git stow
```

---

## Installation & Usage

### 1. Clone Repository

Clone the repository to your `$HOME` directory (the default Stow target assumes `~/dotfiles`):

```bash
git clone https://github.com/pfsmorigo/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Deploying User Configurations with GNU Stow

GNU Stow creates relative symlinks from the package folder into the target directory (defaulting to the parent directory, `$HOME`):

```bash
cd ~/dotfiles

# Core Shell & CLI
stow bash
stow fish
stow git
stow tmux
stow kitty

# Editors
stow nvim      # Modern Neovim (lazy.nvim, Lua)
# OR
stow vim       # Classic Vim (vim-plug, templates, custom syntax)

# Wayland Desktop
stow hypr      # Hyprland compositor
stow waybar    # Waybar status bar
stow rofi      # App launcher & menus

# X11 Desktop (Alternative)
stow i3        # i3 window manager & i3blocks
stow x11       # .Xresources & .XCompose
stow gtk       # GTK 2/3 settings

# Productivity & Hardware
stow snakedeck # Stream Deck configuration
stow taskwarrior
stow enchant   # Custom dictionaries
```

### 3. Deploying System Configurations

Some packages target system-wide paths (`/etc/` or `/usr/share/`) and include Makefiles or need elevated permissions:

- **Firewall Rules (`firewalld`)**:
  ```bash
  cd ~/dotfiles/firewalld
  sudo make install
  sudo firewall-cmd --reload
  ```
  *(Installs custom service definitions for Mosh, Minecraft, Leapcast, Garry's Mod).*

- **NetworkManager Dispatcher (`NetworkManager`)**:
  ```bash
  cd ~/dotfiles/NetworkManager
  sudo make install
  ```
  *(Installs VPN connection trigger script in `/etc/NetworkManager/dispatcher.d/`).*

- **LXDM Greeter Theme (`lxdm`)**:
  ```bash
  cd ~/dotfiles/lxdm
  sudo make install
  ```
  *(Installs the custom `LinuxLogo` theme and `lxdm.conf`).*

- **System-level Stow Packages (e.g. `apt-mirror`, `bluetooth`)**:
  ```bash
  sudo stow -t / apt-mirror
  sudo stow -t / bluetooth
  ```

### 4. Managing Changes (Restow / Unstow)

- **Re-link / Update symlinks after adding new files**:
  ```bash
  stow -R <package-name>
  ```
- **Remove symlinks**:
  ```bash
  stow -D <package-name>
  ```

---

## Module Catalog

### Desktop & Window Management

| Package | Description | Target Paths |
| :--- | :--- | :--- |
| **`hypr`** | [Hyprland](https://hyprland.org/) dynamic tiling Wayland compositor setup with window rules, multi-monitor configuration, and keybindings. | `~/.config/hypr/hyprland.conf` |
| **`waybar`** | Custom Wayland status bar featuring workspaces, CPU load, network status, Bluetooth/PulseAudio audio controls, and system tray. | `~/.config/waybar/config.jsonc` |
| **`i3`** | [i3-gaps/i3wm](https://i3wm.org/) tiling window manager configuration with emoji workspace identifiers, Yaru orange/purple accents, and hostname-tailored `i3blocks` status bars (`reno`, `oslo`, `pisa`, `rome`). | `~/.config/i3/`, `~/.config/i3blocks/` |
| **`rofi`** | Application launcher, window switcher, and SSH target launcher. | `~/.config/rofi/config.rasi` |
| **`kitty`** | GPU-accelerated terminal emulator configuration with custom fonts, keybindings, and scrollback settings. | `~/.config/kitty/kitty.conf` |
| **`gtk`** | GTK 2.0 and GTK 3.0 theme configurations, Vi key themes, and widget styling. | `~/.config/gtk-3.0/`, `~/.gtkrc-2.0` |
| **`x11`** | X11 resources configuration (`.Xresources`) and custom Compose key combinations (`.XCompose`). | `~/.Xresources`, `~/.XCompose` |
| **`xdg`** | Standard XDG user directory mappings and locales. | `~/.config/user-dirs.*` |
| **`xfce`** | GTK 3.0 custom CSS overrides for XFCE desktop components. | `~/.config/gtk-3.0/gtk.css` |
| **`lxdm`** | LXDM display manager configuration and custom `LinuxLogo` greeter theme. | `/etc/lxdm/`, `/usr/share/lxdm/` |

### Shells & Terminal Emulators

| Package | Description | Target Paths |
| :--- | :--- | :--- |
| **`fish`** | Primary interactive shell environment powered by [Fisher](https://github.com/jorgebucaran/fisher), the `bobthefish` prompt theme, git helper aliases, and kitty image protocol integration (`icat`). | `~/.config/fish/` |
| **`bash`** | Interactive and fallback shell with strict XDG Base Directory variable exports, SSH agent socket discovery, quilt aliases, and automatic alias synchronization to `~/.bash_aliases`. | `~/.bashrc`, `~/.bash_profile`, `~/.inputrc` |
| **`tmux`** | Terminal multiplexer configuration supporting true-color (24-bit), Powerline symbols, and status bar styling. | `~/.config/tmux/tmux.conf` |
| **`screen`** | GNU Screen multiplexer configuration. | `~/.config/screenrc` |
| **`ranger`** | Console file manager keybindings and previews. | `~/.config/ranger/rc.conf` |
| **`tig`** | Text-mode interface for Git. | `~/.tigrc` |

### Editors & Development

| Package | Description | Target Paths |
| :--- | :--- | :--- |
| **`nvim`** | Modern [Neovim](https://neovim.io/) configuration in Lua using [lazy.nvim](https://github.com/folke/lazy.nvim). Configured with Gruvbox, Treesitter, Telescope, Lualine, Gitsigns, Vimwiki (Obsidian vault integration), Ledger, and Vimspector debugging. | `~/.config/nvim/init.lua` |
| **`vim`** | Classic Vim setup featuring [vim-plug](https://github.com/junegunn/vim-plug), code skeleton templates (`skeleton.c`, `skeleton.py`, `skeleton.scad`), spell dictionaries, and specialized syntax files (AppArmor, CVEs, Jinja, Nginx). | `~/.vim/`, `~/.vimrc` |
| **`git`** | Git configuration with curated shortcuts (`st`, `ci`, `br`, `co`, `lg`, `lola`, `vanish`), whitespace normalization, and Launchpad SSH rewrite rules. | `~/.config/git/config`, `~/.config/git/ignore` |
| **`gdb`** | Custom GDB initialization and Python debugging scripts for cryptographic algorithms (Go crypto, AES, ChaCha, Elliptic curves, OpenSSL EVP) and PowerPC architectures. | `~/.gdbinit`, `~/.config/gdb/` |
| **`ansible`** | Ansible configuration file. | `~/.config/ansible.cfg` |

### Hardware & Smart Home Integrations

| Package | Description | Target Paths |
| :--- | :--- | :--- |
| **`snakedeck`** | Multi-page configuration for [Snakedeck](https://github.com/pfsmorigo/snakedeck) (Stream Deck controller). Controls Home Assistant smart lights and climate, Zigbee2MQTT, Creality K1 Max 3D printer status, TrueNAS Glances, Nvidia GPU metrics, and live ADS-B flight alerts for cargo and oversized aircraft (Antonov An-124, BelugaXL, A380, Boeing 747s). | `~/.config/snakedeck/` |
| **`cura`** | Slicing engine profiles and configuration files for Ultimaker Cura (versions 3.1 through 4.3). | `~/.config/cura/` |

### Productivity & Utilities

| Package | Description | Target Paths |
| :--- | :--- | :--- |
| **`taskwarrior`** | CLI task management configuration and data paths. | `~/.config/task` |
| **`enchant`** | Multilingual custom spelling dictionaries and exclusion lists (`en`, `en_US`, `pt_BR`). | `~/.config/enchant/` |
| **`newsbeuter`** | Text-mode RSS/Atom feed reader configuration. | `~/.config/newsbeuter/config` |
| **`muttator`** | Mutt-like keybindings and behavior for Thunderbird via Muttator. | `~/.muttatorrc` |
| **`weechat`** | WeeChat IRC client configuration. | `~/.config/weechat/` |
| **`synergy`** | Synergy KVM client/server configuration for sharing mouse and keyboard across hosts. | `~/.config/synergy.conf` |

### System Services & Daemons

| Package | Description | Target Paths |
| :--- | :--- | :--- |
| **`ssh-agent`** | Systemd user service unit for managing `ssh-agent`. | `~/.config/systemd/user/ssh-agent.service` |
| **`offlineimap`** | Systemd user service for background IMAP synchronization. | `~/.config/systemd/user/offlineimap.service` |
| **`secure-tunner`** | Parameterized systemd user service for persistent SSH tunnels (`secure-tunnel@.service`). | `~/.config/systemd/user/secure-tunnel@.service` |
| **`deckmaster`** | Systemd user service and path units for Stream Deck daemons. | `~/.config/systemd/user/streamdeck.*` |
| **`firewalld`** | Custom firewalld XML service definitions (Mosh, Minecraft, Leapcast, Garry's Mod) with Makefile. | `/etc/firewalld/services/` |
| **`NetworkManager`** | NetworkManager dispatcher scripts with Makefile installer. | `/etc/NetworkManager/dispatcher.d/` |
| **`lsyncd`** | Live syncing daemon configuration for virtual machine storage. | `lsyncd/sid-vms.conf` |
| **`bluetooth`** | Udev rules for Bluetooth subsystem handling. | `/etc/udev/rules.d/` |
| **`apt-mirror`** | Configuration for local APT repository mirroring. | `/etc/apt/mirror.list` |

---

## Customization & Host-Specific Overrides

- **Git Local Includes**:
  `git/.config/git/config` automatically includes a local file named `local` if present:
  ```gitconfig
  [include]
      path = local
  ```
  Create `~/.config/git/local` on a given machine to set machine-specific identities (name, work email, signing keys) without polluting the tracked repository.

- **Per-Host i3blocks**:
  The `i3` package includes dedicated status configurations for different machines (e.g. `config-oslo`, `config-pisa`, `config-reno`, `config-rome`). The main `i3` config links or references the appropriate bar configuration according to the host system.

- **Bash Local Extensions**:
  `bash/.bashrc` automatically sources any files found under `~/.config/bash/` or `~/.bash_ubuntusec`:
  ```bash
  for FILE in $(find ~/.config/bash/ -type f,l) ~/.bash_ubuntusec; do
      test -f "$FILE" && source "$FILE"
  done
  ```

---

## AI Agent Guidelines

If using AI coding agents or assistants in this repository, please review [AGENTS.md](AGENTS.md) for required operational patterns and strict security directives against committing sensitive data to this public repository.

---

## License

This project is licensed under the **GNU General Public License v2.0 (GPL-2.0)** - see the [LICENSE](LICENSE) file for details.
