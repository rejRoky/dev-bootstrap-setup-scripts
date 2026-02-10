# Basic-Shell-Script-File

Setup scripts to quickly configure a fresh development environment on Ubuntu and Windows.

## Scripts

| Script | Platform | Description |
|--------|----------|-------------|
| `init_pack_install_setup.sh` | Ubuntu Desktop | Full desktop dev setup with packages, Python, Node.js, Docker |
| `windows_setup.ps1` | Windows 10/11 | PowerShell script using winget to install dev tools, utilities, media apps, and WSL |
| `wsl_ubuntu_setup.sh` | WSL (Ubuntu) | Dev environment inside WSL, optimized to work alongside Docker Desktop |

## Usage

### Ubuntu Desktop

```bash
chmod +x init_pack_install_setup.sh
sudo ./init_pack_install_setup.sh
```

### Windows

1. Open PowerShell as Administrator:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\windows_setup.ps1
```

2. Reboot, then open Ubuntu in Windows Terminal:

```bash
chmod +x wsl_ubuntu_setup.sh
sudo ./wsl_ubuntu_setup.sh
```

## What Gets Installed

### Ubuntu / WSL

- **System:** build-essential, gcc, g++, make, cmake, git, curl, wget, ssh
- **Utilities:** htop, tree, jq, zip/unzip, nano, vim, net-tools
- **Libraries:** libssl, libffi, libpq, libxml2, zlib, readline, sqlite3
- **Python:** python3, pip, venv, dev headers
- **Node.js:** LTS via NodeSource
- **Docker:** Docker Engine (Ubuntu) / Docker CLI (WSL)
- **Desktop (Ubuntu only):** ubuntu-restricted-extras, VLC, GIMP, GNOME Tweaks

### Windows

- **Dev tools:** Git, GitHub CLI, VS Code, Windows Terminal, Python 3.12, Node.js LTS, Docker Desktop, PowerShell
- **Utilities:** 7-Zip, WinSCP, PuTTY, Notepad++, WinMerge, Everything, PowerToys
- **Media:** VLC, GIMP, Firefox, Chrome

## Requirements

- **Ubuntu:** 20.04+ with sudo access
- **Windows:** Windows 10/11 with winget and admin privileges
