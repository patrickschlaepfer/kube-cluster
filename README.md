# kube-cluster

## Existing VMs

My Dell server has in total 32 GB Ram.

* Ubuntu:  8 CPUs, 12 GB Ram
* opensense: 8 CPUs, 4 GB Ram
* pihole: 4 CPUs, 4 GB Ram

Left over RAM: 12 GB

## VMs for Kubernetes

Link: https://www.digitalocean.com/community/tutorials/how-to-create-a-kubernetes-cluster-using-kubeadm-on-ubuntu-20-04

### Prerequisites

* An SSH key pair on your local Linux/macOS/BSD machine
* Three servers running Ubuntu 20.04 with at least 2GB RAM and 2 vCPUs each. You should be able to SSH into each server as the root user with your SSH key pair

ForgeRock AM needs at least 4 GB Ram to run.

     Requests:                                                                                                                          │
│       cpu:      250m                                                                                                                   │
│       memory:   1800Mi

* control1: 4 GB Ram, 4 vCPUs
* worker1: 4 GB Ram, 4 vCPUs


## Do some initial setup of the servers

    $ ansible-playbook -i hosts initial.yml

##  Installing Kubernetetes’ Dependencies

    $ ansible-playbook -i hosts kube-dependencies.yml

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