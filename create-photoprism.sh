#!/bin/bash

KUBE_CREATE='kubectl create'

${KUBE_CREATE} ns photoprism

${KUBE_CREATE} -f manifests/volumes/photoprism-pv.yaml

echo "############"
echo "Create photoprism"
echo "######"

helm repo add k8s-at-home https://k8s-at-home.com/charts/

helm install -n photoprism photoprism -f helm/photoprism.yaml k8s-at-home/photoprism
