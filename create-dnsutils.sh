#!/bin/bash

KUBE_CREATE='kubectl create'

${KUBE_CREATE} -n qbittorrentvpn -f manifests/dnsutils.yaml
