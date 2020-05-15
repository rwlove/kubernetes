#!/bin/bash

KUBE_CREATE='kubectl create'

${KUBE_CREATE} -f manifests/volumes/mariadb-nextcloud-pv.yaml
${KUBE_CREATE} -f manifests/volumes/mariadb-subsonic-pv.yaml
${KUBE_CREATE} -f manifests/volumes/music-volume-pv.yaml
${KUBE_CREATE} -f manifests/volumes/nextcloud-pv.yaml

${KUBE_CREATE} -f operators/mariadb-operator.yaml

${KUBE_CREATE} -f manifests/services/nextcloud/nextcloud.yaml
${KUBE_CREATE} -f manifests/services/nextcloud/mariadb-opr.yaml
helm install -n nextcloud nextcloud -f helm/nextcloud.yaml stable/nextcloud

${KUBE_CREATE} -f manifests/services/subsonic/subsonic.yaml
${KUBE_CREATE} -f manifests/services/subsonic/mariadb-opr.yaml
${KUBE_CREATE} -f manifests/services/subsonic/subsonic-opr.yaml
${KUBE_CREATE} -f manifests/services/subsonic/subsonic-service.yaml
