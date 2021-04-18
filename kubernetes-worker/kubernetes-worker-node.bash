sudo apt update
sudo apt -y upgrade
sudo apt update
sudo hostnamectl set-hostname k8worker01.ashutosh.com	  
hostnamectl		  
sudo tee /etc/hosts<<EOF
127.0.0.1 k8worker01.ashutosh.com k8s-worker01 localhost
192.168.10.129 k8master.ashutosh.com
192.168.10.130 k8worker01.ashutosh.com	
192.168.10.131 k8worker02.ashutosh.com	
EOF
# Install docker engine
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
## Configure systemctl
sudo modprobe overlay
sudo modprobe br_netfilter
sudo tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF


sudo apt -y install curl apt-transport-https wget vim net-tools
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt -y install kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo kubectl version --client && kubeadm version
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo swapoff -a


# Initialize master node
lsmod | grep br_netfilter
sudo systemctl enable kubelet
sudo kubeadm join 192.168.10.129:6443 --token oqtbwo.1fuv9yj01im38k6u --discovery-token-ca-cert-hash sha256:40c078f1ad319a9bfe31c4fe51e539f8528d5eec4fc3e41fea67201c8c9566a7



