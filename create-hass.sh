#!/bin/bash

KUBE_CREATE='kubectl create'

echo "############"
echo "Install Home Assistant from Helm"
echo "######"
${KUBE_CREATE} -f manifests/volumes/homeassistant-pv.yaml

${KUBE_CREATE} -f manifests/homeassistant/homeassistant-namespace.yaml
ssh-keyscan github.com > /root/.ssh/known_hosts
kubectl -n homeassistant create secret generic git-creds \
	--from-file=id_rsa=/root/.ssh/id_rsa \
	--from-file=known_hosts=/root/.ssh/known_hosts \
	--from-file=id_rsa.pub=/root/.ssh/id_rsa.pub
kubectl -n homeassistant create secret generic config-secrets \
	--from-file=secrets.yaml=/root/kubernetes/manifests/homeassistant/secrets.yaml
helm repo add billimek https://billimek.com/billimek-charts/
helm install -n homeassistant homeassistant -f helm/homeassistant.yaml billimek/home-assistant

