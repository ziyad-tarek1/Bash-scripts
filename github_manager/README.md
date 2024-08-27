# Before initializing using this script kindly note the below:
  # install gh package
  # create a secret.sh and use the secret-template.sh as a refrence for you

# add the ssh key from your machine into your github account otherwise you will not be able to ssh on the github
# fot this follow the below steps

#Step 1: Verify SSH Key (Check if you have an SSH key already set up on your system:)
ls -al ~/.ssh
#You should see a file named id_rsa and id_rsa.pub. If you don't see them, you need to generate a new SSH key.

#Step 2: Generate a New SSH Key (if needed)
ssh-keygen

#Step 3: Add SSH Key to SSH-Agent (Ensure the SSH key is added to the SSH agent:)

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa


#Step 4: Add SSH Key to GitHub (Copy the SSH key to your clipboard:)

cat ~/.ssh/id_rsa.pub

#Go to GitHub SSH and GPG keys settings (https://github.com/settings/keys) , click New SSH Key, and paste the key you copied.

#Step 5: Test the SSH Connection (Test if the SSH connection to GitHub is working:)
ssh -T git@github.com
#You should see a message like:

Hi username! You've successfully authenticated, but GitHub does not provide shell access.

Title: GitHub Repository Management Script

Description:

This Bash script simplifies managing your GitHub repositories from the command line. It leverages the GitHub CLI (gh) for authentication and repository actions.

Requirements:

Bash shell
GitHub CLI (gh) installed and configured
Installation:

Install the GitHub CLI following the official instructions: https://cli.github.com/

Configure your GitHub credentials for the CLI: https://cli.github.com/manual/gh_auth_login

(Optional) Save the script as manage_repos.sh and make it executable:


chmod +x github_manager.sh


Usage:

1-Run the script:
bash github_manager.sh


2-Follow the on-screen prompts to choose the desired action:

  1. Use an existing repository (Push changes)
  2. Create a new repository
  3. Delete an existing repository
  4. Clone a repository
  5. Update from existing repository
Security:

Secret File: The script utilizes a separate file (secret.sh) to store your GitHub username and access token. This file should be excluded from version control (e.g., .gitignore).
Features:

Push to Existing Repository: Allows pushing code changes to an existing repository.
Create New Repository: Guides you through creating a new repository with options for description and private/public visibility.
Delete Existing Repository: Provides a confirmation prompt before deleting a repository using the GitHub CLI.
Clone a Repository: Clones a repository from a provided URL into a specified directory.
Update from Existing Repository: Pulls the latest changes from the remote repository into your local working directory.
Error Handling:

The script includes basic error handling for invalid user input, missing directories, and failed commands.

Additional Notes:

Consider customizing the script to suit your workflow (e.g., adding pre-commit checks before pushing).
Explore the GitHub CLI documentation for more advanced functionalities: https://cli.github.com/manual/


Author:

GitHUB-user: ziyad-tarek1
Linkedin: https://www.linkedin.com/in/ziyad-tarek-61a38818b/

Contact:

ziyadtarek180@gmail.com

Disclaimer:

This script is provided for educational purposes only. Use it at your own risk and ensure proper backups before performing any actions on your repositories.

