#!/bin/bash

KUBE_CREATE='kubectl create'

${KUBE_CREATE} ns radarr

${KUBE_CREATE} -f manifests/volumes/radarr-pv.yaml

echo "############"
echo "Create radarr"
echo "######"

helm repo add billimek https://billimek.com/billimek-charts/

helm install -n radarr radarr -f helm/radarr.yaml billimek/radarr
