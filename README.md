# Project 3: Nebulance - Cloud-Native Application Deployment

This project demonstrates a complete cloud-native application deployment pipeline using AWS EKS, Docker, Helm, and CircleCI.

## Project Overview

Nebulance is a three-tier application consisting of:
- Frontend: React.js application
- Backend: Node.js REST API
- Database: PostgreSQL

The project is organized into five main tasks:

1. **Infrastructure Provisioning with Terraform**
2. **Container Engineering**
3. **Secrets Management Integration**
4. **Kubernetes Orchestration with Helm**
5. **CI/CD Pipeline with CircleCI**

## Task 1: Infrastructure Provisioning with Terraform

The infrastructure is provisioned using Terraform and includes:

- VPC with public and private subnets
- EKS cluster with managed node groups
- IAM roles and policies
- Security groups
- Load balancers

**Step-by-Step Actions:**

1. Initialize Terraform:
   ```bash
   cd terraform
   terraform init
   ```

2. Review the infrastructure plan:
   ```bash
   terraform plan
   ```

3. Apply the infrastructure:
   ```bash
   terraform apply
   ```

4. Configure kubectl to connect to the EKS cluster:
   ```bash
   aws eks update-kubeconfig --name eks-nebulance --region eu-central-1
   ```

5. Verify the cluster is accessible:
   ```bash
   kubectl get nodes
   ```

**Key Files:**
- `/terraform/main.tf`
- `/terraform/vpc.tf`
- `/terraform/eks.tf`
- `/terraform/iam.tf`

## Task 2: Container Engineering

The application is containerized using Docker with:

- Production-ready Docker images
- Security best practices
- Health checks
- Proper startup sequences

**Step-by-Step Actions:**

1. Navigate to the docker directory:
   ```bash
   cd docker
   ```

2. Build the Docker images:
   ```bash
   ./build-all.sh
   ```

3. Verify the images were built correctly:
   ```bash
   ./verify-images.sh
   ```

4. Test the images locally:
   ```bash
   ./test-images.sh
   ```

5. Push the images to Docker Hub:
   ```bash
   ./push-to-dockerhub.sh
   ```

6. Run the application locally (optional):
   ```bash
   ./run-local.sh
   ```

**Key Files:**
- `/docker/build-frontend.sh`
- `/docker/build-backend.sh`
- `/docker/docker-compose.yml`
- `/docker/push-to-dockerhub.sh`

## Task 3: Secrets Management Integration

Secure credential management is implemented using:

- AWS Secrets Manager for storing secrets
- External Secrets Operator for Kubernetes integration

**Step-by-Step Actions:**

1. Navigate to the secrets directory:
   ```bash
   cd secrets
   ```

2. Generate secure secrets:
   ```bash
   ./generate-secrets.sh
   ```

3. Store secrets in AWS Secrets Manager:
   ```bash
   ./create-aws-secrets.sh
   ```

4. Install External Secrets Operator in the EKS cluster:
   ```bash
   ./install-external-secrets.sh
   ```

5. Get the IAM role ARN for External Secrets Operator:
   ```bash
   aws iam get-role --role-name <role-name> --query Role.Arn --output text
   ```

6. Apply the External Secrets configuration:
   ```bash
   ./apply-external-secrets.sh <IAM_ROLE_ARN>
   ```

7. Verify the secrets are synced to Kubernetes:
   ```bash
   kubectl get externalsecrets
   kubectl get secrets
   ```

**Key Files:**
- `/secrets/generate-secrets.sh`
- `/secrets/create-aws-secrets.sh`
- `/secrets/external-secrets-operator.yaml`

## Task 4: Kubernetes Orchestration with Helm

The application is deployed to Kubernetes using Helm with:

- Charts for all three application tiers
- External Secrets integration
- Horizontal pod autoscaling
- Service discovery
- Health probes

**Step-by-Step Actions:**

1. Navigate to the helm directory:
   ```bash
   cd helm
   ```

2. Review the Helm chart values:
   ```bash
   cat nebulance/values.yaml
   ```

3. Deploy the application using Helm:
   ```bash
   ./deploy.sh
   ```

4. Verify the deployment:
   ```bash
   kubectl get pods
   kubectl get services
   kubectl get hpa
   ```

5. Access the application:
   ```bash
   kubectl get service frontend
   ```
   Use the EXTERNAL-IP from the output to access the application in your browser.

