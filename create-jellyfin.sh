#!/bin/bash

KUBE_CREATE='kubectl create'

${KUBE_CREATE} ns jellyfin

${KUBE_CREATE} -f manifests/volumes/jellyfin-pv.yaml

${KUBE_CREATE} -f manifests/jellyfin/jellyfin-downloads-pvc.yaml

echo "############"
echo "Create jellyfin"
echo "######"

helm repo add k8s-at-home https://k8s-at-home.com/charts/

helm install -n jellyfin jellyfin -f helm/jellyfin.yaml k8s-at-home/jellyfin
