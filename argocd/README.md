# GitOps Deployment with Argo CD

This directory contains the configuration for implementing GitOps deployment with Argo CD on the existing EKS cluster.

## Architecture

The GitOps architecture consists of:

1. **Argo CD**: Deployed in the `argocd` namespace, serving as the GitOps controller
2. **GitOps Repository**: A Git repository containing Helm charts and application configurations
3. **Application Manifests**: Argo CD Application resources that define what to deploy and how

## Directory Structure

```
argocd/
├── install/
│   ├── install.yaml    # Argo CD installation manifest
│   └── install.sh      # Script to install Argo CD
└── applications/
    ├── frontend.yaml   # Frontend Application manifest
    ├── backend.yaml    # Backend Application manifest
    ├── database.yaml   # Database Application manifest
    └── apply.sh        # Script to apply Application manifests
```

## GitOps Repository Structure

The GitOps repository should have the following structure:

```
nebulance-gitops/
├── helm/
│   └── nebulance/
│       ├── Chart.yaml
│       ├── values.yaml
│       ├── templates/
│       │   ├── frontend/
│       │   ├── backend/
│       │   └── database/
│       └── environments/
│           ├── dev/
│           │   └── values.yaml
│           └── prod/
│               └── values.yaml
└── README.md
```

## Setup Instructions

### 1. Install Argo CD

```bash
cd argocd/install
./install.sh
```

### 2. Create GitOps Repository

1. Create a new GitHub repository (e.g., `nebulance-gitops`)
2. Copy your Helm charts and environment configurations to the repository
3. Push the changes to GitHub

### 3. Apply Application Manifests

```bash
cd argocd/applications
# Update the repoURL in the YAML files to point to your GitOps repository
./apply.sh
```

### 4. Access Argo CD UI

1. Get the Argo CD server URL:
   ```bash
   kubectl get svc argocd-server -n argocd -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'
   ```
2. Open the URL in your browser
3. Login with username: `admin`, password: `password` (change this immediately!)

## Workflow

1. **Make Changes**: Update the Helm charts or values in the GitOps repository
2. **Commit and Push**: Push the changes to the GitOps repository
3. **Automatic Sync**: Argo CD detects the changes and automatically syncs the applications
4. **Verification**: Verify the changes in the Argo CD UI and the application

## Security Considerations

- The Argo CD admin password should be changed immediately after installation
- Use HTTPS for the GitOps repository
- Consider using private repositories and SSH keys for authentication
- Implement RBAC for Argo CD users
- Ensure that secrets are still managed by AWS Secrets Manager and External Secrets Operator