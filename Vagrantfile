# -*- mode: ruby -*-
# vi: set ft=ruby :
base_ip = "10.0.0."
subnet = "10.0.1.0/24"
kubernetes_version = "stable-1.14"
token = "kube00.0000000000000000"
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.provision "shell", path: "install-k8s.sh"

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
        node.vm.provision "shell", inline: "
        export KUBECONFIG=/etc/kubernetes/admin.conf
        kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter.yaml"        
       else
         first_address = base_ip + "2"
         node.vm.provision "shell", inline: "kubeadm join" +
         " #{first_address}:6443 --token #{token} --discovery-token-unsafe-skip-ca-verification\n"
      end
    end
  end
end

