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

${KUBE_CREATE} namespace getting-started

${KUBE_CREATE} -f manifests/tekton/admin-role.yaml

${KUBE_CREATE} -f manifests/tekton/webhook-role.yaml

${KUBE_CREATE} -f manifests/tekton/pipeline.yaml

${KUBE_CREATE} -f manifests/tekton/triggers.yaml

${KUBE_CREATE} -n getting-started -f manifests/tekton/create-ingress.yaml

${KUBE_CREATE} -n getting-started -f manifests/tekton/create-webhook.yaml

${KUBE_CREATE} -f manifests/tekton/ingress-run.yaml

${KUBE_CREATE} -f manifests/tekton/webhook-run.yaml
