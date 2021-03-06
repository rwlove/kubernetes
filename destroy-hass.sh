#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Uninstall Home Assistant from Helm"
echo "######"
helm -n homeassistant uninstall homeassistant
kubectl -n homeassistant delete secret git-creds
${KUBE_DELETE} -f manifests/homeassistant/homeassistant-namespace.yaml
#helm repo remove billimek
rm -rf /tmp/billimek-charts

${KUBE_DELETE} -f manifests/volumes/homeassistant-pv.yaml

kubectl label node worker2 device-
