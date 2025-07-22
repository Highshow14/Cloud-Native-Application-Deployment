#!/bin/bash
set -e

# Script to deploy the application to EKS using Helm

# Default values
ENVIRONMENT="dev"
NAMESPACE="default"
RELEASE_NAME="nebulance"
IMAGE_TAG=${CIRCLE_SHA1:0:7}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    --environment|-e)
      ENVIRONMENT="$2"
      shift
      shift
      ;;
    --namespace|-n)
      NAMESPACE="$2"
      shift
      shift
      ;;
    --release|-r)
      RELEASE_NAME="$2"
      shift
      shift
      ;;
    --tag|-t)
      IMAGE_TAG="$2"
      shift
      shift
      ;;
    --help|-h)
      echo "Usage: $0 [options]"
      echo "Options:"
      echo "  --environment, -e   Environment to deploy to (dev or prod) [default: dev]"
      echo "  --namespace, -n     Kubernetes namespace [default: default]"
      echo "  --release, -r       Helm release name [default: nebulance]"
      echo "  --tag, -t           Docker image tag [default: CircleCI SHA]"
      echo "  --help, -h          Show this help message"
      exit 0
      ;;
    *)
      echo "Unknown option: $key"
      exit 1
      ;;
  esac
done

echo "Deploying to $ENVIRONMENT environment in namespace $NAMESPACE"
echo "Release name: $RELEASE_NAME"
echo "Image tag: $IMAGE_TAG"

# Check if the environment values file exists
VALUES_FILE="./environments/$ENVIRONMENT/values.yaml"
if [ ! -f "$VALUES_FILE" ]; then
  echo "Error: Values file not found: $VALUES_FILE"
  exit 1
fi

# Deploy using Helm
helm upgrade --install "$RELEASE_NAME" ./helm/nebulance \
  --namespace "$NAMESPACE" \
  --create-namespace \
  --values "$VALUES_FILE" \
  --set frontend.image.tag="$IMAGE_TAG" \
  --set backend.image.tag="$IMAGE_TAG"

echo "Deployment completed successfully!"
echo "To check the status of the deployment:"
echo "kubectl get pods -n $NAMESPACE"