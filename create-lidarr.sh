#!/bin/bash

KUBE_CREATE='kubectl create'

${KUBE_CREATE} ns lidarr

${KUBE_CREATE} -f manifests/volumes/lidarr-pv.yaml

echo "############"
echo "Create lidarr"
echo "######"

helm repo add k8s-at-home https://k8s-at-home.com/charts/

helm install -n lidarr lidarr -f helm/lidarr.yaml k8s-at-home/lidarr
