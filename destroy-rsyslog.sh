#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete rsyslog"
echo "######"

${KUBE_DELETE} -n rsyslog manifests/rsyslog/service.yaml

${KUBE_DELETE} -n rsyslog manifests/rsyslog/deployment.yaml

${KUBE_DELETE} -f manifests/volumes/rsyslog-pv.yaml

${KUBE_DELETE} ns rsyslog
