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
${KUBE_DELETE} -f manifests/services/rompr/rompr-service.yaml
${KUBE_DELETE} -f manifests/services/rompr/rompr.yaml

echo "############"
echo "Delete mpd"
echo "######"
${KUBE_DELETE} -f manifests/services/mpd/mpd-service.yaml
${KUBE_DELETE} -f manifests/services/mpd/mpd.yaml

echo "############"
echo "Delete nginx-hello"
echo "######"
${KUBE_DELETE} ${NAMESPACE} -f manifests/services/nginx-hello/nginx-hello-service.yaml
${KUBE_DELETE} ${NAMESPACE} -f manifests/services/nginx-hello/nginx-hello.yaml

echo "############"
echo "Delete pihole"
echo "######"
${KUBE_DELETE} -n pihole -f manifests/services/pihole/pihole-service.yaml
${KUBE_DELETE} -n pihole -f manifests/services/pihole/pihole.yaml

echo "############"
echo "Delete MythTV Backend"
echo "######"
${KUBE_DELETE} -f manifests/services/mythtv/mythtv.yaml

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

#echo "############"
#echo "Delete MySQL"
#echo "######"
#${KUBE_DELETE} ${NAMESPACE} -f manifests/db/mysql-deployment.yaml

echo "############"
echo "Uninstall prometheus"
echo "######"
helm uninstall -n prometheus prometheus

echo "############"
echo "Uninstall grafana"
echo "######"
helm uninstall ${NAMESPACE} grafana

echo "############"
echo "Uninstall Home Assistant from Helm"
echo "######"
helm -n homeassistant uninstall homeassistant
kubectl -n homeassistant delete secret git-creds
${KUBE_DELETE} -f manifests/homeassistant/homeassistant-namespace.yaml
helm repo remove billimek

echo "############"
echo "Uninstall Node Red"
echo "######"
#helm -n node-red uninstall node-red
${KUBE_DELETE} -f manifests/node-red/node-red-namespace.yaml

#echo "############"
#echo "Delete the subsonic PostgreSQL database"
#echo "######"
#kubectl delete -f manifests/db/crunchy_postgresql/subsonic-db.yaml

#echo "############"
#echo "Uninstall the operator."
#echo "######"
#kubectl delete -f operators/postgresql.yaml

#echo "############"
#echo "Delete kubemq"
#echo "######"
#${KUBE_DELETE} -f manifests/services/kubemq/kubemq-dashboard.yaml
#${KUBE_DELETE} -f manifests/services/kubemq/kubemq-cluster.yaml
#${KUBE_DELETE} -f operators/kubemq-operator.yaml

echo "############"
echo "Delete BiglyBT"
echo "######"
${KUBE_DELETE} -f manifests/services/biglybt/biglybt.yaml

echo "############"
echo "Delete Kanboard"
echo "######"
${KUBE_DELETE} -f manifests/services/kanboard/kanboard.yaml

echo "############"
echo "Delete kalkeye helm repo and install mosquitto"
echo "######"
${KUBE_DELETE} -f helm/mosquitto.yaml
helm -n mosquitto uninstall mosquitto
helm repo remove halkeye
${KUBE_DELETE} -f manifests/mosquitto/mosquitto-namespace.yaml

echo "############"
echo "Delete postgress-operator"
echo "######"
${KUBE_DELETE} -f manifests/postgres/postgres-operator-ui.yaml
${KUBE_DELETE} -f olm/postgres-operator.yaml

echo "############"
echo "Delete RabbitMQ"
echo "######"
helm -n rabbitmq uninstall rabbitmq
helm repo remove bitnami

#echo "############"
#echo "Delete namespaces (pgo and home-services)"
#echo "######"
#${KUBE_DELETE} -f manifests/db/crunchy_postgresql/pgo-namespace.yaml
${KUBE_DELETE} namespace prometheus
${KUBE_DELETE} -f manifests/services/rabbitmq/rabbitmq-namespace.yaml
${KUBE_DELETE} -f manifests/services/kanboard/kanboard-namespace.yaml
${KUBE_DELETE} -f manifests/services/home-services-namespace.yaml

echo "############"
echo "Delete Physical (storage) Volumes"
echo "######"
${KUBE_DELETE} -f manifests/volumes/biglybt-pv.yaml
${KUBE_DELETE} -f manifests/volumes/kanboard-pv.yaml
${KUBE_DELETE} -f manifests/volumes/mythtv-pv.yaml
${KUBE_DELETE} -f manifests/volumes/prometheus-alertmanager-pv.yaml
${KUBE_DELETE} -f manifests/volumes/prometheus-server-pv.yaml
${KUBE_DELETE} -f manifests/volumes/homeassistant-pv.yaml
${KUBE_DELETE} -f manifests/volumes/nextcloud-pv.yaml
${KUBE_DELETE} -f manifests/volumes/mpd-music-volume-pv.yaml
${KUBE_DELETE} -f manifests/volumes/subsonic-music-volume-pv.yaml
#${KUBE_DELETE} -f manifests/volumes/mariadb-nextcloud-pv.yaml
#${KUBE_DELETE} -f manifests/volumes/mariadb-subsonic-pv.yaml
#${KUBE_DELETE} -f manifests/volumes/postgress-subsonic-pv.yaml
${KUBE_DELETE} -f manifests/volumes/nextcloud-mysql-pv.yaml
${KUBE_DELETE} -f manifests/volumes/subsonic-mysql-pv.yaml
${KUBE_DELETE} -f manifests/volumes/rabbitmq-pv.yaml

#${KUBE_DELETE} -f manifests/dns/external-dns/external-dns.yaml
