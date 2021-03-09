#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete Photoprism"
echo "######"

echo "## Uninstall Photoprism Helm Chart"
helm -n photoprism uninstall photoprism

echo "## Delete Photoprism PV"
${KUBE_DELETE} -f manifests/volumes/photoprism-pv.yaml

echo "## Delete 'photoprism' Namespace"
${KUBE_DELETE} ns photoprism
