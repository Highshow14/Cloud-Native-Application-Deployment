#!/bin/bash
set -e

# Deploy Nebulance application using Helm
echo "Deploying Nebulance application using Helm..."

# Check if kubectl is configured
if ! kubectl cluster-info &> /dev/null; then
    echo "Error: kubectl is not configured or cannot connect to the cluster."
    exit 1
fi

# Check if Helm is installed
if ! command -v helm &> /dev/null; then
    echo "Error: Helm is not installed. Please install it first."
    exit 1
fi

# Deploy the Helm chart
echo "Deploying Nebulance Helm chart..."
helm upgrade --install nebulance ./nebulance --namespace default --create-namespace

echo "Nebulance application deployed successfully."
echo ""
echo "To check the status of the deployment:"
echo "kubectl get pods -n default"
echo ""
echo "To access the frontend:"
echo "kubectl get svc -n default frontend"