# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.provision "shell", inline: <<-SHELL
    # Install docker
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
    apt-get update
    apt-get install -qy docker.io apt-transport-https
    mkdir -p /etc/systemd/system/docker.service.d
    systemctl enable docker.service
   
    # Add kubernetes repo
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
    echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
    apt-get update
   
    # Install kubernetes
    apt-get -yq install kubelet kubernetes-cni
    
  SHELL

  config.vm.define "kube0" do |kube0|
    config.vm.hostname = "kube0"
    config.vm.network "private_network", ip: "10.0.0.1"
    config.vm.provision "shell", inline: <<-SHELL
      apt-get -y install kubeadm
      kubeadm init --kubernetes-version stable-1.14 --apiserver-advertise-address=10.0.0.1 --pod-network-cidr=10.0.1.0/24
    SHELL
  end

  config.vm.define "kube1" do |kube1|
    config.vm.hostname = "kube1"
    config.vm.network "private_network", ip: "10.0.0.2"
  end

  # config.vm.define "kube2" do |kube2|
  #   config.vm.hostname = "kube2"
  #   config.vm.network "private_network", ip: "10.0.0.3"
  # end
  
  # config.vm.define "kube3" do |kube3|
  #   config.vm.hostname = "kube3"
  #   config.vm.network "private_network", ip: "10.0.0.4"
  # end
  
  # config.vm.define "kube4" do |kube4|
  #   config.vm.hostname = "kube4"
  #   config.vm.network "private_network", ip: "10.0.0.5"
  # end

end
