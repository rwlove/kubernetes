#!/bin/bash

KUBE_CREATE='kubectl create'

${KUBE_CREATE} ns radarr

${KUBE_CREATE} -f manifests/volumes/radarr-pv.yaml

${KUBE_CREATE} -f manifests/radarr/radarr-downloads-pvc.yaml

echo "############"
echo "Create radarr"
echo "######"

helm repo add k8s-at-home https://k8s-at-home.com/charts/

helm install -n radarr radarr -f helm/radarr.yaml k8s-at-home/radarr
