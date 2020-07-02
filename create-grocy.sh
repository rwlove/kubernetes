#!/bin/bash

KUBE_CREATE='kubectl create'

echo "############"
echo "Install Grocy from Helm"
echo "######"
${KUBE_CREATE} ns grocy

${KUBE_CREATE} -n grocy -f manifests/volumes/grocy-pv.yaml

echo "############"
echo "Clone or pull modified home-assistant helm charts"
echo "######"
if [ ! -d /tmp/billimek-charts ] ; then
    echo "-- clone"
    git clone rwlove@brain:/home/rwlove/kubernetes/workspace/billimek-charts /tmp/billimek-charts
else
    echo "-- pull"
    git -C /tmp/billimek-charts pull
fi

helm install -n grocy grocy -f helm/grocy.yaml /tmp/billimek-charts/charts/grocy
