#!/bin/bash

KUBE_CREATE='kubectl create'

${KUBE_CREATE} -f manifests/volumes/mythtv-backend-mysql-pv.yaml

echo "############"
echo "Create mythtv-backend"
echo "######"
${KUBE_CREATE} -f manifests/services/mythtv-backend/mythtv-backend.yaml
