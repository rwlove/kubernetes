#!/bin/bash

KUBE_CREATE='kubectl create'

${KUBE_CREATE} ns jackett

${KUBE_CREATE} -f manifests/volumes/jackett-pv.yaml

echo "############"
echo "Create jackett"
echo "######"

helm repo add k8s-at-home https://k8s-at-home.com/charts/

helm install -n jackett jackett -f helm/jackett.yaml k8s-at-home/jackett
