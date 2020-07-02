#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Uninstall Speedtest-Prometheus from Helm"
echo "######"
helm -n speedtest-prometheus uninstall speedtest-prometheus

${KUBE_DELETE} ns speedtest-prometheus

helm repo remove billimek
