#!/bin/bash

KUBE_CREATE='kubectl create'

${KUBE_CREATE} ns flood

${KUBE_CREATE} -f manifests/volumes/flood-pv.yaml

echo "############"
echo "Create flood"
echo "######"

helm repo add k8s-at-home https://k8s-at-home.com/charts/

helm install -n flood flood -f helm/flood.yaml k8s-at-home/flood
