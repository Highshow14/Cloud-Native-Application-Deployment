#!/bin/bash
set -e

# Configuration
DOCKER_USERNAME="highshow14"
FRONTEND_IMAGE="nebulance-frontend"
BACKEND_IMAGE="nebulance-backend"
IMAGE_TAG="1.0.0"

echo "Verifying Docker images..."

# Check if images exist locally
echo "Checking local images:"
/usr/local/bin/docker images | grep ${FRONTEND_IMAGE} || echo "❌ Frontend image not found locally"
/usr/local/bin/docker images | grep ${BACKEND_IMAGE} || echo "❌ Backend image not found locally"

echo ""
echo "Checking Docker Hub tagged images:"
/usr/local/bin/docker images | grep ${DOCKER_USERNAME}/${FRONTEND_IMAGE} || echo "❌ Frontend image not tagged for Docker Hub"
/usr/local/bin/docker images | grep ${DOCKER_USERNAME}/${BACKEND_IMAGE} || echo "❌ Backend image not tagged for Docker Hub"

echo ""
echo "To build images: ./build-all.sh"
echo "To push images to Docker Hub: ./push-to-dockerhub.sh"