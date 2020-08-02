#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete Tekton Pipelines"
echo "######"

echo "-- Deleting Tekton Webhook Run"
${KUBE_DELETE} -f manifests/tekton/webhook-run.yaml

echo "-- Deleting Tekton Ingress Run"
${KUBE_DELETE} -f manifests/tekton/ingress-run.yaml

echo "-- Deleting Tekton Webhook"
${KUBE_DELETE} -n getting-started -f manifests/tekton/create-webhook.yaml

echo "-- Deleting Tekton Ingress"
${KUBE_DELETE} -n getting-started -f manifests/tekton/create-ingress.yaml

echo "-- Deleting Tekton Triggers"
${KUBE_DELETE} -f manifests/tekton/triggers.yaml

echo "-- Deleting Tekton Pipeline"
${KUBE_DELETE} -f manifests/tekton/pipeline.yaml

echo "-- Deleting Tekton Webhook Role"
${KUBE_DELETE} -f manifests/tekton/webhook-role.yaml

echo "-- Deleting Tekton Admin Role"
${KUBE_DELETE} -f manifests/tekton/admin-role.yaml

echo "-- Deleting getting-started namespace "
${KUBE_DELETE} namespace getting-started

echo "-- Deleting Tekton Triggers Release"
${KUBE_DELETE} -f manifests/tekton/triggers-release.yaml

echo "-- Deleting Tekton Release"
${KUBE_DELETE} -f manifests/tekton/release.yaml

echo "-- Deleting Tekton config-artifact-pvc ConfigMap"
${KUBE_DELETE} configmap config-artifact-pvc

echo "-- Deleting Tekton PV"
${KUBE_DELETE} -f manifests/volumes/tekton-pv.yaml
