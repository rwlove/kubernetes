#!/bin/bash

KUBE_CREATE='kubectl create'

echo "############"
echo "Install cert-manager from Helm"
echo "######"
${KUBE_CREATE} ns cert-manager

#${KUBE_CREATE} -f manifests/volumes/cert-manager-pv.yaml

## Add the Jetstack Helm repository
$ helm repo add jetstack https://charts.jetstack.io

## Install the cert-manager helm chart
$ helm -n cert-manager install cert-manager jetstack/cert-manager
