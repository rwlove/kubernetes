#!/bin/bash

KUBE_DELETE='kubectl delete'
NAMESPACE='-n home-services'

${KUBE_DELETE} -f configmap/lb/metallb.yaml

${KUBE_DELETE} -f manifests/lb/metallb.yaml

#${KUBE_DELETE} -f manifests/lb/nginx-ingress.yaml

${KUBE_DELETE} -f manifests/lb/metallb-namespace.yaml

${KUBE_DELETE} -f manifests/tools/dnsutils.yaml

${KUBE_DELETE} -f manifests/dashboard/kubernetes-k8dash.yaml

${KUBE_DELETE} ${NAMESPACE} -f manifests/services/rompr/rompr-service.yaml
${KUBE_DELETE} ${NAMESPACE} -f manifests/services/rompr/rompr.yaml

${KUBE_DELETE} ${NAMESPACE} -f manifests/services/mpd/mpd-service.yaml
${KUBE_DELETE} ${NAMESPACE} -f manifests/services/mpd/mpd.yaml

${KUBE_DELETE} ${NAMESPACE} -f manifests/services/homeassistant/homeassistant-service.yaml
${KUBE_DELETE} ${NAMESPACE} -f manifests/services/homeassistant/homeassistant.yaml

${KUBE_DELETE} ${NAMESPACE} -f manifests/services/nginx-hello/nginx-hello-service.yaml
${KUBE_DELETE} ${NAMESPACE} -f manifests/services/nginx-hello/nginx-hello.yaml

${KUBE_DELETE} ${NAMESPACE} -f manifests/services/pihole/pihole-service.yaml
${KUBE_DELETE} ${NAMESPACE} -f manifests/services/pihole/pihole.yaml

${KUBE_DELETE} ${NAMESPACE} -f manifests/db/mysql-deployment.yaml
${KUBE_DELETE} -f manifests/db/mysql-pv.yaml

helm uninstall prometheus
helm uninstall grafana


echo "############"
echo "Delete the subsonic PostgreSQL database"
echo "######"
kubectl delete -f manifests/db/crunchy_postgresql/subsonic-db.yaml

echo "############"
echo "Uninstall the operator."
echo "######"
kubectl delete -f operators/postgresql.yaml

${KUBE_DELETE} -f manifests/services/kubemq/kubemq-dashboard.yaml
${KUBE_DELETE} -f manifests/services/kubemq/kubemq-cluster.yaml
${KUBE_DELETE} ${NAMESPACE} -f operators/kubemq-operator.yaml

${KUBE_DELETE} -f manifests/volumes/nextcloud-pv.yaml
${KUBE_DELETE} -f manifests/volumes/music-volume-pv.yaml
${KUBE_DELETE} -f manifests/volumes/mariadb-nextcloud-pv.yaml
${KUBE_DELETE} -f manifests/volumes/mariadb-subsonic-pv.yaml

${KUBE_DELETE} -f manifests/db/crunchy_postgresql/pgo-namespace.yaml
${KUBE_DELETE} -f manifests/services/home-services-namespace.yaml

#${KUBE_DELETE} -f manifests/dns/external-dns/external-dns.yaml
