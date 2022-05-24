# kube-cluster

## Existing VMs

My Dell server has in total 32 GB Ram.

## VMs for Kubernetes

Link: https://www.digitalocean.com/community/tutorials/how-to-create-a-kubernetes-cluster-using-kubeadm-on-ubuntu-20-04

### Prerequisites

* An SSH key pair on your local Linux/macOS/BSD machine
* Three servers running Ubuntu 20.04 with at least 2GB RAM and 2 vCPUs each. You should be able to SSH into each server as the root user with your SSH key pair

ForgeRock AM needs at least 4 GB Ram to run.

```
     Requests:
       cpu:      250m
       memory:   1800Mi
```

* control1: 8 GB Ram, 4 vCPUs, IP: 10.0.4.130
* worker1: 8 GB Ram, 4 vCPUs, IP: 10.0.4.131


## Do some initial setup of the servers

    $ ansible-playbook -i hosts initial.yml

##  Installing Kubernetetes’ Dependencies

    $ ansible-playbook -i hosts kube-dependencies.yml

## Setting Up the Control Plane Node

    $ ansible-playbook -i hosts control-plane.yml

## Setting Up the Worker Nodes

    $ ansible-playbook -i hosts workers.yml

## Creating some additional resources

    $ ansible-playbook -i hosts populate-cluster.yml

## Switching to new K8s cluster

    $ export KUBECONFIG=/Users/patrick/.kube/control1.yml


## Create namespace for forgeops

    $ kubectl create namespace forgeops-7-1-1

    $ kubectl apply -f pv-volume.yml
    $ kubectl apply -f pv-claim.yml

    $ kubectl get pv idrepo-pv-volume
    $ kubectl get pvc data-ds-idrepo-0

## Delete namespace

    kubectl delete ns forgeops-7-1-1

    kubectl delete pvc data-ds-idrepo-0


    kubectl drain <node-name> --ignore-daemonsets --delete-local-data
    kubectl uncordon <node name>

    kubectl describes pod


    patrick@Patricks-MBP forgeops-cli % kubectl get deployments
NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
ds-operator-ds-operator   1/1     1            1           25h
patrick@Patricks-MBP forgeops-cli % kubectl delete deployment ds-operator-ds-operator
deployment.apps "ds-operator-ds-operator" deleted

kubectl delete crd secretagentconfigurations.secret-agent.secrets.forgerock.io
kubectl delete crd directoryservices.directory.forgerock.io

https://platform9.com/blog/building-a-complete-stack-ingress-controllers/
https://kubernetes.github.io/ingress-nginx/deploy/baremetal/


 kubectl get node
   45  kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/namespace.yaml
   46  kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/metallb.yaml
   47  kubectl get node
   48  kubectl -n ingress-nginx get svc
   49  pwd
   50  vi metallb.yml
   51  kubectl apply -f metallb.yml
   52  kubectl -n ingress-nginx get svc
   53  curl -D- http://10.0.4.140 -H 'Host: dev.example.com'
   54  curl -D- http://10.0.4.131 -H 'Host: dev.example.com'
   55  kubectl get nodes -o wide
   56  kubectl get namespaces
   57  kubectl get services ingress-nginx-controller --namespace=ingress-nginx
   58  kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.0.0/deploy/static/provider/cloud/deploy.yaml
   59  kubectl get services ingress-nginx-controller --namespace=ingress-nginx
   60  curl 10.0.4.140
   61  curl 10.0.4.140/admin
   62  curl 10.0.4.140/am
   63  kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.0.0/deploy/static/provider/cloud/deploy.yaml
   64  kubectl get services ingress-nginx-controller --namespace=ingress-nginx
   65  history

