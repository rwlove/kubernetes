#!/bin/bash

KUBE_CREATE='kubectl create'

echo "############"
echo "Install Grocy from Helm"
echo "######"
${KUBE_CREATE} ns grocy

${KUBE_CREATE} -f manifests/volumes/grocy-pv.yaml

helm repo add billimek https://billimek.com/billimek-charts/

helm install -n grocy grocy -f helm/grocy.yaml billimek/grocy

echo "Default username: admin"
echo "Default password: admin"
