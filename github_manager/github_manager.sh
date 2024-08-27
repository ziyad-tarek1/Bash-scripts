#!/bin/bash

##########################################
# GitHub Repository Management Script    #
##########################################

# Load credentials from secret.sh
source ./secret.sh

# Set global Git configurations for user name and email using variables from secret.sh
git config --global user.name "$GITHUB_USER"  # Set Git username globally
git config --global user.email "$GITHUB_EMAIL"  # Set Git email globally


# Run the gh auth login command
gh auth login --hostname GitHub.com --git-protocol SSH --with-token < <(echo "$GITHUB_TOKEN")

# Configure the git protocol
gh config set -h github.com git_protocol ssh

###########################################################################
###########################################################################


# Function to push changes to an existing repository
push_to_existing_repo() {

    read -p "Enter the repository name: " repo_name
    read -p "Enter the directory whiich you want to push to the repository (e.g. /path/to/directory): " push_dir
    if [ ! -d "$push_dir" ]; then
        echo "Error: The directory '$push_dir' does not exist. Exiting..."
        exit 1
    fi

    cd $push_dir || { echo "Error: Failed to enter directory. Exiting..."; exit 1; }
    git init
    git add .
    git commit -m "Automated bush"
    git branch -M main
    git remote remove origin &> /dev/null
    git remote add origin git@github.com:$GITHUB_USER/$repo_name.git
    git push -u origin main
}
###########################################################################
###########################################################################


create_new_repo() {
    read -p "Enter the repository name: " repo_name
    read -p "Enter the description (optional): " description
    read -p "Is the repository private? (yes/no): " private
    private_flag="false"
    
    if [ "$private" == "yes" ]; then
        private_flag="true"
    fi

    # Check if the repository name is valid
    if [ -z "$repo_name" ]; then
        echo "Error: Repository name cannot be empty. Exiting..."
        exit 1
    fi

    # Use GitHub CLI to create the repository
    if ! gh repo create "$repo_name" --description "$description" --$([ "$private_flag" == "true" ] && echo "private" || echo "public"); then
        echo "Error: Failed to create repository. Exiting..."
        exit 1
    fi

    echo "Repository '$repo_name' created successfully."

    # Ask the user if they want to add a file to the new repository
    read -p "Do you want to add a file to the new repository? (yes/no): " add_file
    if [ "$add_file" == "yes" ]; then
        read -p "Enter the full path to the directory: " dir_path
        if [ ! -d "$dir_path" ]; then
            echo "Error: Directory not found. Exiting..."
            exit 1
        fi

        # Navigate to the directory and initialize a Git repository
        cd "$dir_path" || { echo "Error: Failed to enter directory. Exiting..."; exit 1; }

        # Initialize a Git repository if it doesn't exist
        if [ ! -d ".git" ]; then
            git init
        fi

        # Add all files in the directory to the repository
        git add .
        git commit -m "Initial commit"
        git branch -M main
        git remote add origin git@github.com:$GITHUB_USER/$repo_name.git
        git push -u origin main
    fi
}
###########################################################################
###########################################################################

delete_repository() {
    # Interactive confirmation prompt for repository deletion
    read -p "Enter the repository name that you want to delete: " del_repo
    read -p "Are you sure you want to delete the repository '$del_repo'? (yes/no): " confirm

    case "$confirm" in
        yes|YES|y|Y)
            # Use GitHub CLI to delete the specified repository with confirmation
            gh repo delete "$del_repo" --yes
            # Check if the deletion was successful
            if [ $? -eq 0 ]; then
                echo "Repository $del_repo deleted successfully."
            else
                echo "Error: Failed to delete repository $del_repo."
                exit 1
            fi
            ;;
        no|NO|n|N)
            echo "Repository deletion aborted."
            ;;
        *)
            echo "Invalid input. Aborting repository deletion."
            ;;
    esac
}

###########################################################################
###########################################################################
clone_repo() {
    read -p "Enter the repository link (e.g. https://github.com/user/repo.git): " repo_link
    read -p "Enter the directory where you want to clone the repository (e.g. /path/to/directory): " clone_dir

    # Check if the repository link is valid
    if [ -z "$repo_link" ]; then
        echo "Error: Repository link cannot be empty. Exiting..."
        exit 1
    fi

    # Check if the clone directory is valid
    if [ -z "$clone_dir" ]; then
        echo "Error: Clone directory cannot be empty. Exiting..."
        exit 1
    fi

    # Create the clone directory if it doesn't exist
    if [ ! -d "$clone_dir" ]; then
        mkdir -p "$clone_dir"
    fi

    # Clone the repository
    cd "$clone_dir" || { echo "Error: Failed to enter directory. Exiting..."; exit 1; }
    git clone "$repo_link" || { echo "Error: Failed to clone repository. Exiting..."; exit 1; }
    echo "Repository cloned successfully."
}

###########################################################################
###########################################################################

update-repo() {

read -p "Enter the repository link (e.g. https://github.com/user/repo.git): " repo_link
read -p "Enter the directory where you want to update from the repository (e.g. /path/to/directory): " update_dir
cd "$update_dir"
git pull origin main
echo "Git repository updated."


}

###########################################################################
###########################################################################

# Prompt for repository action
echo "Choose an option:"
echo "1) Use an existing repository (Push changes)"
echo "2) Create a new repository"
echo "3) Delete an existing repository"
echo "4) Clone a repository"
echo "5) update from existing repository"

read -p "Enter your choice (1, 2, 3, or 4): " choice

# Use a case statement to handle the user's choice and call the corresponding function
case "$choice" in
    1)

        push_to_existing_repo 
        ;;
    2)
        create_new_repo
        ;;
    3)
        delete_repository
        ;;
    4)
        clone_repo
        ;;
    5)
        update-repo() 
        ;;
    *)
        echo "Invalid choice. Exiting..."
        exit 2
        ;;
esac
