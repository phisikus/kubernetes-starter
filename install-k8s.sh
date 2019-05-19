#!/bin/sh

# Install docker
apt-get update
apt-get install -qy docker.io apt-transport-https
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
   },
   "storage-driver": "overlay2"
}
EOF
mkdir -p /etc/systemd/system/docker.service.d
systemctl enable docker.service
systemctl daemon-reload
systemctl restart docker

# Add kubernetes repo
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
apt-get update

# Install kubernetes
apt-get -yq install kubelet kubeadm kubernetes-cni

