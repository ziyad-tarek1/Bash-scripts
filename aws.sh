#!/bin/bash

# Script: Install AWS CLI and eksctl on CentOS 9
# Author: [Your Name]
# Description: This script checks for AWS CLI installation, installs it if not present,
#              then installs eksctl, verifies installations, and guides the user on further steps.

set -e

# Function to check and install AWS CLI
install_aws_cli() {
  echo "Checking for AWS CLI installation..."
  if ! command -v aws &> /dev/null; then
    echo "AWS CLI not found. Installing AWS CLI..."
    
    # Download and install AWS CLI
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    rm -rf awscliv2.zip aws/

    # Verify installation
    if command -v aws &> /dev/null; then
      echo "AWS CLI installed successfully."
    else
      echo "AWS CLI installation failed." >&2
      exit 1
    fi
  else
    echo "AWS CLI is already installed. Version: $(aws --version)"
  fi
}

# Function to install eksctl
install_eksctl() {
  echo "Installing eksctl..."
  
  # Download and extract eksctl binary
  curl -sLO "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_Linux_amd64.tar.gz"
  tar -xzf eksctl_Linux_amd64.tar.gz
  sudo mv eksctl /usr/local/bin/
  rm -f eksctl_Linux_amd64.tar.gz

  # Verify installation
  if command -v eksctl &> /dev/null; then
    echo "eksctl installed successfully. Version: $(eksctl version)"
  else
    echo "eksctl installation failed." >&2
    exit 1
  fi
}

# Function to provide guidance after installation
post_install_message() {
  echo
  echo "Installation completed successfully!"
  echo "You can now configure your AWS credentials using the following command:"
  echo
  echo "  aws configure"
  echo
  echo "After configuring AWS, you can test eksctl using:"
  echo
  echo "  eksctl get cluster"
  echo
}

# Main execution flow
main() {
  echo "Starting installation process for AWS CLI and eksctl on CentOS 9..."
  install_aws_cli
  install_eksctl
  post_install_message
}

# Execute main function
main
