#!/bin/bash

# Install Kubernetes Dashboard
# http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/overview?namespace=default
export KUBECONFIG=/etc/kubernetes/admin.conf
sudo apt-get install -y jq
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml

# Create admin account for accessing kubernetes dashboard
kubectl create -n kube-system serviceaccount admin
kubectl create clusterrolebinding admin \
	--clusterrole=cluster-admin \
	--group=system:serviceaccounts


# Find and print authentication token
get_token () {
	export TOKEN_NAME=`kubectl get serviceaccount -n kube-system admin -o json | jq -er '.secrets[0].name'`
}
get_token
while [[ $TOKEN_NAME != *admin-token* ]]
do
	echo "Waiting for secret to be set..."
	sleep 1s
	get_token
done


export DASHBOARD_TOKEN=`kubectl get secrets $TOKEN_NAME -n kube-system -o json | jq -r '.data.token' | base64 --decode`
echo "Admin token for dashboard: $DASHBOARD_TOKEN"
