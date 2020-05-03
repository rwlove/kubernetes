#!/bin/bash

if [ -d ${HOME}/.kube ] ; then
    echo "#### Delete ${HOME}/.kube since it exists ####"
    rm -rf ${HOME}/.kube
fi

echo "#### Get local IP Address (eno1) ####"
ip_addr=$(ip addr show dev eno1 | grep inet | grep -v inet6 | awk '{ print $2 }' | cut -d '/' -f 1)

echo "#### Update local IP Address in init.config ####"
sudo sed "s/MASTER_IP/${ip_addr}/g" < ${HOME}/kubernetes/init.config.orig > ${HOME}/kubernetes/init.config.orig

echo "#### Initialize the K8S Cluster ####"
sudo kubeadm init --ignore-preflight-errors=Service-Docker,IsDockerSystemdCheck,SystemVerification --config ${HOME}/kubernetes/init.config

echo "#### Copy K8S config ####"
sudo mkdir ${HOME}/.kube
sudo cp -f /etc/kubernetes/admin.conf ${HOME}/.kube/config
sudo chown -R ${USER}.${USER} ${HOME}/.kube

echo "#### Update --node-ip=${ip_addr} in /var/lib/kubelet/kubeadm-flags.env ####"
sudo sed -i "s/\"$/ --node-ip=${ip_addr}\"/g" /var/lib/kubelet/kubeadm-flags.env

echo "#### Restart the kubelet ####"
sudo systemctl restart kubelet.service

echo "#### Untaint Master ####"
kubectl taint nodes --all node-role.kubernetes.io/master-

echo "#### Set net.ipv4.conf.all.rp_filter to 0 ####"
sudo sysctl -w net.ipv4.conf.all.rp_filter=0
