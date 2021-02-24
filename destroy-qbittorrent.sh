#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Uninstall Qbittorrent from Helm"
echo "######"
helm -n qbittorrent uninstall qbittorrent

${KUBE_DELETE} -f manifests/volumes/qbittorrent-pv.yaml

${KUBE_DELETE} ns qbittorrent
