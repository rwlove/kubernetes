#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete Gonic"
echo "######"

echo "## Uninstall Gonic Helm Chart"
helm -n gonic uninstall gonic

echo "## Delete gonic PV"
${KUBE_DELETE} -f manifests/volumes/gonic-music-volume-pv.yaml

echo "## Delete 'gonic' Namespace"
${KUBE_DELETE} ns gonic
