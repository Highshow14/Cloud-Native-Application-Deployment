# Task 4: Kubernetes Orchestration with Helm

## Overview

This directory contains Helm charts for deploying the Nebulance application on Kubernetes. The deployment consists of three tiers:

1. **Frontend**: React.js application served by Nginx
2. **Backend**: Node.js REST API
3. **Database**: PostgreSQL database with persistent storage

## Requirements Fulfilled

1. **Helm Charts for All Tiers**:
   - Frontend deployment with service and HPA
   - Backend deployment with service and HPA
   - PostgreSQL database with persistent storage

2. **External Secrets Integration**:
   - Configured to use secrets from AWS Secrets Manager
   - Injects credentials into all components

3. **PostgreSQL with Persistent Storage**:
   - Uses PersistentVolumeClaim for data persistence
   - Configurable storage size

4. **Horizontal Pod Autoscaling**:
   - Frontend: 2-5 pods based on CPU utilization
   - Backend: 3-10 pods based on CPU utilization

5. **Service Discovery**:
   - Services configured for inter-component communication
   - Environment variables set for service discovery

6. **Health Checks**:
   - Readiness and liveness probes configured for all components
   - Appropriate initial delay and period settings

## Directory Structure

```
nebulance/
├── Chart.yaml
├── values.yaml
├── README.md
└── templates/
    ├── frontend/
    │   ├── deployment.yaml
    │   ├── service.yaml
    │   └── hpa.yaml
    ├── backend/
    │   ├── deployment.yaml
    │   ├── service.yaml
    │   └── hpa.yaml
    └── database/
        ├── deployment.yaml
        ├── service.yaml
        └── pvc.yaml
```

## Deployment

To deploy the application:

```bash
chmod +x deploy.sh
./deploy.sh
```

This will install the Helm chart in the default namespace.

## Prerequisites

Before deploying, ensure:

1. You have a running Kubernetes cluster (EKS)
2. kubectl is configured to connect to your cluster
3. Helm is installed
4. External Secrets Operator is installed (from Task 3)
5. Secrets are stored in AWS Secrets Manager (from Task 3)
6. Docker images are pushed to Docker Hub (from Task 2)

## Verification

After deployment, verify the application is running:

```bash
kubectl get pods
kubectl get services
kubectl get hpa
```

The frontend service should be accessible via a LoadBalancer URL.