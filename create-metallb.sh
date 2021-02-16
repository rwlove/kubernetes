#!/bin/bash

KUBE_CREATE='kubectl create'

echo "############"
echo "Create MetalLB"
echo "######"
${KUBE_CREATE} -f manifests/lb/metallb-namespace.yaml
${KUBE_CREATE} -f manifests/lb/metallb.yaml
${KUBE_CREATE} secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
${KUBE_CREATE} -f configmap/lb/metallb.yaml
