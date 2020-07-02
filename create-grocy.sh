#!/bin/bash

KUBE_CREATE='kubectl create'

echo "############"
echo "Install Grocy from Helm"
echo "######"
${KUBE_CREATE} -f manifests/volumes/grocy-pv.yaml

${KUBE_CREATE} ns grocy

helm repo add billimek https://billimek.com/billimek-charts/

helm install -n grocy grocy -f helm/grocy.yaml billimek/grocy
