# Task 2: Container Engineering

This directory contains all the necessary files for Task 2 of the Nebulance EKS project, which focuses on containerizing the application.

## Requirements Fulfilled

1. **Production-ready Docker images**:
   - Frontend image: `nebulance-frontend:1.0.0`
   - Backend image: `nebulance-backend:1.0.0`
   - Database: Using official `postgres:15-alpine` image

2. **Security best practices**:
   - Non-root users for both frontend and backend
   - Minimal base images (alpine variants)
   - Proper file permissions
   - Security headers in nginx configuration

3. **Health checks**:
   - Frontend: HTTP check on port 8080
   - Backend: Dedicated /health endpoint
   - Database: pg_isready command

4. **Proper startup sequences**:
   - Dependencies properly configured in docker-compose
   - Wait periods for service initialization

5. **Image tagging**:
   - All images tagged as version 1.0.0

## Files Created

1. **Build Scripts**:
   - `build-frontend.sh`: Builds the frontend Docker image
   - `build-backend.sh`: Builds the backend Docker image
   - `build-all.sh`: Builds both images at once
   - `setup.sh`: Makes all scripts executable

2. **Runtime Configuration**:
   - `docker-compose.yml`: Defines the complete application stack
   - `.env.sample`: Sample environment variables
   - `run-local.sh`: Script to run the application locally

3. **Testing**:
   - `test-images.sh`: Tests the Docker images by running health checks

## How to Use

1. Make the scripts executable:
   ```
   ./setup.sh
   ```

2. Build the Docker images:
   ```
   ./build-all.sh
   ```

3. Test the images:
   ```
   ./test-images.sh
   ```

4. Run the application locally:
   ```
   ./run-local.sh
   ```

## Container Registry

For this project, we're using Docker Hub as our container registry. The workflow is:

1. Build the images locally
2. Tag the images with your Docker Hub username
3. Push the images to Docker Hub
4. Configure Kubernetes to pull from Docker Hub

Before using the scripts:

1. All scripts are configured with Docker Hub username `highshow14`
2. Make sure you're logged in to Docker Hub (`docker login`)

The push-to-dockerhub.sh script will handle pushing the images to Docker Hub.

These Docker Hub images will be referenced in Task 4 when we create the Helm charts for deployment.