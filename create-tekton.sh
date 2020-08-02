#!/bin/bash

KUBE_CREATE='kubectl create'


echo "############"
echo "Create Tekton Pipelines"
echo "######"

echo "-- Creating Tekton PV"
${KUBE_CREATE} -f manifests/volumes/tekton-pv.yaml

echo "-- Creating Tekton config-artifact-pvc ConfigMap"
${KUBE_CREATE} configmap config-artifact-pvc \
	       --from-literal=size=5GiB \
	       --from-literal=storageClassName=tekton-data-storage-class

echo "-- Creating Tekton Release"
${KUBE_CREATE} -f manifests/tekton/release.yaml

echo "-- Creating Tekton Triggers Release"
${KUBE_CREATE} -f manifests/tekton/triggers-release.yaml

echo "-- Creating getting-started namespace"
${KUBE_CREATE} namespace getting-started

echo "-- Creating Tekton admin-role"
${KUBE_CREATE} -f manifests/tekton/admin-role.yaml

echo "-- Creating Tekton webhook-role"
${KUBE_CREATE} -f manifests/tekton/webhook-role.yaml

echo "-- Creating Tekton Pipeline"
${KUBE_CREATE} -f manifests/tekton/pipeline.yaml

echo "-- Creating Tekton Triggers"
${KUBE_CREATE} -f manifests/tekton/triggers.yaml

echo "-- Creating Tekton Ingress"
${KUBE_CREATE} -n getting-started -f manifests/tekton/create-ingress.yaml

echo "-- Creating Tekton Webhook"
${KUBE_CREATE} -n getting-started -f manifests/tekton/create-webhook.yaml

echo "-- Creating Tekton Ingress Run"
${KUBE_CREATE} -f manifests/tekton/ingress-run.yaml

echo "-- Creating Tekton Webhook Run"
${KUBE_CREATE} -f manifests/tekton/webhook-run.yaml
