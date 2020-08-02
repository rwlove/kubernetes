#!/bin/bash

KUBE_CREATE='kubectl create'

${KUBE_CREATE} ns nginx-ingress

${KUBE_CREATE} -f manifests/volumes/nginx-ingress-pv.yaml

echo "############"
echo "Create Nginx Ingress"
echo "######"

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

helm install -n nginx-ingress ingress-nginx/ingress-nginx
