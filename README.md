# kubernetes-starter

## What is it?
This repository contains Vagrant configuration that you can use to set up multi-node kubernetes cluster.
```bash
vagrant up
```
## How does it work?
The Vagrantfile contains definition of ubuntu-based VMs where the first VM (named kube0) is provisioned as master node that initializes kubernetes cluster. Subsequent machines (named kube1, kube2 ...) also start from the same base image but use common token to join existing cluster.
By default the local directory is shared with master node and kubernetes _config_ file will be created so you can put it in _~/.kube/config_ and use tools such as kubectl.


## What else do i get?
After initialization of the base kubernetes, additional plugins are installed such as flannel networking layer and Dashboard UI.
For security reasons the script creates separate account for accessing the Dashboard and you can find authentication token in the provisioning log of the master node (the log line starts with "Admin token for dashboard:").
Make sure that you have access to the cluster from your local terminal by using config file (as described previously) and set up proxy:
```bash
kubectl proxy
```

You can access the dashboard using:
<http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/overview?namespace=default>