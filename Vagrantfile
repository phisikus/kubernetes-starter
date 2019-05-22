# -*- mode: ruby -*-
# vi: set ft=ruby :
base_ip = "10.0.0."
subnet = "10.244.0.0/16"
kubernetes_version = "stable-1.14"
token = "kube00.0000000000000000"
# http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/overview?namespace=default
Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/bionic64"
  config.vm.provision "shell", path: "install-k8s.sh"
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end

  (0..2).each do |i| 
    name = "kube" + i.to_s
    address = base_ip + (i + 2).to_s
  
    config.vm.define name do |node|
      node.vm.hostname = name
      node.vm.network "private_network", ip: address
      if i == 0
        node.vm.provision "shell", inline: "kubeadm init" + 
        " --kubernetes-version #{kubernetes_version}" +
        " --apiserver-advertise-address=#{address}" +
        " --pod-network-cidr=#{subnet}" + 
        " --token #{token}\n"
        node.vm.provision "shell", path: "install-networking.sh"
        node.vm.provision "shell", path: "install-dashboard.sh"
       else
         first_address = base_ip + "2"
         node.vm.provision "shell", inline: "kubeadm join" +
         " #{first_address}:6443 --token #{token} --discovery-token-unsafe-skip-ca-verification\n"
      end
    end
  end
end

