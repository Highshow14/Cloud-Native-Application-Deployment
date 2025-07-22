#!/bin/bash
set -e

echo "Installing prerequisites for Task 3..."

# Check if Homebrew is installed (for macOS)
if command -v brew &> /dev/null; then
    echo "Installing AWS CLI, kubectl, and Helm using Homebrew..."
    brew install awscli kubectl helm
    exit 0
fi

# For Linux systems
echo "Installing AWS CLI..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

echo "Installing Helm..."
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

echo "Prerequisites installed successfully."