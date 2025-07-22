#!/bin/bash
set -e

# Configuration
DOCKER_USERNAME="highshow14" # Replace with your Docker Hub username
FRONTEND_IMAGE="nebulance-frontend"
BACKEND_IMAGE="nebulance-backend"
IMAGE_TAG="1.0.0"

# Login to Docker Hub (will prompt for password)
echo "Logging in to Docker Hub as ${DOCKER_USERNAME}"
/usr/local/bin/docker login -u ${DOCKER_USERNAME}

# Push frontend image
echo "Pushing frontend image to Docker Hub: ${DOCKER_USERNAME}/${FRONTEND_IMAGE}:${IMAGE_TAG}"
/usr/local/bin/docker push ${DOCKER_USERNAME}/${FRONTEND_IMAGE}:${IMAGE_TAG}

# Push backend image
echo "Pushing backend image to Docker Hub: ${DOCKER_USERNAME}/${BACKEND_IMAGE}:${IMAGE_TAG}"
/usr/local/bin/docker push ${DOCKER_USERNAME}/${BACKEND_IMAGE}:${IMAGE_TAG}

echo "Images pushed successfully to Docker Hub"
echo "Frontend: ${DOCKER_USERNAME}/${FRONTEND_IMAGE}:${IMAGE_TAG}"
echo "Backend: ${DOCKER_USERNAME}/${BACKEND_IMAGE}:${IMAGE_TAG}"