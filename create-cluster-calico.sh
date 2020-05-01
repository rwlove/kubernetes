#!/bin/bash

if [ -d ${HOME}/.kube ] ; then
    echo "#### Delete ${HOME}/.kube since it exists ####"
    rm -rf ${HOME}/.kube
fi

echo "#### Initialize the K8S Cluster ####"
sudo kubeadm init --config ${HOME}/kubernetes/init.config

echo "#### Copy K8S config ####"
sudo mkdir ${HOME}/.kube
sudo cp -f /etc/kubernetes/admin.conf ${HOME}/.kube/config
sudo chown -R ${USER}.${USER} ${HOME}/.kube

echo "#### Update --node-ip=192.168.1.1 in /var/lib/kubelet/kubeadm-flags.env ####"
sudo sed -i 's/\"$/ --node-ip=192.168.1.1\"/g' /var/lib/kubelet/kubeadm-flags.env

echo "#### Restart the kubelet ####"
sudo systemctl restart kubelet.service

echo "#### Untaint Master ####"
kubectl taint nodes --all node-role.kubernetes.io/master-

echo "#### Set net.ipv4.conf.all.rp_filter to 0 ####"
sudo sysctl -w net.ipv4.conf.all.rp_filter=0
