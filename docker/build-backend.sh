#!/bin/bash
set -e

# Configuration
DOCKER_USERNAME="highshow14" # Replace with your Docker Hub username
IMAGE_NAME="nebulance-backend"
IMAGE_TAG="1.0.0"

# Build the Docker image
echo "Building backend image: ${IMAGE_NAME}:${IMAGE_TAG}"
/usr/local/bin/docker build -t ${IMAGE_NAME}:${IMAGE_TAG} -f ../bootcamp-project-3/backend/Dockerfile ../bootcamp-project-3/backend

# Tag for Docker Hub
/usr/local/bin/docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${DOCKER_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG}

echo "Backend image built successfully: ${DOCKER_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG}"
echo "To run the container: docker run -p 3000:3000 ${DOCKER_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG}"
echo "To push to Docker Hub: docker push ${DOCKER_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG}"