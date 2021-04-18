sudo apt update
echo "[TASK 1] Upgrading Ubuntu-20.4 LTS"
sudo apt -y upgrade
sudo apt update
sudo ufw status verbose
sudo ufw disable
sudo ufw allow 6443/tcp
sudo apt-get install -y ubuntu-desktop
sudo systemctl set-default graphical.target
echo "[TASK 2] Setting Hostname"
sudo hostnamectl set-hostname k8master.ashutosh.com		  
sudo hostnamectl		  
sudo tee /etc/hosts<<EOF
127.0.0.1 k8master.ashutosh.com k8master localhost
192.168.10.129 k8master.ashutosh.com
192.168.10.130 k8worker01.ashutosh.com	
192.168.10.131 k8worker02.ashutosh.com	
EOF
echo "[TASK 3] Installing Docker Engine"
sudo apt install apt-transport-https ca-certificates curl software-properties-common gnupg-agent -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-cache policy docker-ce
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io vim git curl wget 
sudo docker ––version
sudo systemctl enable docker
sudo systemctl start docker
docker info
sudo modprobe overlay
sudo modprobe br_netfilter
sudo tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

echo "[TASK 4] Installing Kubernetes Packages"
sudo apt -y install curl apt-transport-https wget vim net-tools
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt -y install kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo kubectl version --client && kubeadm version
echo "[TASK 5] Disabling Swap"
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo swapoff -a

echo "[TASK 6] Initialize master node"
lsmod | grep br_netfilter
sudo systemctl enable kubelet
sudo kubeadm config images pull
sudo kubeadm init --apiserver-advertise-address=k8master.ashutosh.com --pod-network-cidr=10.244.0.0/16  --ignore-preflight-errors=all
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
# sudo kubectl apply -f https://docs.projectcalico.org/v3.14/manifests/calico.yaml
echo "[TASK 7] Get Kubernetes Cluster Info"
kubectl get all
kubectl get pods --all-namespaces
kubectl get nodes


