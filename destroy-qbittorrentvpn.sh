#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete qbittorrentvpn"
echo "######"

${KUBE_DELETE} -f manifests/qbittorrentvpn/qbittorrentvpn.yaml

${KUBE_DELETE} -f manifests/volumes/qbittorrentvpn-pv.yaml

${KUBE_DELETE} ns qbittorrentvpn
