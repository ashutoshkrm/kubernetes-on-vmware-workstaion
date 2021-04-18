# kubernetes-on-vmware-workstaion
Kubernetes On VMware Workstation

Step 1: Create Admin service account
vim admin-sa.yml
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: ashutosh-admin
  namespace: kube-system
  
`kubectl apply -f admin-sa.yml`

Step 2: Create a Cluster Role Binding
vim admin-rbac.yml
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: ashutosh-admin
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
  - kind: ServiceAccount
    name: ashutosh-admin
    namespace: kube-system
	
`kubectl apply -f admin-rbac.yml`

# Accessing Kubernetes Dashboard
kubectl get services -o wide --all-namespaces | grep dashboard

Step 3: Obtain admin user token
SA_NAME="ashutosh-admin"

# Get Security Token 
sudo kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep ${SA_NAME} | awk '{print $1}')

# if access from other client hosts, set port-forwarding
sudo kubectl port-forward -n kubernetes-dashboard service/kubernetes-dashboard --address 0.0.0.0 10443:443

kubectl create deployment php-web --image=ashutoshkm/php

kubectl run php-web --image=ashutoshkm/php --port=80
kubectl expose pod http-web --name=php-service --port=80 --type=NodePort service/php-service exposed
kubectl get pods php-web -o wide
