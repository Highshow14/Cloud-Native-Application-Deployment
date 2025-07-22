#!/bin/bash
set -e

# Generate secure secrets for the application
echo "Generating secure secrets for Nebulance application..."

# Generate JWT_SECRET (64 character random string)
JWT_SECRET=$(openssl rand -base64 48 | tr -d '\n/+=' | cut -c1-64)

# Generate API_KEY (32 character random string)
API_KEY=$(openssl rand -hex 16)

# Generate PostgreSQL credentials
POSTGRES_USER="nebulance_user"
POSTGRES_PASSWORD=$(openssl rand -base64 32 | tr -d '\n/+=' | cut -c1-32)
POSTGRES_DB="nebulance_db"

# Output the generated secrets
echo "Secrets generated successfully:"
echo "-------------------------------------"
echo "JWT_SECRET: $JWT_SECRET"
echo "API_KEY: $API_KEY"
echo "POSTGRES_USER: $POSTGRES_USER"
echo "POSTGRES_PASSWORD: $POSTGRES_PASSWORD"
echo "POSTGRES_DB: $POSTGRES_DB"
echo "-------------------------------------"

# Create JSON files for AWS Secrets Manager
echo "Creating JSON files for AWS Secrets Manager..."

# Database secrets
cat > database-secrets.json << EOF
{
  "POSTGRES_USER": "${POSTGRES_USER}",
  "POSTGRES_PASSWORD": "${POSTGRES_PASSWORD}",
  "POSTGRES_DB": "${POSTGRES_DB}"
}
EOF

# Application secrets
cat > application-secrets.json << EOF
{
  "JWT_SECRET": "${JWT_SECRET}",
  "API_KEY": "${API_KEY}"
}
EOF

echo "JSON files created:"
echo "- database-secrets.json"
echo "- application-secrets.json"
echo ""
echo "Next steps:"
echo "1. Run create-aws-secrets.sh to store these secrets in AWS Secrets Manager"
echo "2. Deploy External Secrets Operator to your EKS cluster"