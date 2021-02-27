#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete Flood"
echo "######"

echo "## Uninstall Flood Helm Chart"
helm -n flood uninstall flood

echo "## Delete Flood PV"
${KUBE_DELETE} -f manifests/volumes/flood-pv.yaml

echo "## Delete 'flood' Namespace"
${KUBE_DELETE} ns flood
