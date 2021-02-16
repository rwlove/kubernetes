#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete qbittorrentvpn"
echo "######"

${KUBE_DELETE} -f manifests/qbittorrent-btguard-vpn/qbittorrentvpn.yaml

${KUBE_DELETE} -f manifests/volumes/qbittorrent-btguard-vpn-pv.yaml

${KUBE_DELETE} ns qbittorrentvpn
