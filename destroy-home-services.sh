#!/bin/bash

KUBE_DELETE='kubectl delete'
NAMESPACE='-n home-services'

#${KUBE_DELETE} -f manifests/lb/nginx-ingress.yaml

echo "############"
echo "Delete MetalLB"
echo "######"
${KUBE_DELETE} -f configmap/lb/metallb.yaml
${KUBE_DELETE} -f manifests/lb/metallb.yaml
${KUBE_DELETE} -f manifests/lb/metallb-namespace.yaml

echo "############"
echo "Delete dnsutils"
echo "######"
${KUBE_DELETE} -f manifests/tools/dnsutils.yaml

echo "############"
echo "Delete k8dash"
echo "######"
${KUBE_DELETE} -f manifests/dashboard/kubernetes-k8dash.yaml

echo "############"
echo "Delete rompr"
echo "######"
${KUBE_DELETE} ${NAMESPACE} -f manifests/services/rompr/rompr-service.yaml
${KUBE_DELETE} ${NAMESPACE} -f manifests/services/rompr/rompr.yaml

echo "############"
echo "Delete mpd"
echo "######"
${KUBE_DELETE} -f manifests/services/mpd/mpd-service.yaml
${KUBE_DELETE} -f manifests/services/mpd/mpd.yaml

echo "############"
echo "Delete homeassistant"
echo "######"
${KUBE_DELETE} ${NAMESPACE} -f manifests/services/homeassistant/homeassistant-service.yaml
${KUBE_DELETE} ${NAMESPACE} -f manifests/services/homeassistant/homeassistant.yaml

echo "############"
echo "Delete nginx-hello"
echo "######"
${KUBE_DELETE} ${NAMESPACE} -f manifests/services/nginx-hello/nginx-hello-service.yaml
${KUBE_DELETE} ${NAMESPACE} -f manifests/services/nginx-hello/nginx-hello.yaml

echo "############"
echo "Delete pihole"
echo "######"
${KUBE_DELETE} ${NAMESPACE} -f manifests/services/pihole/pihole-service.yaml
${KUBE_DELETE} ${NAMESPACE} -f manifests/services/pihole/pihole.yaml

echo "############"
echo "Delete Subsonic"
echo "######"
${KUBE_DELETE} -f manifests/services/subsonic/subsonic-service.yaml
${KUBE_DELETE} -f manifests/services/subsonic/subsonic.yaml

echo "############"
echo "Delete Nextcloud"
echo "######"
helm uninstall -n nextcloud nextcloud
${KUBE_DELETE} -f manifests/services/nextcloud/nextcloud.yaml


${KUBE_DELETE} ${NAMESPACE} -f manifests/db/mysql-deployment.yaml
${KUBE_DELETE} -f manifests/db/mysql-pv.yaml

helm uninstall ${NAMESPACE} prometheus
helm uninstall ${NAMESPACE} grafana

echo "############"
echo "Delete the subsonic PostgreSQL database"
echo "######"
kubectl delete -f manifests/db/crunchy_postgresql/subsonic-db.yaml

echo "############"
echo "Uninstall the operator."
echo "######"
kubectl delete -f operators/postgresql.yaml

echo "############"
echo "Delete kubemq"
echo "######"
${KUBE_DELETE} -f manifests/services/kubemq/kubemq-dashboard.yaml
${KUBE_DELETE} -f manifests/services/kubemq/kubemq-cluster.yaml
${KUBE_DELETE} -f operators/kubemq-operator.yaml

echo "############"
echo "Delete Physical (storage) Volumes"
echo "######"
${KUBE_DELETE} -f manifests/volumes/nextcloud-pv.yaml
${KUBE_DELETE} -f manifests/volumes/music-volume-pv.yaml
${KUBE_DELETE} -f manifests/volumes/mariadb-nextcloud-pv.yaml
${KUBE_DELETE} -f manifests/volumes/mariadb-subsonic-pv.yaml
${KUBE_DELETE} -f manifests/volumes/postgress-subsonic-pv.yaml

echo "############"
echo "Delete namespaces (pgo and home-services)"
echo "######"
${KUBE_DELETE} -f manifests/db/crunchy_postgresql/pgo-namespace.yaml
${KUBE_DELETE} -f manifests/services/home-services-namespace.yaml

#${KUBE_DELETE} -f manifests/dns/external-dns/external-dns.yaml
