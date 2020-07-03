#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete pihole"
echo "######"
helm -n pihole uninstall pihole
${KUBE_DELETE} -f manifests/volumes/pihole-pv.yaml
${KUBE_DELETE} namespace pihole
helm repo remove mojo2600

