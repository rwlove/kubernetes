#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete pihole"
echo "######"
${KUBE_DELETE} -n pihole -f manifests/services/pihole/pihole-service.yaml
${KUBE_DELETE} -n pihole -f manifests/services/pihole/pihole.yaml
${KUBE_DELETE} -f manifests/volumes/pihole-pv.yaml
${KUBE_DELETE} namespace pihole