6. Monitor the application:
   ```bash
   kubectl describe pods
   kubectl logs -f <pod-name>
   ```

**Key Files:**
- `/helm/nebulance/Chart.yaml`
- `/helm/nebulance/values.yaml`
- `/helm/nebulance/templates/`

## Task 5: CI/CD Pipeline with CircleCI

Continuous integration and deployment is implemented using CircleCI with:

- Automated testing
- Docker image building and pushing
- Helm chart deployment to EKS
- Environment-specific configurations

**Step-by-Step Actions:**

1. Create a GitHub repository for the project:
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   ```

2. Push your code to the GitHub repository:
   ```bash
   git branch -M main
   git remote add origin <repository-url>
   git push -u origin main
   ```

3. Set up CircleCI project and connect to GitHub repository:
   - Go to CircleCI website and sign up/login
   - Add your GitHub repository as a project
   - Set up the project with the existing configuration

4. Configure CircleCI Environment Variables:
   ```bash
   # These need to be added through the CircleCI web interface
   DOCKER_USERNAME=highshow14
   DOCKER_PASSWORD=<your-docker-hub-password>
   AWS_ACCESS_KEY_ID=<your-aws-access-key>
   AWS_SECRET_ACCESS_KEY=<your-aws-secret-key>
   AWS_REGION=eu-central-1
   ```

5. Set up CircleCI Contexts for different environments:
   - Create a context named "docker-hub-creds" with Docker Hub credentials
   - Create a context named "aws-dev" with AWS credentials for development
   - Create a context named "aws-prod" with AWS credentials for production

6. Prepare for deployment:
   ```bash
   cd scripts
   ```

7. Trigger the CI/CD pipeline:
   ```bash
   git add .
   git commit -m "Update configuration"
   git push
   ```

8. Verify the deployment:
   ```bash
   # After CircleCI completes the deployment
   kubectl get pods
   kubectl get services
   ```

**Key Files:**
- `/.circleci/config.yml`
- `/environments/dev/values.yaml`
- `/environments/prod/values.yaml`
- `/scripts/deploy.sh`

## Getting Started

### Prerequisites

- AWS CLI
- Terraform
- Docker
- kubectl
- Helm
- GitHub account
- CircleCI account

### Complete Deployment Workflow

1. **Infrastructure Provisioning:**
   ```bash
   cd terraform
   terraform init
   terraform plan
   terraform apply
   aws eks update-kubeconfig --name eks-nebulance --region eu-central-1
   kubectl get nodes
   ```

2. **Container Engineering:**
   ```bash
   cd docker
   ./build-all.sh
   ./verify-images.sh
   ./push-to-dockerhub.sh
   ```

3. **Secrets Management:**
   ```bash
   cd secrets
   ./generate-secrets.sh
   ./create-aws-secrets.sh
   ./install-external-secrets.sh
   
   # Get the IAM role ARN
   aws iam get-role --role-name <role-name> --query Role.Arn --output text
   
   # Apply External Secrets configuration
   ./apply-external-secrets.sh <IAM_ROLE_ARN>
   
   # Verify secrets
   kubectl get externalsecrets
   kubectl get secrets
   ```

4. **Kubernetes Deployment:**
   ```bash
   cd helm
   ./deploy.sh
   
   # Verify deployment
   kubectl get pods
   kubectl get services
   kubectl get hpa
   
   # Get application URL
   kubectl get service frontend
   ```

5. **CI/CD Pipeline:**
   ```bash
   # Push code to GitHub
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin <repository-url>
   git push -u origin main
   
   # Configure CircleCI through the web interface
   # Create contexts and add environment variables
   
   # Monitor CircleCI workflow through the web interface
   ```

## Architecture

The application follows a three-tier architecture:

1. **Frontend Tier:**
   - React.js application
   - Served by Nginx
   - Horizontally scalable (2-5 pods)

2. **Backend Tier:**
   - Node.js REST API
   - Horizontally scalable (3-10 pods)
   - Connects to PostgreSQL database

3. **Database Tier:**
   - PostgreSQL database
   - Persistent storage (when EBS CSI driver is properly configured)

## Security Considerations

- Non-root users for containers
- Minimal base images
- Proper file permissions
- Secrets stored in AWS Secrets Manager
- IAM roles for service accounts
- Network security with security groups

## Monitoring and Scaling

- Readiness and liveness probes for health monitoring
- Horizontal Pod Autoscaling based on CPU utilization
- Environment-specific resource configurations

## Author

-