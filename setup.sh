#!/bin/bash

# Update the package list and upgrade all packages
sudo apt-get update -y
sudo apt-get upgrade -y

# Install necessary dependencies for both Docker and Ansible
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    lsb-release \
    gnupg
# Install necessary dependencies
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    conntrack

# Install Docker
echo "--------------------Installing Docker--------------------"
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Add your user to the Docker group to manage Docker as a non-root user
sudo usermod -aG docker $USER

# Install Ansible
echo "--------------------Installing Ansible--------------------"
sudo apt-get update -y
sudo apt-get install -y ansible

# Print installation summary
echo "Installation of Docker and Ansible completed successfully."


########################
# Update the package list and upgrade all packages
sudo apt-get update -y
sudo apt-get upgrade -y

#####################
# Install kubectl
echo "--------------------Installing kubectl--------------------"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install Minikube
echo "--------------------Installing Minikube--------------------"
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Start Minikube (using the Docker driver)
echo "--------------------Starting Minikube--------------------"
minikube start --driver=docker

# Print installation summary
echo "Installation of Docker, kubectl, and Minikube completed successfully."

# Reboot the system to apply group changes (Docker group membership)
sudo reboot

###################


# Update the package list and upgrade all packages
sudo apt-get update -y
sudo apt-get upgrade -y

# Install Java (Jenkins requires Java)
echo "--------------------Installing Java--------------------"
sudo apt-get install -y openjdk-17-jdk

# the jdk path is /usr/lib/jvm/java-17-openjdk-amd64/ 
# it should be in  JAVA_HOME field


# Install Jenkins
echo "--------------------Installing Jenkins--------------------"
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Install Terraform
echo "--------------------Installing Terraform--------------------"
sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | \
  sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
  https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
  sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update -y
sudo apt-get install -y terraform

# Install AWS CLI
echo "--------------------Installing AWS CLI--------------------"
sudo apt-get install -y zip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Install eksctl
echo "--------------------Installing eksctl--------------------"
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | \
  tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

# Install Helm
echo "--------------------Installing Helm--------------------"
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Print installation summary
echo "Installation of Jenkins, Terraform, AWS CLI, eksctl, and Helm completed successfully."


-----------------------------------

# Pull the Trivy Docker image
sudo docker pull aquasec/trivy:latest

# Example usage to scan an image
# sudo docker run --rm aquasec/trivy image ziyadtarek99/piano-project:1.0
#sudo docker run --rm aquasec/trivy image --severity HIGH --format table --misconf ziyadtarek99/piano-project:1.0 > trivy_report.txt

# Pull the SonarQube Docker image (use the developer edition for minimal resource usage)
sudo docker pull sonarqube:community

# Run SonarQube
sudo docker run -d --name sonarqube \
    -p 9000:9000 \
    -e SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true \
    -v sonarqube_conf:/opt/sonarqube/conf \
    -v sonarqube_data:/opt/sonarqube/data \
    -v sonarqube_logs:/opt/sonarqube/logs \
    -v sonarqube_extensions:/opt/sonarqube/extensions \
    sonarqube:community
