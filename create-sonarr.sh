#!/bin/bash

KUBE_CREATE='kubectl create'

${KUBE_CREATE} ns sonarr

${KUBE_CREATE} -f manifests/volumes/sonarr-pv.yaml

${KUBE_CREATE} -f manifests/sonarr/sonarr-downloads-pvc.yaml

echo "############"
echo "Create sonarr"
echo "######"

helm repo add k8s-at-home https://k8s-at-home.com/charts/

helm install -n sonarr sonarr -f helm/sonarr.yaml k8s-at-home/sonarr
