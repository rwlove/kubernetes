#!/bin/bash

KUBE_CREATE='kubectl create'

echo "############"
echo "Create nginx metallb"
echo "######"

${KUBE_CREATE} ns nginx

${KUBE_CREATE} -n nginx -f manifests/lb/nginx-metallb.yaml
