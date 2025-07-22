#!/bin/bash
set -e

# Store secrets in AWS Secrets Manager
echo "Storing secrets in AWS Secrets Manager..."

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "Error: AWS CLI is not installed. Please install it first."
    exit 1
fi

# Check if JSON files exist
if [ ! -f database-secrets.json ] || [ ! -f application-secrets.json ]; then
    echo "Error: Secret JSON files not found. Run generate-secrets.sh first."
    exit 1
fi

# AWS region
AWS_REGION="eu-central-1"

# Create database secrets
echo "Creating database secrets in AWS Secrets Manager..."
aws secretsmanager create-secret \
    --name eks-app/database \
    --description "Database credentials for Nebulance application" \
    --secret-string file://database-secrets.json \
    --region $AWS_REGION

# Create application secrets
echo "Creating application secrets in AWS Secrets Manager..."
aws secretsmanager create-secret \
    --name eks-app/application \
    --description "Application secrets for Nebulance application" \
    --secret-string file://application-secrets.json \
    --region $AWS_REGION

echo "Secrets stored successfully in AWS Secrets Manager:"
echo "- eks-app/database"
echo "- eks-app/application"