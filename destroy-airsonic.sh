#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete Airsonic"
echo "######"

echo "## Uninstall Airsonic Helm Chart"
helm -n airsonic uninstall airsonic

echo "## Delete Airsonic PV"
${KUBE_DELETE} -f manifests/volumes/airsonic-pv.yaml

echo "## Delete 'airsonic' Namespace"
${KUBE_DELETE} ns airsonic
