# Task 3: Secrets Management Integration

This directory contains scripts and configuration files for implementing secure credential management for the Nebulance application.

## Overview

The secrets management solution consists of:

1. **Secret Generation**: Cryptographically secure secrets for the application
2. **AWS Secrets Manager**: Storage of secrets in AWS Secrets Manager
3. **External Secrets Operator**: Kubernetes integration for accessing secrets

## Files

- `generate-secrets.sh`: Script to generate secure secrets
- `create-aws-secrets.sh`: Script to store secrets in AWS Secrets Manager
- `external-secrets-operator.yaml`: Kubernetes manifests for External Secrets Operator
- `install-external-secrets.sh`: Script to install External Secrets Operator using Helm
- `apply-external-secrets.sh`: Script to apply the External Secrets configuration

## Usage

### Step 1: Generate Secrets

```bash
chmod +x generate-secrets.sh
./generate-secrets.sh
```

This will generate:
- JWT_SECRET (64 character random string)
- API_KEY (32 character random string)
- POSTGRES_USER, POSTGRES_PASSWORD, POSTGRES_DB

### Step 2: Store Secrets in AWS Secrets Manager

```bash
chmod +x create-aws-secrets.sh
./create-aws-secrets.sh
```

This will create two secrets in AWS Secrets Manager:
- `eks-app/database`: Database credentials
- `eks-app/application`: Application secrets (JWT_SECRET, API_KEY)

### Step 3: Install External Secrets Operator

```bash
chmod +x install-external-secrets.sh
./install-external-secrets.sh
```

This will install External Secrets Operator in your EKS cluster.

### Step 4: Apply External Secrets Configuration

```bash
chmod +x apply-external-secrets.sh
./apply-external-secrets.sh <IAM_ROLE_ARN>
```

Replace `<IAM_ROLE_ARN>` with the ARN of the IAM role created in Task 1 for External Secrets Operator.

## Verification

To verify that the secrets are properly synced:

```bash
kubectl get externalsecrets -n default
kubectl get secrets -n default
```

You should see the following secrets:
- `database-credentials`
- `application-secrets`