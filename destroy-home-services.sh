#!/bin/bash

KUBE_DELETE='kubectl delete'
NAMESPACE='-n home-services'

./destroy-metallb.sh

echo "############"
echo "Delete dnsutils"
echo "######"
${KUBE_DELETE} -f manifests/tools/dnsutils.yaml

echo "############"
echo "Delete k8dash"
echo "######"
${KUBE_DELETE} -f manifests/dashboard/kubernetes-k8dash.yaml

#./destroy-mythtv-backend.sh

./destroy-mpd.sh

./destroy-sonarr.sh

./destroy-radarr.sh

./destroy-lidarr.sh

./destroy-airsonic.sh

./destroy-photoprism.sh

./destroy-jackett.sh

#echo "############"
#echo "Delete nginx-hello"
#echo "######"
#${KUBE_DELETE} ${NAMESPACE} -f manifests/services/nginx-hello/nginx-hello-service.yaml
#${KUBE_DELETE} ${NAMESPACE} -f manifests/services/nginx-hello/nginx-hello.yaml

./destroy-pihole.sh

#echo "############"
#echo "Delete MythTV Backend"
#echo "######"
#${KUBE_DELETE} -f manifests/services/mythtv/mythtv.yaml

#echo "############"
#echo "Delete Subsonic"
#echo "######"
#${KUBE_DELETE} -f manifests/services/subsonic/subsonic-service.yaml
#${KUBE_DELETE} -f manifests/services/subsonic/subsonic.yaml

#echo "############"
#echo "Delete Nextcloud"
#echo "######"
#helm uninstall -n nextcloud nextcloud
#${KUBE_DELETE} -f manifests/services/nextcloud/nextcloud.yaml

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

./destroy-heimdall.sh

./destroy-mailu.sh

./destroy-speedtest.sh

./destroy-qbittorrentvpn.sh

./destroy-qbittorrent.sh

#./destroy-grocy.sh

#./destroy-hass.sh

#echo "############"
#echo "Uninstall Node Red"
#echo "######"
#helm -n node-red uninstall node-red
#${KUBE_DELETE} -f manifests/node-red/node-red-namespace.yaml

./destroy-node-red.sh

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

#echo "############"
#echo "Delete BiglyBT"
#echo "######"
#${KUBE_DELETE} -f manifests/services/biglybt/biglybt.yaml

echo "############"
echo "Delete Kanboard"
echo "######"
${KUBE_DELETE} -f manifests/services/kanboard/kanboard.yaml

#echo "############"
#echo "Delete github-actions-runner"
#echo "######"
#${KUBE_DELETE} -f operators/github-actions-runner.yaml
#helm uninstall -n github-actions-runner github-actions-runner-operator
#${KUBE_DELETE} namespace github-actions-runner
#helm repo remove evryfs-oss

#echo "############"
#echo "Delete kalkeye helm repo and install mosquitto"
#echo "######"
#${KUBE_DELETE} -f helm/mosquitto.yaml
#helm -n mosquitto uninstall mosquitto
#helm repo remove halkeye
#${KUBE_DELETE} -f manifests/mosquitto/mosquitto-namespace.yaml

#echo "############"
#echo "Delete postgress-operator"
#echo "######"
#${KUBE_DELETE} -f manifests/postgres/postgres-operator-ui.yaml
#${KUBE_DELETE} -f olm/postgres-operator.yaml

./destroy-rabbitmq.sh

./destroy-cert-manager.sh

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
#${KUBE_DELETE} -f manifests/volumes/biglybt-pv.yaml
${KUBE_DELETE} -f manifests/volumes/kanboard-pv.yaml
#${KUBE_DELETE} -f manifests/volumes/mythtv-pv.yaml
${KUBE_DELETE} -f manifests/volumes/prometheus-alertmanager-pv.yaml
${KUBE_DELETE} -f manifests/volumes/prometheus-server-pv.yaml
#${KUBE_DELETE} -f manifests/volumes/nextcloud-pv.yaml
${KUBE_DELETE} -f manifests/volumes/mpd-music-volume-pv.yaml
${KUBE_DELETE} -f manifests/volumes/subsonic-music-volume-pv.yaml
#${KUBE_DELETE} -f manifests/volumes/mariadb-nextcloud-pv.yaml
#${KUBE_DELETE} -f manifests/volumes/mariadb-subsonic-pv.yaml
#${KUBE_DELETE} -f manifests/volumes/postgress-subsonic-pv.yaml
#${KUBE_DELETE} -f manifests/volumes/nextcloud-mysql-pv.yaml
#${KUBE_DELETE} -f manifests/volumes/subsonic-mysql-pv.yaml
${KUBE_DELETE} -f manifests/volumes/rabbitmq-pv.yaml

#${KUBE_DELETE} -f manifests/dns/external-dns/external-dns.yaml
