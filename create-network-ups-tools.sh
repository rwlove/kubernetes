#!/bin/bash

KUBE_CREATE='kubectl create'

${KUBE_CREATE} ns network-ups-tools

echo "############"
echo "Create Network UPS Tools"
echo "######"

helm repo add k8s-at-home https://k8s-at-home.com/charts/

helm install -n network-ups-tools network-ups-tools -f helm/network-ups-tools.yaml k8s-at-home/network-ups-tools
