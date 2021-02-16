#!/bin/bash

echo "#### Delete Calico Configuration ####"

echo "## Deleting Calico Custom Resource ####"
kubectl delete -f operators/tigera-operator-cr.yaml

echo "## Deleting Calico Operator ####"
kubectl delete -f operators/tigera-operator.yaml

