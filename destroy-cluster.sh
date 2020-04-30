#!/bin/bash

echo "#### Drain brain.thesteamedcrab.com ####"
kubectl drain brain.thesteamedcrab.com --delete-local-data --force --ignore-daemonsets

echo "#### Delete node brian.thesteamedcrab.com ####"
kubectl delete node brain.thesteamedcrab.com

echo "#### Reset (destroy) the K8S Cluster ####"
sudo kubeadm reset -f init.config

echo "#### Delete contents of /etc/cni/net.d ####"
sudo rm -rf /etc/cni/net.d/*

if [ -d /home/rwlove/.kube ] ; then
    echo "#### Delete /home/rwlove/.kube since it exists ####"
    rm -rf /home/rwlove/.kube
fi
