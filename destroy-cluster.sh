#!/bin/bash


reset_cmd='kubeadm reset -f'

for worker in worker1.thesteamedcrab.com \
	      worker2.thesteamedcrab.com \
	      worker3.thesteamedcrab.com \
	      ; do
    echo "#### Drain $worker ####"
    kubectl drain $worker --delete-local-data --force --ignore-daemonsets
    kubectl delete $worker
done

kubectl drain master.thesteamedcrab.com \
	--delete-local-data --force --ignore-daemonsets

echo "#### Reset (destroy) the K8S Cluster ####"
sudo kubeadm reset -f init.config

echo "#### Delete contents of /etc/cni/net.d ####"
sudo rm -rf /etc/cni/net.d/*

if [ -d ${HOME}/.kube ] ; then
    echo "#### Delete ${HOME}/.kube since it exists ####"
    rm -rf ${HOME}/.kube
fi

for worker in worker1.thesteamedcrab.com \
	      worker2.thesteamedcrab.com \
	      worker3.thesteamedcrab.com \
	      ; do
    echo "#### Reset $worker ####"
    ssh $worker "$reset_cmd"
    echo "#### Clear /etc $worker ####"
    ssh $worker "rm -rf /etc/cni /etc/kubernetes"
    echo "#### Clear iptables $worker ####"
    ssh $worker "iptables -F && iptables -X && \
    		 iptables -t nat -F && iptables -t nat -X && \
                 iptables -t raw -F && iptables -t raw -X && \
    		 iptables -t mangle -F && iptables -t mangle -X"
    echo "#### Restart docker $worker ####"
    ssh $worker "systemctl restart docker"
done
