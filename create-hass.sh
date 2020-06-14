#!/bin/bash

KUBE_CREATE='kubectl create'

echo "############"
echo "Install Home Assistant from Helm"
echo "######"
${KUBE_CREATE} -f manifests/volumes/homeassistant-pv.yaml

${KUBE_CREATE} -f manifests/homeassistant/homeassistant-namespace.yaml
kubectl -n homeassistant create secret generic git-creds --from-file=ssh-privatekey=/root/.ssh/id_rsa --from-file=ssh-publickey=/root/.ssh/id_rsa.pub

helm repo add billimek https://billimek.com/billimek-charts/
helm install -n homeassistant homeassistant -f helm/homeassistant.yaml billimek/home-assistant

