# install ArgoCD in k8s
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

sleep 40 

# access ArgoCD UI
kubectl get svc -n argocd

# to open argo inside the VM
kubectl port-forward svc/argocd-server 8080:443 -n argocd


# to open argoCD outside the VM
minikube service argocd-server -n argocd


# login with admin user and below token (as in documentation):
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode && echo

# you can change and delete init password
# create an argoCD configuration file .yaml   ((((application.yml))))
#to apply that app as cluster you need to apply the application.yaml 
    # using kubectl apply -f application.yaml
