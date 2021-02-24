#!/bin/bash

KUBE_CREATE='kubectl create'

echo "############"
echo "Install Qbittorrent from Helm"
echo "######"
${KUBE_CREATE} ns qbittorrent

${KUBE_CREATE} -f manifests/volumes/qbittorrent-pv.yaml

helm repo add k8s-at-home https://k8s-at-home.com/charts/

helm install -n qbittorrent qbittorrent -f helm/qbittorrent.yaml k8s-at-home/qbittorrent
