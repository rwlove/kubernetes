#!/bin/bash

KUBE_CREATE='kubectl create'

echo "############"
echo "Install Home Assistant from Helm"
echo "######"
${KUBE_CREATE} -f manifests/volumes/homeassistant-pv.yaml

${KUBE_CREATE} -f manifests/homeassistant/homeassistant-namespace.yaml
ssh-keyscan github.com > /tmp/known_hosts
kubectl -n homeassistant create secret generic git-creds \
	--from-file=ssh=$HOME/.ssh/id_rsa \
	--from-file=known_hosts=/tmp/known_hosts
helm repo add billimek https://billimek.com/billimek-charts/
helm install -n homeassistant homeassistant -f helm/homeassistant.yaml billimek/home-assistant

