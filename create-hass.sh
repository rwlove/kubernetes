#!/bin/bash

KUBE_CREATE='kubectl create'

echo "############"
echo "Clone or pull modified home-assistant helm charts"
echo "######"
if [ ! -d /tmp/home-assistant ] ; then
    git clone rwlove@brain:/home/rwlove/kubernetes/workspace/billimek-charts /tmp/billimek-charts
else
    git -C /tmp/billimek-charts pull rwlove@brain:/home/rwlove/kubernetes/workspace/billimek-charts
fi

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
#helm repo add billimek https://billimek.com/billimek-charts/
helm install -n homeassistant homeassistant -f helm/homeassistant.yaml /tmp/billimek-charts/charts/home-assistant
