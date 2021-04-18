# kubernetes-on-vmware-workstaion
Kubernetes On VMware Workstation

Step 1: Create Admin service account

`kubectl apply -f admin-sa.yml`

Step 2: Create a Cluster Role Binding

`kubectl apply -f admin-rbac.yml`

# Accessing Kubernetes Dashboard

`kubectl get services -o wide --all-namespaces | grep dashboard`

Step 3: Obtain admin user token

`SA_NAME="kube-admin"`

# Get Security Token 

`sudo kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep ${SA_NAME} | awk '{print $1}')`

# if access from other client hosts, set port-forwarding

`sudo kubectl port-forward -n kubernetes-dashboard service/kubernetes-dashboard --address 0.0.0.0 10443:443`

`kubectl create deployment php-web --image=ashutoshkm/php`

`kubectl run php-web --image=ashutoshkm/php --port=80`

`kubectl expose pod http-web --name=php-service --port=80 --type=NodePort service/php-service exposed`

`kubectl get pods php-web -o wide`
