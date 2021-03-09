#!/bin/bash

KUBE_CREATE='kubectl create'
NAMESPACE='-n home-services'

curl -sL https://github.com/operator-framework/operator-lifecycle-manager/releases/download/0.14.1/install.sh | bash -s 0.14.1

#${KUBE_CREATE} -f manifests/dns/external-dns/external-dns.yaml

echo "############"
echo "Create Physical (Storage) Volumes"
echo "######"
#${KUBE_CREATE} -f manifests/volumes/postgress-subsonic-pv.yaml
#${KUBE_CREATE} -f manifests/volumes/subsonic-mysql-pv.yaml
#${KUBE_CREATE} -f manifests/volumes/nextcloud-mysql-pv.yaml
#${KUBE_CREATE} -f manifests/volumes/mariadb-nextcloud-pv.yaml
#${KUBE_CREATE} -f manifests/volumes/mariadb-subsonic-pv.yaml
#${KUBE_CREATE} -f manifests/volumes/subsonic-music-volume-pv.yaml
#${KUBE_CREATE} -f manifests/volumes/nextcloud-pv.yaml
${KUBE_CREATE} -f manifests/volumes/prometheus-server-pv.yaml
${KUBE_CREATE} -f manifests/volumes/prometheus-alertmanager-pv.yaml
#${KUBE_CREATE} -f manifests/volumes/mythtv-pv.yaml
#${KUBE_CREATE} -f manifests/volumes/kanboard-pv.yaml
#${KUBE_CREATE} -f manifests/volumes/biglybt-pv.yaml

echo "############"
echo "Create namespaces"
echo "######"
${KUBE_CREATE} -f manifests/services/home-services-namespace.yaml
${KUBE_CREATE} -f manifests/services/kanboard/kanboard-namespace.yaml
#${KUBE_CREATE} -f manifests/db/crunchy_postgresql/pgo-namespace.yaml
${KUBE_CREATE} namespace prometheus

./create-cert-manager.sh

./create-qbittorrent.sh

./create-rabbitmq.sh

./create-flaresolverr.sh

./create-jellyfin.sh

#echo "############"
#echo "Install postgress-operator"
#echo "######"
#${KUBE_CREATE} -f olm/postgres-operator.yaml
#${KUBE_CREATE} -f manifests/postgres/postgres-operator-ui.yaml
#${KUBE_CREATE} -n kanboard -f manifests/postgres/postgres-operator-crd.yaml


#echo "############"
#echo "Install kalkeye helm repo and install mosquitto"
#echo "######"
#${KUBE_CREATE} -f manifests/mosquitto/mosquitto-namespace.yaml
#helm repo add halkeye https://halkeye.github.io/helm-charts/
#helm install -n mosquitto mosquitto halkeye/mosquitto --version 0.1.0 -f helm/mosquitto.yaml

#echo "############"
#echo "Create github-actions-runner"
#echo "######"
#helm repo add evryfs-oss https://evryfs.github.io/helm-charts/
#${KUBE_CREATE} namespace github-actions-runner
#helm install -n github-actions-runner github-actions-runner-operator evryfs-oss/github-actions-runner-operator
#${KUBE_CREATE} -f operators/github-actions-runner.yaml

echo "############"
echo "Create Kanboard"
echo "######"
${KUBE_CREATE} -f manifests/services/kanboard/kanboard.yaml

#echo "############"
#echo "Create BiglyBT"
#echo "######"
#${KUBE_CREATE} -f manifests/services/biglybt/biglybt.yaml

./create-jackett.sh

./create-radarr.sh

./create-sonarr.sh

./create-lidarr.sh

./create-mpd.sh

./create-photoprism.sh

./create-airsonic.sh



#./create-mythtv-backend.sh

#echo "############"
#echo "Create kubemq"
#echo "######"
#${KUBE_CREATE} -f operators/kubemq-operator.yaml
#${KUBE_CREATE} -f manifests/services/kubemq/kubemq-cluster.yaml
#${KUBE_CREATE} -f manifests/services/kubemq/kubemq-dashboard.yaml
#echo "############"
#echo "Create mysql deployment"
#echo "######"
#${KUBE_CREATE} ${NAMESPACE} -f manifests/db/mysql-deployment.yaml

#export PATH=$PATH:/root/go/bin/

#echo "############"
#echo "Start by cloning the operator repository locally."
#echo "######"
#git clone -b v4.2.2 https://github.com/CrunchyData/postgres-operator.git
#pushd postgres-operator

#echo "############"
#echo "Once the storage backend is defined, enable the new storage option as needed."
#echo "######"
#sed -i 's/PrimaryStorage: storageos/PrimaryStorage: nfsstorage/g' conf/postgres-operator/pgo.yaml
#sed -i 's/ReplicaStorage: storageos/ReplicaStorage: nfsstorage/g' conf/postgres-operator/pgo.yaml
#sed -i 's/BackrestStorage: storageos/BackrestStorage: nfsstorage/g' conf/postgres-operator/pgo.yaml

