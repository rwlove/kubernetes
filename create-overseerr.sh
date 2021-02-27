#!/bin/bash

KUBE_CREATE='kubectl create'

${KUBE_CREATE} ns overseerr

${KUBE_CREATE} -f manifests/volumes/overseerr-pv.yaml


echo "############"
echo "Create overseerr"
echo "######"

helm repo add k8s-at-home https://k8s-at-home.com/charts/

helm install -n overseerr overseerr -f helm/overseerr.yaml k8s-at-home/overseerr
