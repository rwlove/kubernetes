#!/bin/bash

KUBE_CREATE='kubectl create'

echo "############"
echo "Create pihole"
echo "######"
${KUBE_CREATE} -f manifests/volumes/pihole-pv.yaml
${KUBE_CREATE} -n pihole -f manifests/services/pihole/pihole.yaml
${KUBE_CREATE} -n pihole -f manifests/services/pihole/pihole-service.yaml

