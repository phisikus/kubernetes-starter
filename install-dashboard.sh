#!/bin/sh

# Install Kubernetes Dashboard
# http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/overview?namespace=default
export KUBECONFIG=/etc/kubernetes/admin.conf
sudo apt install -y jq
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended/kubernetes-dashboard.yaml

# Create admin account for accessing kubernetes dashboard
kubectl create -n kube-system serviceaccount admin
kubectl create clusterrolebinding admin \
  --clusterrole=cluster-admin \
  --group=system:serviceaccounts

# Find and print authentication token
TOKEN_NAME=`kubectl get serviceaccount -n kube-system admin -o json | jq -r '.secrets[0].name'`  
export DASHBOARD_TOKEN=`kubectl get secrets $TOKEN_NAME -n kube-system -o json | jq -r '.data.token' | base64 --decode`
echo "Admin token for dashboard: $DASHBOARD_TOKEN"
