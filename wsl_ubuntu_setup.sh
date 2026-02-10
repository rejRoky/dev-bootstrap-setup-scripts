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
    apt-utils \
    apt-transport-https

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

echo "==> Installing Docker (CLI only, uses Docker Desktop from Windows)"
if ! command -v docker > /dev/null 2>&1; then
    curl -fsSL https://get.docker.com | sudo sh
    sudo usermod -aG docker "$USER"
fi

echo "==> Cleanup"
sudo apt-get autoremove -y
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*

echo "==> Done! WSL Ubuntu dev environment is ready."
