#!/bin/bash

# Function to push changes to an existing repository
push_to_existing_repo() {
    # Check if the directory exists
    if [ ! -d "$2" ]; then
        echo "Error: The directory '$2' does not exist. Exiting..."
        exit 1
    fi

    # Navigate into the directory with the content to push
    cd $2 || { echo "Error: Failed to enter directory. Exiting..."; exit 1; }

    # Initialize the repository (if not already done)
    git init

    # Add all files to the repository
    git add .

    # Commit the changes
    git commit -m "First commit"

    # Create the 'main' branch (if not already created)
    git branch -M main

    # Set up the remote origin (remove if it exists)
    git remote remove origin &> /dev/null
    git remote add origin git@github.com:ziyad-tarek1/$1.git

    # Push to the main branch
    git push -u origin main
}

echo "Choose an option:"
echo "1) Use an existing repository (Push changes)"
echo "2) Create a new repository"
echo "3) Delete an existing repository"
echo "4) Clone a repository"
read -p "Enter your choice (1, 2, 3, or 4): " choice

if [ "$choice" -eq 1 ]; then
    read -p "Enter the repository name: " repo_name
    read -p "Enter the full path to the file or folder to push to GitHub: " file_path
    push_to_existing_repo $repo_name $file_path
else
    echo "Other options are not implemented in this example."
fi
