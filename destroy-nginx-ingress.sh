#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete Nginx Ingress"
echo "######"

helm uninstall -n nginx-ingress nginx-ingress

helm repo remove nginx-ingress

${KUBE_DELETE} namespace nginx-ingress
