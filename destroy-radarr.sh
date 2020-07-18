#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete radarr"
echo "######"

helm -n radarr uninstall radarr

${KUBE_DELETE} -f manifests/volumes/radarr-pv.yaml

${KUBE_DELETE} ns radarr
