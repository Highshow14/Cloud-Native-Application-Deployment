#!/bin/bash
set -e

# Test the Docker images by running health checks

# Configuration
DOCKER_USERNAME="highshow14" # Replace with your Docker Hub username

echo "Testing Docker images..."

# Test backend image
echo "Testing backend image..."
/usr/local/bin/docker run --rm --name test-backend -d -p 3000:3000 \
  -e JWT_SECRET=test_secret \
  -e API_KEY=test_key \
  -e POSTGRES_HOST=dummy \
  -e POSTGRES_PORT=5432 \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=nebulance \
  ${DOCKER_USERNAME}/nebulance-backend:1.0.0

# Wait for container to start
echo "Waiting for backend to start..."
sleep 5

# Test health endpoint
if curl -s http://localhost:3000/health | grep -q "ok"; then
  echo "✅ Backend health check passed"
else
  echo "❌ Backend health check failed"
fi

# Stop backend container
/usr/local/bin/docker stop test-backend

# Test frontend image
echo "Testing frontend image..."
/usr/local/bin/docker run --rm --name test-frontend -d -p 8080:8080 ${DOCKER_USERNAME}/nebulance-frontend:1.0.0

# Wait for container to start
echo "Waiting for frontend to start..."
sleep 5

# Test health endpoint
if curl -s http://localhost:8080/health | grep -q "healthy"; then
  echo "✅ Frontend health check passed"
else
  echo "❌ Frontend health check failed"
fi

# Stop frontend container
/usr/local/bin/docker stop test-frontend

echo "Image testing complete"