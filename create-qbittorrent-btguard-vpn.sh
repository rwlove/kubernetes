#!/bin/bash

KUBE_CREATE='kubectl create'

echo "############"
echo "Create qbittorrentvpn"
echo "######"

${KUBE_CREATE} ns qbittorrentvpn

${KUBE_CREATE} -f manifests/volumes/qbittorrent-btguard-vpn-pv.yaml

${KUBE_CREATE} -n qbittorrentvpn -f manifests/qbittorrent-btguard-vpn/qbittorrentvpn.yaml
