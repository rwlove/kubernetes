#!/bin/bash

if [ -d ${HOME}/.kube ] ; then
    echo "#### Delete ${HOME}/.kube since it exists ####"
    rm -rf ${HOME}/.kube
fi

#echo "#### Get local IP Address (eno1) ####"
#ip_addr=$(ip addr show dev eno1 | grep inet | grep -v inet6 | awk '{ print $2 }' | cut -d '/' -f 1)

#echo "#### Update local IP Address in init.config ####"
#sed "s/MASTER_IP/${ip_addr}/g" < ${HOME}/kubernetes/init.config.orig > ${HOME}/kubernetes/init.config

echo "#### Initialize the K8S Cluster ####"
kubeadm init --pod-network-cidr=32.32.0.0/16

echo "#### Copy K8S config ####"
mkdir ${HOME}/.kube
cp -f /etc/kubernetes/admin.conf ${HOME}/.kube/config
chown -R ${USER}.${USER} ${HOME}/.kube

#echo "#### Update --node-ip=${ip_addr} in /var/lib/kubelet/kubeadm-flags.env ####"
#sed -i "s/\"$/ --node-ip=${ip_addr}\"/g" /var/lib/kubelet/kubeadm-flags.env

#echo "#### Restart the kubelet ####"
#sudo systemctl restart kubelet.service

echo "#### Untaint Master ####"
kubectl taint nodes --all node-role.kubernetes.io/master-

echo "#### Set net.ipv4.conf.all.rp_filter to 0 ####"
sudo sysctl -w net.ipv4.conf.all.rp_filter=0

join_cmd=`kubeadm token create --print-join-command`

for worker in worker1.thesteamedcrab.com worker2.thesteamedcrab.com worker3.thesteamedcrab.com ; do
    echo "########## Joining $worker to the Cluster #"
    ssh $worker $join_cmd
done
