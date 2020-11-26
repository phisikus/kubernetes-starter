# kubernetes-starter

## What is it?
This repository contains Vagrant configuration that you can use to set up multi-node kubernetes cluster.
```bash
vagrant up
```
## How does it work?
The Vagrantfile contains definition of ubuntu-based VMs where the first VM (named kube0) is provisioned as master node that initializes kubernetes cluster. Subsequent machines (named kube1, kube2 ...) also start from the same base image but use common token to join existing cluster.
By default the local directory is shared with master node and kubernetes _config_ file will be created so you can put it in _~/.kube/config_ and use tools such as kubectl.
```bash
-> cp config ~/.kube/config
-> kubectl get nodes
NAME    STATUS   ROLES    AGE     VERSION
kube0   Ready    master   7m26s   v1.14.2
kube1   Ready    <none>   5m23s   v1.14.2
kube2   Ready    <none>   3m14s   v1.14.2
kube3   Ready    <none>   62s     v1.14.2
```
By default 4 nodes are created but you can adjust that number in the Vagrantfile (using _count_ variable).

## What else do I get?
After initialization of the base kubernetes, additional plugins are installed such as flannel networking layer and Dashboard UI.
For security reasons the script creates separate account for accessing the Dashboard and you can find authentication token in the provisioning log of the master node (the log line starts with "Admin token for dashboard:").
Make sure that you have access to the cluster from your local terminal by using config file (as described previously) and set up proxy:
```bash
kubectl proxy
```

You can access the dashboard using:
<http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#!/overview?namespace=default>
