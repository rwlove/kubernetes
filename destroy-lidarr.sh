#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete Lidarr"
echo "######"

echo "## Uninstall Lidarr Helm Chart"
helm -n lidarr uninstall lidarr

echo "## Delete Lidarr PV"
${KUBE_DELETE} -f manifests/volumes/lidarr-pv.yaml

echo "## Delete 'lidarr' Namespace"
${KUBE_DELETE} ns lidarr
