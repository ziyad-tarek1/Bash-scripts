#!/bin/bash

# Ask the user for the number of packages they want to install
echo "How many packages do you want to install?"
read -r num_packages

# Create an empty array to store the package names
packages=()

# Ask the user for the names of the packages
for ((i=0; i<num_packages; i++)); do
  echo "Enter package ${i+1} name:"
  read -r package
  packages+=("$package")
done

# Update package lists before installation
sudo apt-get update

# Install listed packages using apt-get
for package in "${packages[@]}"; do
  sudo apt-get install "$package" -y
  echo "$package installed successfully."
done

echo "Packages installed successfully."
