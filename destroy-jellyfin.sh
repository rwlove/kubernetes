#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete Jellyfin"
echo "######"

echo "## Uninstall Jellyfin Helm Chart"
helm -n jellyfin uninstall jellyfin

echo "## Delete Jellyfin PV"
${KUBE_DELETE} -f manifests/volumes/jellyfin-pv.yaml

echo "## Delete 'jellyfin' Namespace"
${KUBE_DELETE} ns jellyfin
