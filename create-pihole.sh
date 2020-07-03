#!/bin/bash

KUBE_CREATE='kubectl create'

echo "############"
echo "Create pihole"
echo "######"
${KUBE_CREATE} -f manifests/volumes/pihole-pv.yaml

${KUBE_CREATE} namespace pihole
helm repo add mojo2600 https://mojo2600.github.io/pihole-kubernetes/
helm install -n pihole pihole -f helm/pihole.yaml mojo2600/pihole
