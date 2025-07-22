# Nebulance EKS Infrastructure

This directory contains Terraform code to provision the infrastructure for the Nebulance EKS project.

## Infrastructure Components

- EKS cluster named "eks-nebulance" in eu-central-1 region
- Production VPC with multi-AZ deployment (3 availability zones)
- Public subnets for load balancers, private subnets for worker nodes
- IAM roles with IRSA capability for External Secrets Operator
- Auto-scaling node groups with t3.medium instances (2-10 nodes)
- KMS encryption for cluster secrets

## Usage

1. Initialize Terraform:
```
terraform init
```

2. Review the plan:
```
terraform plan
```

3. Apply the configuration:
```
terraform apply
```

4. To destroy the infrastructure:
```
terraform destroy
```

## Outputs

- `cluster_endpoint`: Endpoint for EKS control plane
- `cluster_name`: Kubernetes Cluster Name
- `region`: AWS region
- `vpc_id`: VPC ID
- `public_subnet_ids`: List of public subnet IDs
- `private_subnet_ids`: List of private subnet IDs
- `external_secrets_role_arn`: ARN of the IAM role for External Secrets Operator