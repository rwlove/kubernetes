#!/bin/bash

echo "#### Initialize Calico ####"
echo "## Installing Calico Operator ####"
kubectl apply -f operators/tigera-operator.yaml

echo "## Installing Calico Custom Resource ####"
kubectl apply -f operators/tigera-operator-cr.yaml
