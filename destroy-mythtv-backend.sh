#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete mythtv-backend"
echo "######"
${KUBE_DELETE} -f manifests/services/mythtv-backend/mythtv-backend.yaml

${KUBE_DELETE} -f manifests/volumes/mythtv-backend-mysql-pv.yaml
