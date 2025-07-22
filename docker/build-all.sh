#!/bin/bash
set -e

# Build both frontend and backend images
echo "Building all Docker images..."

# Build frontend
bash build-frontend.sh

echo ""

# Build backend
bash build-backend.sh

echo ""
echo "All images built successfully"
echo "Images tagged as highshow14/nebulance-frontend:1.0.0 and highshow14/nebulance-backend:1.0.0"
echo "To run the application with Docker Compose, run: ./run-local.sh"
echo "To push images to Docker Hub, run: ./push-to-dockerhub.sh"