#!/bin/bash
set -e

# Apply Argo CD Application manifests
echo "Applying Argo CD Application manifests..."

kubectl apply -f frontend.yaml
kubectl apply -f backend.yaml
kubectl apply -f database.yaml

echo "Applications created successfully!"
echo "Check the Argo CD UI to see the applications syncing."