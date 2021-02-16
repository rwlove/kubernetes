#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete MetalLB"
echo "######"
${KUBE_DELETE} -f configmap/lb/metallb.yaml
${KUBE_DELETE} -f manifests/lb/metallb.yaml
${KUBE_DELETE} -f manifests/lb/metallb-namespace.yaml
