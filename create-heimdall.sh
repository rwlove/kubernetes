#!/bin/bash

KUBE_CREATE='kubectl create'

echo "############"
echo "Install Heimdall from Helm"
echo "######"
${KUBE_CREATE} ns heimdall

${KUBE_CREATE} -f manifests/volumes/heimdall-pv.yaml

helm repo add k8s-at-home https://k8s-at-home.com/charts/

helm install \
     -n heimdall \
     heimdall \
     --set timezone="America/New_York" \
     --set service.type=LoadBalancer \
     --set service.loadBalancerIP="192.168.6.27" \
     --set persistence.config.storageClass="heimdall-storage-class" \
     k8s-at-home/heimdall
