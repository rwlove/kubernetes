#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete Radarr"
echo "######"

echo "## Uninstall Radarr Helm Chart"
helm -n radarr uninstall radarr

echo "## Delete Radarr 'qbittorrent downloads' PVC"
${KUBE_DELETE} -f manifests/radarr/radarr-downloads-pvc.yaml

echo "## Delete Radarr PV"
${KUBE_DELETE} -f manifests/volumes/radarr-pv.yaml

echo "## Delete 'radarr' Namespace"
${KUBE_DELETE} ns radarr
