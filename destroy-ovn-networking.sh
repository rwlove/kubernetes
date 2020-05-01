#!/bin/bash

echo "#### Delete ovnkube daemonset for nodes ####"
kubectl delete -f $HOME/kubernetes/ovn-kubernetes/ovn-kubernetes/dist/yaml/ovnkube-node.yaml

echo "#### Delete ovnkube-master deployment ####"
kubectl delete -f $HOME/kubernetes/ovn-kubernetes/ovn-kubernetes/dist/yaml/ovnkube-master.yaml

echo "#### Delete ovnkube-db deployment. ####"
kubectl delete -f $HOME/kubernetes/ovn-kubernetes/ovn-kubernetes/dist/yaml/ovnkube-db.yaml

echo "#### Delete OVN namespace, service accounts, ovnkube-db headless service, configmap, and policies ####"
kubectl delete -f $HOME/kubernetes/ovn-kubernetes/ovn-kubernetes/dist/yaml/ovn-setup.yaml


