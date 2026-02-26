#!/bin/bash
set -e

export DEBIAN_FRONTEND=noninteractive

echo "==> System upgrade"
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

echo "==> Adding repositories"
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo add-apt-repository universe -y
sudo add-apt-repository multiverse -y

echo "==> Installing core dev tools"
sudo apt-get update -y
sudo apt-get install -y \
    build-essential \
    gcc \
    g++ \
    make \
    cmake \
    pkg-config \
    git \
    curl \
    wget \
    ssh \
    ca-certificates \
    gnupg

echo "==> Installing utilities"
sudo apt-get install -y \
    zip \
    unzip \
    tar \
    nano \
    vim \
    htop \
    net-tools \
    tree \
    jq \
    gdebi \
    apt-utils \
    apt-transport-https \
    software-properties-common \
    tmux \
    fzf \
    ripgrep \
    bat \
    fd-find \
    xclip \
    meld \
    dnsutils \
    lsof \
    strace \
    gdb \
    valgrind \
    neofetch

echo "==> Installing GitHub CLI"
if ! command -v gh > /dev/null 2>&1; then
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt-get update -y
    sudo apt-get install -y gh
fi

echo "==> Installing desktop & media tools"
sudo apt-get install -y \
    ubuntu-restricted-extras \
    vlc \
    gimp \
    firefox \
    libreoffice \
    gnome-tweaks \
    gnome-shell-extensions \
    dconf-editor

echo "==> Installing Google Chrome"
if ! command -v google-chrome > /dev/null 2>&1; then
    wget -q -O /tmp/google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo gdebi --non-interactive /tmp/google-chrome.deb
    rm -f /tmp/google-chrome.deb
fi

echo "==> Installing Visual Studio Code"
if ! command -v code > /dev/null 2>&1; then
    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /usr/share/keyrings/microsoft-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
    sudo apt-get update -y
    sudo apt-get install -y code
fi

echo "==> Installing Postman"
if ! command -v postman > /dev/null 2>&1; then
    sudo snap install postman
fi

echo "==> Installing DBeaver (database client)"
if ! command -v dbeaver > /dev/null 2>&1; then
    sudo snap install dbeaver-ce --classic
fi


echo "==> Installing Anaconda"
if [ ! -d "$HOME/anaconda3" ]; then
    ANACONDA_INSTALLER="/tmp/anaconda.sh"
    curl -fsSL https://repo.anaconda.com/archive/Anaconda3-2024.10-1-Linux-x86_64.sh -o "$ANACONDA_INSTALLER"
    bash "$ANACONDA_INSTALLER" -b -p "$HOME/anaconda3"
    rm -f "$ANACONDA_INSTALLER"
    "$HOME/anaconda3/bin/conda" init bash
fi

echo "==> Installing PyCharm"
if ! snap list pycharm-professional > /dev/null 2>&1; then
    sudo snap install pycharm-professional --classic
fi

echo "==> Installing development libraries"
sudo apt-get install -y \
    libpq-dev \
    libssl-dev \
    libffi-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev

echo "==> Installing database clients"
sudo apt-get install -y \
    postgresql-client \
    redis-tools \
    sqlite3

echo "==> Installing Python"
sudo apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    python3-dev

echo "==> Installing Node.js (via NodeSource)"
if ! command -v node > /dev/null 2>&1; then
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt-get install -y nodejs
fi

echo "==> Installing Docker"
if ! command -v docker > /dev/null 2>&1; then
    curl -fsSL https://get.docker.com | sudo sh
    sudo usermod -aG docker "$USER"
fi

echo "==> Cleanup"
sudo apt-get autoremove -y
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*

echo "==> Done! Please reboot for all changes to take effect."
