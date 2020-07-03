#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Uninstall Heimdall from Helm"
echo "######"
helm -n heimdall uninstall heimdall

${KUBE_DELETE} -f manifests/volumes/heimdall-pv.yaml

${KUBE_DELETE} ns heimdall

helm repo remove billimek
