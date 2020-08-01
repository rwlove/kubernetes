#!/bin/bash

KUBE_CREATE='kubectl create'

${KUBE_CREATE} -f manifests/volumes/tekton-pv.yaml

${KUBE_CREATE} configmap config-artifact-pvc \
	       --from-literal=size=5GiB \
	       --from-literal=storageClassName=tekton-data-storage-class

echo "############"
echo "Create Tekton Pipelines"
echo "######"

${KUBE_CREATE} -f manifests/tekton/release.yaml

${KUBE_CREATE} -f manifests/tekton/triggers-release.yaml

${KUBE_CREATE} -f manifests/tekton/pipeline.yaml
