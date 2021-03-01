#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete Flaresolverr"
echo "######"

echo "## Uninstall Flaresolverr Helm Chart"
helm -n flaresolverr uninstall flaresolverr

echo "## Delete 'flaresolverr' Namespace"
${KUBE_DELETE} ns flaresolverr
