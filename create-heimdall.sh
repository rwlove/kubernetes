#!/bin/bash

KUBE_CREATE='kubectl create'

echo "############"
echo "Install Heimdall from Helm"
echo "######"
${KUBE_CREATE} ns heimdall

#${KUBE_CREATE} -f manifests/volumes/heimdall-pv.yaml

helm repo add billimek https://billimek.com/billimek-charts/

helm install \
     -n heimdall \
     heimdall \
     --set timezone="America/Los_Angeles" \
     --set Service.loadBalancerIP="192.168.6.27" \
     -f helm/heimdall.yaml billimek/heimdall
