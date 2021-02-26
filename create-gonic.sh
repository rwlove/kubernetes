#!/bin/bash

KUBE_CREATE='kubectl create'

${KUBE_CREATE} ns gonic

${KUBE_CREATE} -f manifests/volumes/gonic-music-volume-pv.yaml

#${KUBE_CREATE} -f manifests/gonic/gonic-downloads-pvc.yaml

echo "############"
echo "Create gonic"
echo "######"

helm repo add k8s-at-home https://k8s-at-home.com/charts/

helm install -n gonic gonic -f helm/gonic.yaml k8s-at-home/gonic
