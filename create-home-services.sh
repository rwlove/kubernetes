#!/bin/bash

KUBE_CREATE='kubectl create'
NAMESPACE='-n home-services'

curl -sL https://github.com/operator-framework/operator-lifecycle-manager/releases/download/0.14.1/install.sh | bash -s 0.14.1

${KUBE_CREATE} -f manifests/services/home-services-namespace.yaml
${KUBE_CREATE} -f manifests/services/nextcloud/nextcloud-namespace.yaml

#${KUBE_CREATE} -f manifests/dns/external-dns/external-dns.yaml

${KUBE_CREATE} -f manifests/volumes/mariadb-pv.yaml
${KUBE_CREATE} -f manifests/volumes/mariadb-pvc.yaml

${KUBE_CREATE} -f manifests/volumes/music-volume-pv.yaml
${KUBE_CREATE} ${NAMESPACE} -f manifests/volumes/music-volume-pvc.yaml

${KUBE_CREATE} ${NAMESPACE} -f manifests/db/mysql-pv.yaml
${KUBE_CREATE} ${NAMESPACE} -f manifests/db/mysql-deployment.yaml

${KUBE_CREATE} -f operators/mariadb.yaml

helm install ${NAMESPACE} grafana -f helm/grafana.yaml stable/grafana
helm install ${NAMESPACE} prometheus -f helm/prometheus.yaml stable/prometheus

${KUBE_CREATE} -f manifests/services/nextcloud/nextcloud.yaml
helm install -n nextcloud nextcloud -f helm/nextcloud.yaml stable/nextcloud

${KUBE_CREATE} ${NAMESPACE} -f manifests/services/pihole/pihole-service.yaml
${KUBE_CREATE} ${NAMESPACE} -f manifests/services/pihole/pihole.yaml

${KUBE_CREATE} ${NAMESPACE} -f manifests/services/nginx-hello/nginx-hello.yaml
${KUBE_CREATE} ${NAMESPACE} -f manifests/services/nginx-hello/nginx-hello-service.yaml

${KUBE_CREATE} ${NAMESPACE} -f manifests/services/homeassistant/homeassistant.yaml
${KUBE_CREATE} ${NAMESPACE} -f manifests/services/homeassistant/homeassistant-service.yaml

${KUBE_CREATE} ${NAMESPACE} -f manifests/services/subsonic/subsonic.yaml
${KUBE_CREATE} ${NAMESPACE} -f manifests/services/subsonic/subsonic-service.yaml

kubectl label nodes worker3 sound=bathroom-audio
${KUBE_CREATE} ${NAMESPACE} -f manifests/services/mpd/mpd.yaml
${KUBE_CREATE} ${NAMESPACE} -f manifests/services/mpd/mpd-service.yaml

${KUBE_CREATE} ${NAMESPACE} -f manifests/services/rompr/rompr.yaml
${KUBE_CREATE} ${NAMESPACE} -f manifests/services/rompr/rompr-service.yaml

${KUBE_CREATE} -f manifests/dashboard/kubernetes-k8dash.yaml

${KUBE_CREATE} -f manifests/tools/dnsutils.yaml

${KUBE_CREATE} -f manifests/lb/metallb-namespace.yaml

${KUBE_CREATE} -f manifests/lb/metallb.yaml

${KUBE_CREATE} secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

${KUBE_CREATE} -f configmap/lb/metallb.yaml

#${KUBE_CREATE} -f manifests/lb/nginx-ingress.yaml
