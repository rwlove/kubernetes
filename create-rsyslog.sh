#!/bin/bash

KUBE_CREATE='kubectl create'

${KUBE_CREATE} ns rsyslog

${KUBE_CREATE} -f manifests/volumes/rsyslog-pv.yaml

echo "############"
echo "Create rsyslog"
echo "######"

${KUBE_CREATE} -n rsyslog -f manifests/rsyslog/deployment.yaml

${KUBE_CREATE} -n rsyslog -f manifests/rsyslog/service.yaml
