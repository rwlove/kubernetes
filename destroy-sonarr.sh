#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete Sonarr"
echo "######"

echo "## Uninstall Sonarr Helm Chart"
helm -n sonarr uninstall sonarr

echo "## Delete Sonarr 'qbittorrent downloads' PVC"
${KUBE_DELETE} -f manifests/sonarr/sonarr-downloads-pvc.yaml

echo "## Delete Sonarr PV"
${KUBE_DELETE} -f manifests/volumes/sonarr-pv.yaml

echo "## Delete 'sonarr' Namespace"
${KUBE_DELETE} ns sonarr
