#!/bin/bash

KUBE_CREATE='kubectl create'
NAMESPACE='-n home-services'

curl -sL https://github.com/operator-framework/operator-lifecycle-manager/releases/download/0.14.1/install.sh | bash -s 0.14.1

echo "############"
echo "Create namespaces"
echo "######"
${KUBE_CREATE} -f manifests/services/home-services-namespace.yaml
#${KUBE_CREATE} -f manifests/db/crunchy_postgresql/pgo-namespace.yaml

#${KUBE_CREATE} -f manifests/dns/external-dns/external-dns.yaml

echo "############"
echo "Create Physical (Storage) Volumes"
echo "######"
#${KUBE_CREATE} -f manifests/volumes/postgress-subsonic-pv.yaml
${KUBE_CREATE} -f manifests/volumes/subsonic-mysql-pv.yaml
${KUBE_CREATE} -f manifests/volumes/nextcloud-mysql-pv.yaml
#${KUBE_CREATE} -f manifests/volumes/mariadb-nextcloud-pv.yaml
#${KUBE_CREATE} -f manifests/volumes/mariadb-subsonic-pv.yaml
${KUBE_CREATE} -f manifests/volumes/subsonic-music-volume-pv.yaml
${KUBE_CREATE} -f manifests/volumes/mpd-music-volume-pv.yaml
${KUBE_CREATE} -f manifests/volumes/nextcloud-pv.yaml
${KUBE_CREATE} -f manifests/volumes/homeassistant-pv.yaml
${KUBE_CREATE} -f manifests/volumes/prometheus-server-pv.yaml
${KUBE_CREATE} -f manifests/volumes/prometheus-alertmanager-pv.yaml
${KUBE_CREATE} -f manifests/volumes/mythtv-pv.yaml

echo "############"
echo "Install postgress-operator"
echo "######"
${KUBE_CREATE} -f olm/postgres-operator.yaml

echo "############"
echo "Install kalkeye helm repo and install mosquitto"
echo "######"
${KUBE_CREATE} -f manifests/mosquitto/mosquitto-namespace.yaml
helm repo add halkeye https://halkeye.github.io/helm-charts/
helm install -n mosquitto mosquitto halkeye/mosquitto --version 0.1.0 -f helm/mosquitto.yaml

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

echo "############"
echo "Install Node Red from Helm"
echo "######"
${KUBE_CREATE} -f manifests/node-red/node-red-namespace.yaml
#helm install -n node-red node-red -f helm/node-red.yaml stable/node-red

echo "############"
echo "Install Home Assistant from Helm"
echo "######"
${KUBE_CREATE} -f manifests/homeassistant/homeassistant-namespace.yaml
kubectl -n homeassistant create secret generic git-creds --from-file=ssh-privatekey=/root/.ssh/id_rsa --from-file=ssh-publickey=/root/.ssh/id_rsa.pub
helm install -n homeassistant homeassistant -f helm/homeassistant.yaml stable/home-assistant

echo "############"
echo "Install grafana with helm"
echo "######"
helm install ${NAMESPACE} grafana -f helm/grafana.yaml stable/grafana

echo "############"
echo "Install prometheus with helm"
echo "######"
helm install ${NAMESPACE} prometheus -f helm/prometheus.yaml stable/prometheus

echo "############"
echo "Create nextcloud with helm"
echo "######"
${KUBE_CREATE} -f manifests/services/nextcloud/nextcloud.yaml
helm install -n nextcloud nextcloud -f helm/nextcloud.yaml --set nextcloud.username=admin,nextcloud.password=password,externalDatabase.type=mysql,externalDatabase.host=mysql-service,externalDatabase.database=nextcloud,externalDatabase.user=nextcloud,externalDatabase.password=password stable/nextcloud

echo "############"
echo "Create pihole"
echo "######"
${KUBE_CREATE} ${NAMESPACE} -f manifests/services/pihole/pihole-service.yaml
${KUBE_CREATE} ${NAMESPACE} -f manifests/services/pihole/pihole.yaml

echo "############"
echo "Create nginx-hello"
echo "######"
${KUBE_CREATE} ${NAMESPACE} -f manifests/services/nginx-hello/nginx-hello.yaml
${KUBE_CREATE} ${NAMESPACE} -f manifests/services/nginx-hello/nginx-hello-service.yaml

echo "############"
echo "Create Subsonic"
echo "######"
${KUBE_CREATE} -f manifests/services/subsonic/subsonic.yaml
${KUBE_CREATE} -f manifests/services/subsonic/subsonic-service.yaml

echo "############"
echo "Create MythTV Backend"
echo "######"
${KUBE_CREATE} -f manifests/services/mythtv/mythtv.yaml

echo "############"
echo "Create mpd"
echo "######"
kubectl label nodes worker1 sound=bathroom-audio
${KUBE_CREATE} -f manifests/services/mpd/mpd.yaml
${KUBE_CREATE} -f manifests/services/mpd/mpd-service.yaml

echo "############"
echo "Start mpd"
echo "######"
mpd_pod=
while [ -z $mpd_pod ] ; do
    mpd_pod=`kubectl -n mpd get pods | grep mpd | awk '{print $1}'`
    if [ -z $mpd_pod ] ; then
	sleep 1
    fi
done

if [ ! -z $mpd_pod ] ; then
    echo "Starting MPD (random, repeat, add, play)"
    kubectl -n mpd wait --for=condition=Ready pod/$mpd_pod --timeout=60s
    if [ $? == 0 ] ; then
	kubectl -n mpd exec -ti $mpd_pod -- mpc random on
	kubectl -n mpd exec -ti $mpd_pod -- mpc repeat on
	kubectl -n mpd exec -ti $mpd_pod -- mpc add "80's"
	kubectl -n mpd exec -ti $mpd_pod -- mpc play
    fi
fi

echo "############"
echo "Create rompr"
echo "######"
${KUBE_CREATE} -f manifests/services/rompr/rompr.yaml
${KUBE_CREATE} -f manifests/services/rompr/rompr-service.yaml

echo "############"
echo "Create k8sdash"
echo "######"
${KUBE_CREATE} -f manifests/dashboard/kubernetes-k8dash.yaml

echo "############"
echo "Create dnsutils"
echo "######"
${KUBE_CREATE} -f manifests/tools/dnsutils.yaml

echo "############"
echo "Create MetalLB"
echo "######"
${KUBE_CREATE} -f manifests/lb/metallb-namespace.yaml
${KUBE_CREATE} -f manifests/lb/metallb.yaml
${KUBE_CREATE} secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
${KUBE_CREATE} -f configmap/lb/metallb.yaml

#${KUBE_CREATE} -f manifests/lb/nginx-ingress.yaml
