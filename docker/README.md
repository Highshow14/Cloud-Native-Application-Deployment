# Nebulance Docker Images

This directory contains scripts to build and run Docker images for the Nebulance application.

## Docker Images

The application consists of two main components:

1. **Frontend**: React.js application served by Nginx
2. **Backend**: Node.js REST API

## Building the Images

1. Make the scripts executable:
   ```
   ./setup.sh
   ```

2. Build all images:
   ```
   ./build-all.sh
   ```

   Or build individual images:
   ```
   ./build-frontend.sh
   ./build-backend.sh
   ```

## Running the Application

Use Docker Compose to run the entire application stack:

```
docker-compose up -d
```

This will start:
- PostgreSQL database
- Backend API on port 3000
- Frontend on port 80

## Image Details

### Frontend Image
- Base: nginx:alpine
- Security: Runs as non-root user
- Health check: HTTP check on port 8080
- Version: 1.0.0

### Backend Image
- Base: node:18-alpine
- Security: Runs as non-root user
- Health check: HTTP check on /health endpoint
- Version: 1.0.0

## Environment Variables

The application uses the following environment variables:

### Database
- POSTGRES_USER
- POSTGRES_PASSWORD
- POSTGRES_DB

### Backend
- JWT_SECRET
- API_KEY

You can set these variables in a `.env` file in the same directory as the docker-compose.yml file.