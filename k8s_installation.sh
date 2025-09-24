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

echo "📦 Installing Kubernetes on $OS..."

case "$OS" in
    ubuntu|debian)
        sudo apt-get update
        sudo apt-get install -y apt-transport-https ca-certificates curl
        sudo curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
        echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
        sudo apt-get update
        sudo apt-get install -y kubelet kubeadm kubectl
        sudo apt-mark hold kubelet kubeadm kubectl
        ;;

    centos|rhel)
        cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
        sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
        sudo systemctl enable --now kubelet
        ;;

    fedora)
        sudo dnf install -y kubelet kubeadm kubectl
        sudo systemctl enable --now kubelet
        ;;

    amzn)
        sudo cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
        sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
        sudo systemctl enable --now kubelet
        ;;

    arch)
        sudo pacman -Sy --noconfirm kubelet kubeadm kubectl
        sudo systemctl enable --now kubelet
        ;;

    *)
        echo "❌ Unsupported OS: $OS"
        exit 1
        ;;
esac

echo "✅ Kubernetes components installed!"
kubeadm version
kubectl version --client
