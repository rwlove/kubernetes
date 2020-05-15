#!/bin/bash

KUBE_DELETE='kubectl delete'

${KUBE_DELETE} -f manifests/services/subsonic/subsonic-service.yaml
${KUBE_DELETE} -f manifests/services/subsonic/subsonic-olm.yaml
${KUBE_DELETE} -f manifests/services/subsonic/mariadb-olm.yaml
${KUBE_DELETE} -f manifests/services/subsonic/subsonic.yaml

helm uninstall -n nextcloud nextcloud
${KUBE_DELETE} -f manifests/services/nextcloud/mariadb-olm.yaml
${KUBE_DELETE} -f manifests/services/nextcloud/nextcloud.yaml

${KUBE_DELETE} -f manifests/volumes/nextcloud-pv.yaml
${KUBE_DELETE} -f manifests/volumes/music-volume-pv.yaml
${KUBE_DELETE} -f manifests/volumes/mariadb-nextcloud-pv.yaml
${KUBE_DELETE} -f manifests/volumes/mariadb-subsonic-pv.yaml
