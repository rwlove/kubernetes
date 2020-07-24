#!/bin/bash

KUBE_CREATE='kubectl create'

echo "############"
echo "Create qbittorrentvpn"
echo "######"

${KUBE_CREATE} ns qbittorrentvpn

${KUBE_CREATE} -f manifests/volumes/qbittorrentvpn-pv.yaml

${KUBE_CREATE} -n qbittorrentvpn -f manifests/qbittorrent/qbittorrenvpn.yaml
