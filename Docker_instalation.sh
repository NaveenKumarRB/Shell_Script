#!/bin/bash

set -e

echo "🔍 Detecting OS..."

if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "❌ Cannot detect OS. Exiting."
    exit 1
fi

echo "📦 Installing Docker on $OS..."

case "$OS" in
    ubuntu|debian)
        sudo apt-get update
        sudo apt-get install -y ca-certificates curl gnupg lsb-release
        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/$OS/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        echo \
          "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$OS \
          $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt-get update
        sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
        ;;

    centos|rhel)
        sudo yum install -y yum-utils
        sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
        sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
        sudo systemctl start docker
        sudo systemctl enable docker
        ;;

    fedora)
        sudo dnf -y install dnf-plugins-core
        sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
        sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
        sudo systemctl start docker
        sudo systemctl enable docker
        ;;

    arch)
        sudo pacman -Sy --noconfirm docker
        sudo systemctl start docker
        sudo systemctl enable docker
        ;;

    amzn)
        sudo yum update -y
        sudo amazon-linux-extras enable docker
        sudo yum install -y docker
        sudo systemctl start docker
        sudo systemctl enable docker
        ;;

    *)
        echo "❌ Unsupported OS: $OS"
        exit 1
        ;;
esac

echo "✅ Docker installation complete!"
docker --version
