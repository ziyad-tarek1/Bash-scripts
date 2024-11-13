#!/bin/bash

# Welcome message
echo "Welcome to the ECR Docker Deployment Script!"

# Prompt for AWS CLI configuration
read -p "Do you want to use the default AWS CLI configuration? (y/n): " use_default

if [[ "$use_default" == "y" || "$use_default" == "yes" ]]; then
    echo "Using the default AWS CLI configuration."
else
    echo "Running AWS CLI configuration..."
    aws configure
fi

# Store the default region or the chosen one
region=$(aws configure get region)
if [[ -z "$region" ]]; then
    echo "ERROR: No AWS region found. Please configure AWS CLI with a default region."
    exit 1
fi

# Get the account number
account_number=$(aws sts get-caller-identity --query Account --output text)
if [[ -z "$account_number" ]]; then
    echo "ERROR: Unable to retrieve AWS account number. Please check AWS CLI configuration."
    exit 1
fi

# Ask if the user wants to create a new ECR repository or use an existing one
read -p "Do you want to create a new ECR repository? (y/n): " create_repo

if [[ "$create_repo" == "y" || "$create_repo" == "yes" ]]; then
    read -p "Enter the name for the new ECR repository: " repo_name
    aws ecr create-repository --repository-name "$repo_name" --region "$region"
    echo "Repository '$repo_name' created."
else
    # Fetch and display existing repositories
    echo "Fetching existing ECR repositories..."
    aws ecr describe-repositories --region "$region" --query 'repositories[*].repositoryName' --output text

    # Prompt for repository selection
    read -p "Enter the name of the repository you want to use: " repo_name

    # Verify repository exists
    if ! aws ecr describe-repositories --repository-names "$repo_name" --region "$region" &>/dev/null; then
        echo "ERROR: Repository '$repo_name' does not exist in region '$region'."
        exit 1
    fi
fi

# Authenticate Docker to ECR
echo "Authenticating Docker to ECR..."
aws ecr get-login-password --region "$region" | docker login --username AWS --password-stdin "$account_number.dkr.ecr.$region.amazonaws.com"
if [[ $? -ne 0 ]]; then
    echo "ERROR: Docker authentication to ECR failed."
    exit 1
fi

# Prompt for Dockerfile directory
read -p "Enter the path to the directory containing your Dockerfile (default: ./): " dockerfile_dir
dockerfile_dir=${dockerfile_dir:-./}  # Default to current directory if empty

# Change to the Dockerfile directory
if [[ ! -d "$dockerfile_dir" ]]; then
    echo "ERROR: Directory not found at $dockerfile_dir"
    exit 1
fi
cd "$dockerfile_dir"

# Check if Dockerfile exists in the specified directory
if [[ ! -f "Dockerfile" ]]; then
    echo "ERROR: Dockerfile not found in $dockerfile_dir"
    exit 1
fi

# Build Docker image
echo "Building Docker image..."
image_name="${repo_name}-image"
docker build -t "$image_name" -f "Dockerfile" .
if [[ $? -ne 0 ]]; then
    echo "ERROR: Docker image build failed."
    exit 1
fi

# Tag Docker image
echo "Tagging Docker image..."
docker tag "$image_name:latest" "$account_number.dkr.ecr.$region.amazonaws.com/$repo_name:latest"
if [[ $? -ne 0 ]]; then
    echo "ERROR: Docker image tagging failed."
    exit 1
fi

# Push Docker image to ECR
echo "Pushing Docker image to ECR..."
docker push "$account_number.dkr.ecr.$region.amazonaws.com/$repo_name:latest"
if [[ $? -ne 0 ]]; then
    echo "ERROR: Docker image push to ECR failed."
    exit 1
fi

# Final message
echo "Docker image pushed successfully to ECR repository '$repo_name'!"
