#!/bin/bash

KUBE_CREATE='kubectl create'

echo "############"
echo "Install Grocy from Helm"
echo "######"
${KUBE_CREATE} ns grocy

${KUBE_CREATE} -n grocy manifests/volumes/kanboard-pv.yaml

helm repo add billimek https://billimek.com/billimek-charts/

helm install -n grocy grocy -f helm/grocy.yaml billimek/grocy
