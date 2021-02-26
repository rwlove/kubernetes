#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete Gonic"
echo "######"

echo "## Uninstall Gonic Helm Chart"
helm -n gonic uninstall gonic

echo "## Delete Sonarr PV"
${KUBE_DELETE} -f manifests/volumes/gonic-pv.yaml

echo "## Delete 'ronarr' Namespace"
${KUBE_DELETE} ns gonic
