#!/bin/bash
set -e

# Install External Secrets Operator using Helm
echo "Installing External Secrets Operator using Helm..."

# Check if Helm is installed
if ! command -v helm &> /dev/null; then
    echo "Error: Helm is not installed. Please install it first."
    exit 1
fi

# Check if kubectl is installed
if ! command -v kubectl &> /dev/null; then
    echo "Error: kubectl is not installed. Please install it first."
    exit 1
fi

# Add External Secrets Operator Helm repository
echo "Adding External Secrets Operator Helm repository..."
helm repo add external-secrets https://charts.external-secrets.io

# Update Helm repositories
echo "Updating Helm repositories..."
helm repo update

# Create namespace for External Secrets Operator
echo "Creating namespace for External Secrets Operator..."
kubectl create namespace external-secrets --dry-run=client -o yaml | kubectl apply -f -

# Install External Secrets Operator
echo "Installing External Secrets Operator..."
helm install external-secrets \
  external-secrets/external-secrets \
  --namespace external-secrets \
  --set installCRDs=true \
  --set webhook.port=9443

echo "External Secrets Operator installed successfully."
echo ""
echo "Next steps:"
echo "1. Update external-secrets-operator.yaml with the correct IAM role ARN"
echo "2. Apply the External Secrets configuration: kubectl apply -f external-secrets-operator.yaml"