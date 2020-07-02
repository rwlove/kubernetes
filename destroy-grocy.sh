#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Uninstall Grocy from Helm"
echo "######"
helm -n grocy uninstall grocy

${KUBE_DELETE} ns grocy

helm repo remove billimek
