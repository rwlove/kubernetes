#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete sonarr"
echo "######"

helm -n sonarr uninstall sonarr

${KUBE_DELETE} -f manifests/volumes/sonarr-pv.yaml

${KUBE_DELETE} ns sonarr
