#!/bin/bash

KUBE_CREATE='kubectl create'

${KUBE_CREATE} ns flaresolverr

echo "############"
echo "Create flaresolverr"
echo "######"

helm repo add k8s-at-home https://k8s-at-home.com/charts/

helm install -n flaresolverr flaresolverr -f helm/flaresolverr.yaml k8s-at-home/flaresolverr
