#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete Nginx Ingress"
echo "######"

helm uninstall nginx-ingress

helm repo remove nginx-ingress
