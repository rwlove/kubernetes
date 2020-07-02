#!/bin/bash

KUBE_CREATE='kubectl create'

echo "############"
echo "Install Speedtest-Prometheus from Helm"
echo "######"
${KUBE_CREATE} ns speedtest-prometheus

helm repo add billimek https://billimek.com/billimek-charts/

helm install \
     -n speedtest-prometheus \
     speedtest-prometheus \
     --set serviceMonitor.enabled=true \
     billimek/speedtest-prometheus
