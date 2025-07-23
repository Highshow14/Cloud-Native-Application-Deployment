# Project 4: GitOps Deployment with Argo CD on Amazon EKS

This project extends the existing infrastructure and application deployed in Project 3 by integrating Argo CD to enable a GitOps workflow. The goal is to automate and manage application deployments through declarative configurations stored in Git, using Argo CD as the delivery controller.

## Overview

The GitOps implementation consists of:

1. **Argo CD**: Deployed in the `argocd` namespace, serving as the GitOps controller
2. **GitOps Repository**: A Git repository containing Helm charts and application configurations
3. **Application Manifests**: Argo CD Application resources that define what to deploy and how

## Directory Structure

```
Project-3-Nebulance/
├── argocd/
│   ├── install/
│   │   ├── install.yaml    # Argo CD installation manifest
│   │   └── install.sh      # Script to install Argo CD
│   ├── applications/
│   │   ├── frontend.yaml   # Frontend Application manifest
│   │   ├── backend.yaml    # Backend Application manifest
│   │   ├── database.yaml   # Database Application manifest
│   │   └── apply.sh        # Script to apply Application manifests
│   └── README.md           # GitOps implementation documentation
└── gitops-example/         # Example GitOps repository structure
    ├── helm/
    │   └── nebulance/
    │       ├── Chart.yaml
    │       ├── values.yaml
    │       ├── environments/
    │       │   ├── dev/
    │       │   │   └── values.yaml
    │       │   └── prod/
    │       │       └── values.yaml
    │       └── templates/  # (existing templates from Project 3)
    └── README.md           # GitOps repository documentation
```

## Implementation Steps

### 1. Install Argo CD

```bash
cd argocd/install
./install.sh
```

This will:
- Create the `argocd` namespace
- Deploy Argo CD components (server, repo server, application controller)
- Configure initial access credentials

### 2. Set Up GitOps Repository

1. Create a new GitHub repository (e.g., `nebulance-gitops`)
2. Copy the contents of the `gitops-example` directory to the repository
3. Push the changes to GitHub

### 3. Apply Application Manifests

```bash
cd argocd/applications
# Update the repoURL in the YAML files to point to your GitOps repository
./apply.sh
```

This will:
- Create Argo CD Application resources for frontend, backend, and database
- Configure automated sync policies
- Link the applications to the GitOps repository

### 4. Access Argo CD UI

1. Get the Argo CD server URL:
   ```bash
   kubectl get svc argocd-server -n argocd -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'
   ```
2. Open the URL in your browser
3. Login with username: `admin`, password: `password` (change this immediately!)

## GitOps Workflow

1. **Make Changes**: Update the Helm charts or values in the GitOps repository
2. **Commit and Push**: Push the changes to the GitOps repository
3. **Automatic Sync**: Argo CD detects the changes and automatically syncs the applications
4. **Verification**: Verify the changes in the Argo CD UI and the application

## Key Features

- **Automated Sync**: Changes to the GitOps repository are automatically applied to the cluster
- **Drift Detection**: Argo CD detects and resolves configuration drift
- **Rollback Support**: Easy rollback to previous versions if needed
- **Environment-Specific Configurations**: Different values for development and production environments
- **Secrets Management**: Integration with AWS Secrets Manager and External Secrets Operator

## Security Considerations

- The Argo CD admin password should be changed immediately after installation
- Use HTTPS for the GitOps repository
- Consider using private repositories and SSH keys for authentication
- Implement RBAC for Argo CD users
- Ensure that secrets are still managed by AWS Secrets Manager and External Secrets Operator

## Verification

After implementing GitOps with Argo CD, verify that:

1. All three tiers of the application are running correctly
2. Changes to the GitOps repository are automatically applied to the cluster
3. Secrets are still being sourced securely via AWS Secrets Manager
4. LoadBalancer access and internal services remain unchanged