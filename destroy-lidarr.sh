#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete Lidarr"
echo "######"

echo "## Uninstall Lidarr Helm Chart"
helm -n lidarr uninstall lidarr

echo "## Delete Lidarr PV"
${KUBE_DELETE} -f manifests/volumes/lidarr-pv.yaml

echo "## Delete Lidarr 'qbittorrent downloads' PVC"
${KUBE_DELETE} -f manifests/lidarr/lidarr-downloads-pvc.yaml

echo "## Delete 'lidarr' Namespace"
${KUBE_DELETE} ns lidarr
