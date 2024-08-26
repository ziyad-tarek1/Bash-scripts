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

