#!/bin/bash

KUBE_CREATE='kubectl create'

echo "############"
echo "Install Home Assistant from Helm"
echo "######"
${KUBE_CREATE} -f manifests/volumes/homeassistant-pv.yaml

${KUBE_CREATE} -f manifests/homeassistant/homeassistant-namespace.yaml
ssh-keyscan github.com > /root/.ssh/known_hosts
kubectl -n homeassistant create secret generic git-creds \
	--from-file=id_rsa=/root/.ssh/id_rsa
helm repo add billimek https://billimek.com/billimek-charts/
helm install -n homeassistant homeassistant -f helm/homeassistant.yaml billimek/home-assistant

