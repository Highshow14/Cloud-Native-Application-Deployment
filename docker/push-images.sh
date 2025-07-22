#!/bin/bash
set -e

# Configuration
FRONTEND_IMAGE="nebulance-frontend"
BACKEND_IMAGE="nebulance-backend"
IMAGE_TAG="1.0.0"
REGISTRY="your-registry-url" # Replace with your registry URL (e.g., AWS ECR URL)

# Push frontend image
echo "Pushing frontend image to registry: ${REGISTRY}/${FRONTEND_IMAGE}:${IMAGE_TAG}"
docker push ${REGISTRY}/${FRONTEND_IMAGE}:${IMAGE_TAG}

# Push backend image
echo "Pushing backend image to registry: ${REGISTRY}/${BACKEND_IMAGE}:${IMAGE_TAG}"
docker push ${REGISTRY}/${BACKEND_IMAGE}:${IMAGE_TAG}

echo "Images pushed successfully to registry"