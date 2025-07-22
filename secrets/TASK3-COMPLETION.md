# Task 3: Secrets Management Integration - Completion Steps

## Prerequisites

Before completing Task 3, you need to install the following tools:

1. **AWS CLI**: For interacting with AWS Secrets Manager
2. **kubectl**: For interacting with your Kubernetes cluster
3. **Helm**: For installing External Secrets Operator

You can install these prerequisites using the provided script:

```bash
chmod +x install-prerequisites.sh
./install-prerequisites.sh
```

## Step 1: Generate Secrets

We've already generated secure secrets:

```bash
bash generate-secrets.sh
```

This has created:
- JWT_SECRET: 6tbldcwi5Ne9pytCX6AOyNHHW0aAvO9ZRV9SZzxUv2a6TsUA4aWUN5XWT0T6tS
- API_KEY: 3a73c9c37363b79579cb517a1bcaf2a1
- POSTGRES_USER: nebulance_user
- POSTGRES_PASSWORD: RI8bSDkrXAbGFJS6ev7GcqAGBWeF7H8U
- POSTGRES_DB: nebulance_db

And saved them to JSON files:
- database-secrets.json
- application-secrets.json

## Step 2: Store Secrets in AWS Secrets Manager

After installing the AWS CLI and configuring your AWS credentials, run:

```bash
bash create-aws-secrets.sh
```

This will create two secrets in AWS Secrets Manager:
- `eks-app/database`: Database credentials
- `eks-app/application`: Application secrets

## Step 3: Install External Secrets Operator

After installing kubectl and Helm, and configuring access to your EKS cluster, run:

```bash
bash install-external-secrets.sh
```

This will install External Secrets Operator in your EKS cluster.

## Step 4: Apply External Secrets Configuration

Get the IAM role ARN for External Secrets Operator from Task 1, then run:

```bash
bash apply-external-secrets.sh <IAM_ROLE_ARN>
```

Replace `<IAM_ROLE_ARN>` with the ARN of the IAM role created in Task 1.

## Verification

To verify that the secrets are properly synced:

```bash
kubectl get externalsecrets -n default
kubectl get secrets -n default
```

You should see the following secrets:
- `database-credentials`
- `application-secrets`