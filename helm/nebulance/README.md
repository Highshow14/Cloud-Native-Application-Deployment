# Nebulance Helm Chart

This Helm chart deploys the Nebulance application on Kubernetes.

## Components

- **Frontend**: React.js application served by Nginx
- **Backend**: Node.js REST API
- **Database**: PostgreSQL database with persistent storage

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+
- External Secrets Operator installed
- Secrets stored in AWS Secrets Manager

## Installation

```bash
# Add the repository
helm repo add nebulance https://your-helm-repo.example.com

# Install the chart
helm install nebulance nebulance/nebulance
```

Or install from local directory:

```bash
helm install nebulance ./nebulance
```

## Configuration

The following table lists the configurable parameters of the Nebulance chart and their default values.

### Global Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `global.environment` | Environment name | `production` |

### Frontend Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `frontend.image.repository` | Frontend image repository | `highshow14/nebulance-frontend` |
| `frontend.image.tag` | Frontend image tag | `1.0.0` |
| `frontend.replicaCount` | Number of frontend replicas | `2` |
| `frontend.autoscaling.enabled` | Enable autoscaling for frontend | `true` |
| `frontend.autoscaling.minReplicas` | Minimum frontend replicas | `2` |
| `frontend.autoscaling.maxReplicas` | Maximum frontend replicas | `5` |

### Backend Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `backend.image.repository` | Backend image repository | `highshow14/nebulance-backend` |
| `backend.image.tag` | Backend image tag | `1.0.0` |
| `backend.replicaCount` | Number of backend replicas | `3` |
| `backend.autoscaling.enabled` | Enable autoscaling for backend | `true` |
| `backend.autoscaling.minReplicas` | Minimum backend replicas | `3` |
| `backend.autoscaling.maxReplicas` | Maximum backend replicas | `10` |

### Database Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `database.image.repository` | Database image repository | `postgres` |
| `database.image.tag` | Database image tag | `15-alpine` |
| `database.persistence.enabled` | Enable persistence for database | `true` |
| `database.persistence.size` | Size of persistent volume | `10Gi` |

### External Secrets Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `externalSecrets.enabled` | Enable External Secrets integration | `true` |
| `externalSecrets.database.secretName` | Name of database credentials secret | `database-credentials` |
| `externalSecrets.application.secretName` | Name of application secrets secret | `application-secrets` |