# Task 5: CI/CD Pipeline with CircleCI

This directory contains the CI/CD pipeline configuration for the Nebulance application using CircleCI.

## Overview

The CI/CD pipeline automates the following processes:

1. **Testing**: Runs automated tests for both frontend and backend
2. **Building**: Builds Docker images for frontend and backend
3. **Deployment**: Deploys the application to different environments (dev and prod)

## Directory Structure

```
.
├── .circleci/
│   └── config.yml             # CircleCI configuration file
├── environments/
│   ├── dev/
│   │   └── values.yaml        # Development environment values
│   └── prod/
│       └── values.yaml        # Production environment values
└── scripts/
    └── deploy.sh              # Deployment script
```

## CI/CD Pipeline

The CI/CD pipeline consists of the following jobs:

1. **test-frontend**: Runs automated tests for the frontend
2. **test-backend**: Runs automated tests for the backend
3. **build-and-push-images**: Builds and pushes Docker images to Docker Hub
4. **deploy-to-dev**: Deploys the application to the development environment
5. **approve-prod-deployment**: Manual approval step for production deployment
6. **deploy-to-prod**: Deploys the application to the production environment

## CircleCI Contexts

The following contexts need to be configured in CircleCI:

- **docker-hub-creds**: Contains Docker Hub credentials
  - `DOCKER_USERNAME`: Docker Hub username
  - `DOCKER_PASSWORD`: Docker Hub password

- **aws-dev**: Contains AWS credentials for development environment
  - `AWS_ACCESS_KEY_ID`: AWS access key ID
  - `AWS_SECRET_ACCESS_KEY`: AWS secret access key
  - `AWS_REGION`: AWS region (e.g., eu-central-1)

- **aws-prod**: Contains AWS credentials for production environment
  - `AWS_ACCESS_KEY_ID`: AWS access key ID
  - `AWS_SECRET_ACCESS_KEY`: AWS secret access key
  - `AWS_REGION`: AWS region (e.g., eu-central-1)

## Environment-Specific Configurations

The application can be deployed to different environments with different configurations:

- **Development**: Minimal resources, no autoscaling
- **Production**: Higher resources, autoscaling enabled

## Manual Deployment

To manually deploy the application, use the `deploy.sh` script:

```bash
# Deploy to development environment
./scripts/deploy.sh --environment dev --tag latest

# Deploy to production environment
./scripts/deploy.sh --environment prod --tag latest
```

## Workflow

1. Code is pushed to the GitHub repository
2. CircleCI automatically triggers the workflow
3. Tests are run for both frontend and backend
4. If tests pass, Docker images are built and pushed to Docker Hub
5. If the branch is `develop` or `main`, the application is deployed to the development environment
6. If the branch is `main`, a manual approval step is required for production deployment
7. After approval, the application is deployed to the production environment