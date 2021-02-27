#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete Overseerr"
echo "######"

echo "## Uninstall Overseerr Helm Chart"
helm -n overseerr uninstall overseerr

echo "## Delete Overseerr PV"
${KUBE_DELETE} -f manifests/volumes/overseerr-pv.yaml

echo "## Delete 'overseerr' Namespace"
${KUBE_DELETE} ns overseerr
