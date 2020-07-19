#!/bin/bash

KUBE_CREATE='kubectl create'

${KUBE_CREATE} ns sonarr

${KUBE_CREATE} -f manifests/volumes/sonarr-pv.yaml

echo "############"
echo "Create sonarr"
echo "######"

helm repo add billimek https://billimek.com/billimek-charts/

helm install -n sonarr sonarr -f helm/sonarr.yaml billimek/sonarr
