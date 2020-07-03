#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Uninstall Mailu from Helm"
echo "######"
helm -n mailu uninstall mailu

${KUBE_DELETE} -f manifests/volumes/mailu-pv.yaml

${KUBE_DELETE} ns mailu

helm repo remove mailu
