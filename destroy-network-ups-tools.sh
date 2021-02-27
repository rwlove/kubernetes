#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete Network UPS Tools"
echo "######"

echo "## Uninstall Network UPS Tools Helm Chart"
helm -n network-ups-tools uninstall network-ups-tools

echo "## Delete 'network-ups-tools' Namespace"
${KUBE_DELETE} ns network-ups-tools
