#!/bin/bash

KUBE_CREATE='kubectl create'

echo "############"
echo "Install Grocy from Helm"
echo "######"
${KUBE_CREATE} ns mailu

${KUBE_CREATE} -f manifests/volumes/mailu-pv.yaml

helm repo add mailu https://mailu.github.io/helm-charts/

helm -n mailu install mailu -f helm/mailu.yaml mailu/mailu
