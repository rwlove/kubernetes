#!/bin/bash

curl -sL https://github.com/operator-framework/operator-lifecycle-manager/releases/download/0.14.1/install.sh | bash -s 0.14.1

${KUBE_CREATE} -f manifests/volumes/mariadb-nextcloud-pv.yaml
${KUBE_CREATE} -f manifests/volumes/mariadb-subsonic-pv.yaml
${KUBE_CREATE} -f manifests/volumes/music-volume-pv.yaml
${KUBE_CREATE} -f manifests/volumes/nextcloud-pv.yaml

${KUBE_CREATE} -f manifests/services/nextcloud/nextcloud.yaml
${KUBE_CREATE} -f manifests/services/nextcloud/mariadb-olm.yaml
helm install -n nextcloud nextcloud -f helm/nextcloud.yaml stable/nextcloud

${KUBE_CREATE} -f manifests/services/subsonic/subsonic.yaml
${KUBE_CREATE} -f manifests/services/subsonic/mariadb-olm.yaml
${KUBE_CREATE} -f manifests/services/subsonic/subsonic-olm.yaml
${KUBE_CREATE} -f manifests/services/subsonic/subsonic-service.yaml
