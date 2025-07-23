#!/bin/bash
set -e

# Install Argo CD
echo "Installing Argo CD..."

# Option 1: Using our simplified manifest
kubectl apply -f install.yaml

# Option 2: Using the official manifest (uncomment to use)
# kubectl create namespace argocd
# kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait for Argo CD server to be ready
echo "Waiting for Argo CD server to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/argocd-server -n argocd

# Get the Argo CD server URL
ARGOCD_SERVER=$(kubectl get svc argocd-server -n argocd -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
if [ -z "$ARGOCD_SERVER" ]; then
  ARGOCD_SERVER=$(kubectl get svc argocd-server -n argocd -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
fi

echo "Argo CD server is available at: $ARGOCD_SERVER"
echo "Username: admin"
echo "Password: password (change this immediately!)"

# Instructions for accessing Argo CD
echo ""
echo "To access Argo CD CLI:"
echo "1. Install Argo CD CLI: https://argo-cd.readthedocs.io/en/stable/cli_installation/"
echo "2. Login using: argocd login $ARGOCD_SERVER --username admin --password password"
echo "3. Change the password: argocd account update-password"
echo ""
echo "To access Argo CD UI:"
echo "1. Open http://$ARGOCD_SERVER in your browser"
echo "2. Login with username: admin, password: password"