#!/bin/bash
set -e

# Apply External Secrets configuration
echo "Applying External Secrets configuration..."

# Check if kubectl is installed
if ! command -v kubectl &> /dev/null; then
    echo "Error: kubectl is not installed. Please install it first."
    exit 1
fi

# Check if the IAM role ARN is provided
if [ -z "$1" ]; then
    echo "Error: IAM role ARN not provided."
    echo "Usage: $0 <IAM_ROLE_ARN>"
    exit 1
fi

# Replace the IAM role ARN in the YAML file
ROLE_ARN=$1
sed "s|\${ROLE_ARN}|$ROLE_ARN|g" external-secrets-operator.yaml > external-secrets-operator-updated.yaml

# Apply the configuration
echo "Applying External Secrets configuration..."
kubectl apply -f external-secrets-operator-updated.yaml

echo "External Secrets configuration applied successfully."
echo ""
echo "To verify the External Secrets are working:"
echo "kubectl get externalsecrets -n default"
echo "kubectl get secrets -n default"