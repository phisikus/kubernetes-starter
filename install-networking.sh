#!/bin/sh

# Install Flannel networking layer
export KUBECONFIG=/etc/kubernetes/admin.conf
wget https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
## Change used interface to avoid routing errors due to default usage of first interface (which uses NAT)
cat kube-flannel.yml | sed 's/--kube-subnet-mgr/--kube-subnet-mgr\n        - --iface=enp0s8/' > flannel.yml
rm kube-flannel.yml
kubectl apply -f flannel.yml
kubectl taint nodes --all node-role.kubernetes.io/master-
rm flannel.yml
