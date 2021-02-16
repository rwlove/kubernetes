#!/bin/bash

KUBE_CREATE='kubectl create'

${KUBE_CREATE} -n default -f manifests/dnsutils.yaml
