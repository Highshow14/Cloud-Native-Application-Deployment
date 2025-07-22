#!/bin/bash
set -e

# Run the application locally using Docker Compose

# Configuration
export DOCKER_USERNAME="highshow14" # Replace with your Docker Hub username

echo "Starting Nebulance application locally..."

# Check if .env file exists, if not create from sample
if [ ! -f .env ]; then
  echo "Creating .env file from .env.sample..."
  cp .env.sample .env
  echo "Please update the .env file with your secure credentials"
fi

# Start the application
/usr/local/bin/docker-compose up -d

echo "Application started successfully"
echo "Frontend available at: http://localhost"
echo "Backend API available at: http://localhost:3000"
echo "To view logs: docker-compose logs -f"
echo "To stop the application: docker-compose down"