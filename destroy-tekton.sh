#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete Tekton Pipelines"
echo "######"

${KUBE_DELETE} -f manifests/tekton/pipeline.yaml

${KUBE_DELETE} -f manifests/tekton/triggers-release.yaml

${KUBE_DELETE} -f manifests/tekton/release.yaml

${KUBE_DELETE} configmap config-artifact-pvc

${KUBE_DELETE} -f manifests/volumes/tekton-pv.yaml
