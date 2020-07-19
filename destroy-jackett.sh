#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete jackett"
echo "######"

helm -n jackett uninstall jackett

${KUBE_DELETE} -f manifests/volumes/jackett-pv.yaml

${KUBE_DELETE} ns jackett