#echo "############"
#echo "You can generate new self-signed certificates using scripts in the operator repository."
#echo "######"
#export PGOROOT=$(pwd)
#pushd $PGOROOT/deploy
#$PGOROOT/deploy/gen-api-keys.sh
#$PGOROOT/deploy/gen-sshd-keys.sh
#popd # $PGOROOT

#popd #postgres-operator

#echo "############"
#echo "Create the pgo-backrest-repo-config Secret that is used by the operator."
#echo "######"
#kubectl create secret generic -n pgo pgo-backrest-repo-config \
#	--from-file=config=$PGOROOT/conf/pgo-backrest-repo/config \
#	--from-file=sshd_config=$PGOROOT/conf/pgo-backrest-repo/sshd_config \
#	--from-file=aws-s3-credentials.yaml=$PGOROOT/conf/pgo-backrest-repo/aws-s3-credentials.yaml \
#	--from-file=aws-s3-ca.crt=$PGOROOT/conf/pgo-backrest-repo/aws-s3-ca.crt

#echo "############"
#echo "Create the pgo-auth-secret Secret that is used by the operator."
#echo "######"
#kubectl create secret generic -n pgo pgo-auth-secret \
#	--from-file=server.crt=$PGOROOT/conf/postgres-operator/server.crt \
#	--from-file=server.key=$PGOROOT/conf/postgres-operator/server.key

#echo "############"
#echo "Install the bootstrap credentials:"
#echo "######"
#PGO_CMD='kubectl' $PGOROOT/deploy/install-bootstrap-creds.sh

#echo "############"
#echo "Remove existing credentials for pgo-apiserver TLS REST API, if they exist."
#echo "######"
#kubectl delete secret -n pgo tls pgo.tls

#echo "############"
#echo "Create credentials for pgo-apiserver TLS REST API"
#echo "######"
#kubectl create secret -n pgo tls pgo.tls \
#	--key=$PGOROOT/conf/postgres-operator/server.key \
#	--cert=$PGOROOT/conf/postgres-operator/server.crt

#echo "############"
#echo "Create the pgo-config ConfigMap that is used by the operator."
#echo "######"
#kubectl create configmap -n pgo pgo-config \
#	--from-file=$PGOROOT/conf/postgres-operator

#echo "############"
#echo "Install the operator."
#echo " - After install, watch your operator come up using next command."
#echo "   $ kubectl get csv -n my-postgresql"
#echo "######"
#kubectl create -f operators/postgresql.yaml

#echo "############"
#echo "Create the subsonic PostgreSQL database"
#echo "######"
#kubectl create -f manifests/db/crunchy_postgresql/subsonic-db.yaml

./create-node-red.sh

#echo "############"
#echo "Install Node Red from Helm"
#echo "######"
#${KUBE_CREATE} -f manifests/node-red/node-red-namespace.yaml
#helm install -n node-red node-red -f helm/node-red.yaml stable/node-red

#./create-hass.sh

#./create-grocy.sh

#./create-qbittorrent.sh

#./create-qbittorrentvpn.sh

./create-speedtest.sh

#./create-mailu.sh

./create-heimdall.sh

echo "############"
echo "Install grafana with helm"
echo "######"
helm install ${NAMESPACE} grafana -f helm/grafana.yaml stable/grafana

echo "############"
echo "Install prometheus with helm"
echo "######"
helm install -n prometheus prometheus -f helm/prometheus.yaml stable/prometheus

#echo "############"
#echo "Create nextcloud with helm"
#echo "######"
#${KUBE_CREATE} -f manifests/services/nextcloud/nextcloud.yaml
#helm install -n nextcloud nextcloud -f helm/nextcloud.yaml --set nextcloud.username=admin,nextcloud.password=password,externalDatabase.type=mysql,externalDatabase.host=mysql-service,externalDatabase.database=nextcloud,externalDatabase.user=nextcloud,externalDatabase.password=password stable/nextcloud

./create-pihole.sh

#echo "############"
#echo "Create nginx-hello"
#echo "######"
#${KUBE_CREATE} ${NAMESPACE} -f manifests/services/nginx-hello/nginx-hello.yaml
#${KUBE_CREATE} ${NAMESPACE} -f manifests/services/nginx-hello/nginx-hello-service.yaml

#echo "############"
#echo "Create Subsonic"
#echo "######"
#${KUBE_CREATE} -f manifests/services/subsonic/subsonic.yaml
#${KUBE_CREATE} -f manifests/services/subsonic/subsonic-service.yaml

#echo "############"
#echo "Create MythTV Backend"
#echo "######"
#${KUBE_CREATE} -f manifests/services/mythtv/mythtv.yaml

echo "############"
echo "Create k8sdash"
echo "######"
${KUBE_CREATE} -f manifests/dashboard/kubernetes-k8dash.yaml

echo "############"
echo "Create dnsutils"
echo "######"
${KUBE_CREATE} -f manifests/tools/dnsutils.yaml

./create-metallb.sh

#./create-nginx-ingress.sh
