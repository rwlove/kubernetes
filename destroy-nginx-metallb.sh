#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete nginx metallb"
echo "######"

${KUBE_DELETE} -n nginx -f manifests/lb/nginx-metallb.sh

${KUBE_DELETE} ns nginx
