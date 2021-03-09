#!/bin/bash

KUBE_CREATE='kubectl create'

${KUBE_CREATE} ns airsonic

${KUBE_CREATE} -f manifests/volumes/airsonic-pv.yaml

echo "############"
echo "Create airsonic"
echo "######"

helm repo add k8s-at-home https://k8s-at-home.com/charts/

helm install -n airsonic airsonic -f helm/airsonic.yaml k8s-at-home/airsonic
