#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete Radarr"
echo "######"

echo "## Uninstall Radarr Helm Chart"
helm -n radarr uninstall radarr

echo "## Delete Sonarr PV"
${KUBE_DELETE} -f manifests/volumes/radarr-pv.yaml

echo "## Delete 'ronarr' Namespace"
${KUBE_DELETE} ns radarr
