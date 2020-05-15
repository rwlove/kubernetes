#!/bin/bash

${KUBE_DELETE} -f manifests/services/subsonic/subsonic-service.yaml
${KUBE_DELETE} -f manifests/services/subsonic/subsonic-opr.yaml
${KUBE_DELETE} -f manifests/services/subsonic/mariadb-opr.yaml
${KUBE_DELETE} -f manifests/services/subsonic/subsonic.yaml

${KUBE_DELETE} -f manifests/services/nextcloud/nextcloud.yaml
helm install -n nextcloud nextcloud -f helm/nextcloud.yaml stable/nextcloud

${KUBE_DELETE} -f operators/mariadb-operator.yaml

${KUBE_DELETE} -f manifests/volumes/nextcloud-pv.yaml
${KUBE_DELETE} -f manifests/volumes/music-volume-pv.yaml
${KUBE_DELETE} -f manifests/volumes/mariadb-subsonic-pv.yaml
${KUBE_DELETE} -f manifests/volumes/mariadb-nextcloud-pv.yaml
