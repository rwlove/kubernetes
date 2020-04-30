#!/bin/bash

if [ -d /home/rwlove/.kube ] ; then
    echo "#### Delete /home/rwlove/.kube since it exists ####"
    rm -rf /home/rwlove/.kube
fi

echo "#### Initialize the K8S Cluster ####"
sudo kubeadm init --config /home/rwlove/kubernetes/init.config

echo "#### Copy K8S config ####"
sudo mkdir /home/rwlove/.kube
sudo cp -f /etc/kubernetes/admin.conf /home/rwlove/.kube/config
sudo chown -R rwlove.rwlove /home/rwlove/.kube

echo "#### Update --node-ip=192.168.1.1 in /var/lib/kubelet/kubeadm-flags.env ####"
sudo sed -i 's/\"$/ --node-ip=192.168.1.1\"/g' /var/lib/kubelet/kubeadm-flags.env

echo "#### Restart the kubelet ####"
sudo systemctl restart kubelet.service

echo "#### Untaint Master ####"
kubectl taint nodes --all node-role.kubernetes.io/master-

echo "#### Set net.ipv4.conf.all.rp_filter to 0 ####"
sudo sysctl -w net.ipv4.conf.all.rp_filter=0
