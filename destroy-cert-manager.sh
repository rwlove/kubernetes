#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Uninstall Cert-Manager from Helm"
echo "######"
helm -n cert-manager uninstall cert-manager

#${KUBE_DELETE} -f manifests/volumes/cert-manager-pv.yaml

${KUBE_DELETE} ns cert-manager

helm repo remove jetstack
