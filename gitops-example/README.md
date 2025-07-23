# Nebulance GitOps Repository

This repository contains the Helm charts and configuration for the Nebulance application, managed via GitOps with Argo CD.

## Repository Structure

```
helm/
└── nebulance/
    ├── Chart.yaml
    ├── values.yaml
    ├── templates/
    │   ├── frontend/
    │   ├── backend/
    │   └── database/
    └── environments/
        ├── dev/
        │   └── values.yaml
        └── prod/
            └── values.yaml
```

## Usage

This repository is used by Argo CD to deploy the Nebulance application to the EKS cluster. Any changes to the Helm charts or values will be automatically detected by Argo CD and applied to the cluster.

### Making Changes

1. Clone the repository
2. Make changes to the Helm charts or values
3. Commit and push the changes
4. Argo CD will automatically detect and apply the changes

### Environment-Specific Configuration

- `environments/dev/values.yaml`: Values for the development environment
- `environments/prod/values.yaml`: Values for the production environment

## Applications

The Nebulance application consists of three tiers:

1. **Frontend**: React.js application
2. **Backend**: Node.js REST API
3. **Database**: PostgreSQL database

Each tier is deployed as a separate Argo CD Application, but they all use the same Helm chart with different values.