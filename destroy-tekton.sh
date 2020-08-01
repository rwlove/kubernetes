#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete Tekton Pipelines"
echo "######"

${KUBE_DELETE} manifests/tekton/webhook-run.yaml

${KUBE_DELETE} manifests/tekton/ingress-run.yaml

${KUBE_DELETE} -n getting-started -f manifests/tekton/create-webhook.yaml

${KUBE_DELETE} -n getting-started -f manifests/tekton/create-ingress.yaml

${KUBE_DELETE} -f manifests/tekton/triggers.yaml

${KUBE_DELETE} -f manifests/tekton/pipeline.yaml

${KUBE_DELETE} -f manifests/tekton/webhook-role.yaml

${KUBE_DELETE} -f manifests/tekton/admin-role.yaml

${KUBE_DELETE} namespace getting-started

${KUBE_DELETE} -f manifests/tekton/triggers-release.yaml

${KUBE_DELETE} -f manifests/tekton/release.yaml

${KUBE_DELETE} configmap config-artifact-pvc

${KUBE_DELETE} -f manifests/volumes/tekton-pv.yaml
