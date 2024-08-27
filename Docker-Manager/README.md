Title: Docker Hub Image Push Script

Description:

This script streamlines pushing Docker images to Docker Hub by automating login and image tagging. It leverages a separate file (secret.sh) to securely store login credentials.

Usage:

Create a file named secret.sh:

Add the following lines to secret.sh, replacing the placeholders with your actual credentials( you can use the secret-template)



DOCKERHUB_USER=your_dockerhub_username
DOCKERHUB_PASSWORD=your_dockerhub_password

Ensure the secret.sh file has appropriate permissions (read-only for the script user).

Run the script:

bash docker_manager.sh

Follow the prompts:

Enter the image name and tag (e.g., flask-app:1.0).
Choose the appropriate option based on whether the image is already tagged with your Docker Hub username.
Security Note:

Never commit the secret.sh file to your version control system.

Author:

GitHUB-user: ziyad-tarek1
Linkedin: https://www.linkedin.com/in/ziyad-tarek-61a38818b/

Contact:

ziyadtarek180@gmail.com

Additional Notes:

This script demonstrates a basic approach. Consider additional functionalities like error handling for login failures or push errors.
This README.md provides clear instructions and highlights security considerations for using the script effectively.
