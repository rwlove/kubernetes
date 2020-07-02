#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Uninstall Grocy from Helm"
echo "######"
helm -n grocy uninstall grocy

${KUBE_DELETE} -n grocy -f manifests/volumes/grocy-pv.yaml

${KUBE_DELETE} ns grocy

helm repo remove billimek
