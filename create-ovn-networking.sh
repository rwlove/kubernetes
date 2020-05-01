#!/bin/bash

echo "#### Build the daemonset ####"
pushd $HOME/kubernetes/ovn-kubernetes/ovn-kubernetes/dist/images
./daemonset.sh --image=docker.io/ovnkube/ovn-daemonset-u:latest \
	       --net-cidr=10.10.0.0/16 --svc-cidr=172.16.1.0/24 \
	       --gateway-mode="local" \
	       --k8s-apiserver=https://$MASTER_IP:6443
popd

echo "#### Create OVN namespace, service accounts, ovnkube-db headless service, configmap, and policies ####"
kubectl create -f $HOME/kubernetes/ovn-kubernetes/ovn-kubernetes/dist/yaml/ovn-setup.yaml

echo "#### Run ovnkube-db deployment. ####"
kubectl create -f $HOME/kubernetes/ovn-kubernetes/ovn-kubernetes/dist/yaml/ovnkube-db.yaml

echo "#### Run ovnkube-master deployment ####"
kubectl create -f $HOME/kubernetes/ovn-kubernetes/ovn-kubernetes/dist/yaml/ovnkube-master.yaml

echo "#### Run ovnkube daemonset for nodes ####"
kubectl create -f $HOME/kubernetes/ovn-kubernetes/ovn-kubernetes/dist/yaml/ovnkube-node.yaml
