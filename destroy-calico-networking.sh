#!/bin/bash

echo "#### Delete Calico Configuration ####"
kubectl delete -f calico.yaml
