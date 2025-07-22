#!/bin/bash
set -e

# Make all scripts executable
chmod +x build-frontend.sh
chmod +x build-backend.sh
chmod +x build-all.sh
chmod +x push-to-dockerhub.sh
chmod +x run-local.sh
chmod +x test-images.sh
chmod +x verify-images.sh

echo "All scripts are now executable"
echo "To build all images, run: ./build-all.sh"
echo "To run the application with Docker Compose, run: ./run-local.sh"
echo "To push images to Docker Hub, run: ./push-to-dockerhub.sh"