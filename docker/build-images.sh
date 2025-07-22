#!/bin/bash
set -e

# Configuration
DOCKER_USERNAME="highshow14"
FRONTEND_IMAGE="nebulance-frontend"
BACKEND_IMAGE="nebulance-backend"
IMAGE_TAG="1.0.0"
DOCKER_PATH="/usr/local/bin/docker"

echo "Building Docker images using full path: ${DOCKER_PATH}"

# Build frontend image
echo "Building frontend image: ${FRONTEND_IMAGE}:${IMAGE_TAG}"
${DOCKER_PATH} build -t ${FRONTEND_IMAGE}:${IMAGE_TAG} -f ../bootcamp-project-3/frontend/Dockerfile ../bootcamp-project-3/frontend

# Tag frontend for Docker Hub
${DOCKER_PATH} tag ${FRONTEND_IMAGE}:${IMAGE_TAG} ${DOCKER_USERNAME}/${FRONTEND_IMAGE}:${IMAGE_TAG}

echo "Frontend image built successfully: ${DOCKER_USERNAME}/${FRONTEND_IMAGE}:${IMAGE_TAG}"

# Build backend image
echo "Building backend image: ${BACKEND_IMAGE}:${IMAGE_TAG}"
${DOCKER_PATH} build -t ${BACKEND_IMAGE}:${IMAGE_TAG} -f ../bootcamp-project-3/backend/Dockerfile ../bootcamp-project-3/backend

# Tag backend for Docker Hub
${DOCKER_PATH} tag ${BACKEND_IMAGE}:${IMAGE_TAG} ${DOCKER_USERNAME}/${BACKEND_IMAGE}:${IMAGE_TAG}

echo "Backend image built successfully: ${DOCKER_USERNAME}/${BACKEND_IMAGE}:${IMAGE_TAG}"

echo "All images built successfully"
echo "Images tagged as ${DOCKER_USERNAME}/${FRONTEND_IMAGE}:${IMAGE_TAG} and ${DOCKER_USERNAME}/${BACKEND_IMAGE}:${IMAGE_TAG}"
echo "To push images to Docker Hub, run: ${DOCKER_PATH} login && ${DOCKER_PATH} push ${DOCKER_USERNAME}/${FRONTEND_IMAGE}:${IMAGE_TAG} && ${DOCKER_PATH} push ${DOCKER_USERNAME}/${BACKEND_IMAGE}:${IMAGE_TAG}"