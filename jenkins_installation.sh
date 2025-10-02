#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

echo "Updating package list..."
sudo apt update

echo "Installing required packages..."
sudo apt install -y fontconfig openjdk-21-jre

echo "Adding Jenkins key and repository..."
sudo mkdir -p /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | \
  sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "Updating package list with Jenkins repo..."
sudo apt update

echo "Installing Jenkins..."
sudo apt install -y jenkins

echo "Starting and enabling Jenkins service..."
sudo systemctl start jenkins
sudo systemctl enable jenkins

echo "Upgrading system packages..."
sudo apt upgrade -y

echo "Checking Jenkins status..."
sudo systemctl status jenkins --no-pager

echo "Allowing Jenkins port through firewall..."
sudo ufw allow 8080

echo "✅ Jenkins installation and setup complete!"
