#!/bin/bash
set -e

# Configuration
REGION="eu-central-1"
FRONTEND_REPO="nebulance-frontend"
BACKEND_REPO="nebulance-backend"

# Create ECR repositories if they don't exist
echo "Creating ECR repositories in region ${REGION}"

# Create frontend repository
aws ecr describe-repositories --repository-names ${FRONTEND_REPO} --region ${REGION} > /dev/null 2>&1 || \
    aws ecr create-repository --repository-name ${FRONTEND_REPO} --region ${REGION}

# Create backend repository
aws ecr describe-repositories --repository-names ${BACKEND_REPO} --region ${REGION} > /dev/null 2>&1 || \
    aws ecr create-repository --repository-name ${BACKEND_REPO} --region ${REGION}

# Get ECR login
echo "Logging in to ECR"
aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin $(aws sts get-caller-identity --query Account --output text).dkr.ecr.${REGION}.amazonaws.com

# Output the repository URLs
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
echo "ECR repositories created successfully"
echo "Frontend repository: ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${FRONTEND_REPO}"
echo "Backend repository: ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${BACKEND_REPO}"
echo ""
echo "Update the REGISTRY variable in build-frontend.sh, build-backend.sh, and push-images.sh with:"
echo "${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com"