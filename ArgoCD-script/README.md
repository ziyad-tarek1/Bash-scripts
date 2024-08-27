ArgoCD Installation on Kubernetes
This guide details the installation process for ArgoCD, a declarative GitOps continuous delivery tool for Kubernetes.

Prerequisites:

A running Kubernetes cluster accessible via kubectl.
Steps:

Create the argocd namespace:


kubectl create namespace argocd


Install ArgoCD:


kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml   



This command downloads and applies the ArgoCD deployment manifest from the official repository.

Wait for ArgoCD deployment:
The script includes a sleep 40 command to allow some time for ArgoCD deployment. The actual time needed may vary depending on your environment. You can monitor the deployment status using kubectl get deployments -n argocd.

Find ArgoCD service details:

kubectl get svc -n argocd


This command displays information about Kubernetes services within the argocd namespace. Locate the service named argocd-server.

Access ArgoCD UI (choose one option):

a) Accessing ArgoCD inside the VM:

kubectl port-forward svc/argocd-server 8080:443 -n argocd


This command forwards port 443 (HTTPS) of the argocd-server service to port 8080 on your local machine, allowing you to access the ArgoCD UI at https://localhost:8080.

b) Accessing ArgoCD outside the VM (for Minikube environments):


minikube service argocd-server -n argocd


This command utilizes Minikube capabilities to expose the argocd-server service outside the virtual machine. Minikube will provide the URL to access the ArgoCD UI.

Login to ArgoCD:

Retrieve the initial admin password:


kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode && echo


This command retrieves the initial admin password stored in a Kubernetes secret and displays it on your terminal.

Use the displayed password to login to the ArgoCD UI.

Configure ArgoCD (Optional):

The script does not cover ArgoCD configuration. Refer to the official documentation for creating an ArgoCD configuration file (application.yaml) and applying applications to your cluster using kubectl apply -f application.yaml.
Additional Notes:

The provided script serves as a basic installation guide. You might need to adjust it based on your specific environment and desired configuration.
For production deployments, consider using a dedicated password manager for the initial admin password.
Explore the official ArgoCD documentation for detailed instructions and advanced configurations: https://argo-cd.readthedocs.io/en/stable/
