#!/bin/bash

KUBE_CREATE='kubectl create'

${KUBE_CREATE} ns jackett

${KUBE_CREATE} -f manifests/volumes/jackett-pv.yaml

echo "############"
echo "Create jackett"
echo "######"

helm repo add billimek https://billimek.com/billimek-charts/

helm install -n jackett jackett -f helm/jackett.yaml billimek/jackett
