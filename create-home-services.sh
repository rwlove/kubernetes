#!/bin/bash

KUBE_CREATE='kubectl create'
NAMESPACE='-n home-services'

curl -sL https://github.com/operator-framework/operator-lifecycle-manager/releases/download/0.14.1/install.sh | bash -s 0.14.1

${KUBE_CREATE} -f manifests/services/home-services-namespace.yaml
${KUBE_CREATE} -f manifests/db/crunchy_postgresql/pgo-namespace.yaml

#${KUBE_CREATE} -f manifests/dns/external-dns/external-dns.yaml

${KUBE_CREATE} -f manifests/volumes/mariadb-nextcloud-pv.yaml
${KUBE_CREATE} -f manifests/volumes/mariadb-subsonic-pv.yaml
${KUBE_CREATE} -f manifests/volumes/music-volume-pv.yaml
${KUBE_CREATE} -f manifests/volumes/nextcloud-pv.yaml

${KUBE_CREATE} ${NAMESPACE} -f operators/kubemq-operator.yaml
${KUBE_CREATE} -f manifests/services/kubemq/kubemq-cluster.yaml
${KUBE_CREATE} -f manifests/services/kubemq/kubemq-dashboard.yaml

${KUBE_CREATE} ${NAMESPACE} -f manifests/db/mysql-pv.yaml
${KUBE_CREATE} ${NAMESPACE} -f manifests/db/mysql-deployment.yaml

export PGOROOT=/home/rwlove/kubernetes/workspace/postgres-operator

echo "############"
echo "Create the pgo-backrest-repo-config Secret that is used by the operator."
echo "######"
kubectl create secret generic -n pgo pgo-backrest-repo-config \
	--from-file=config=$PGOROOT/conf/pgo-backrest-repo/config \
	--from-file=sshd_config=$PGOROOT/conf/pgo-backrest-repo/sshd_config \
	--from-file=aws-s3-credentials.yaml=$PGOROOT/conf/pgo-backrest-repo/aws-s3-credentials.yaml \
	--from-file=aws-s3-ca.crt=$PGOROOT/conf/pgo-backrest-repo/aws-s3-ca.crt

echo "############"
echo "Create the pgo-auth-secret Secret that is used by the operator."
echo "######"
kubectl create secret generic -n pgo pgo-auth-secret \
	--from-file=server.crt=$PGOROOT/conf/postgres-operator/server.crt \
	--from-file=server.key=$PGOROOT/conf/postgres-operator/server.key

echo "############"
echo "Install the bootstrap credentials:"
echo "######"
$PGOROOT/deploy/install-bootstrap-creds.sh

echo "############"
echo "Remove existing credentials for pgo-apiserver TLS REST API, if they exist."
echo "######"
kubectl delete secret -n pgo tls pgo.tls

echo "############"
echo "Create credentials for pgo-apiserver TLS REST API"
echo "######"
kubectl create secret -n pgo tls pgo.tls \
	--key=$PGOROOT/conf/postgres-operator/server.key \
	--cert=$PGOROOT/conf/postgres-operator/server.crt

echo "############"
echo "Create the pgo-config ConfigMap that is used by the operator."
echo "######"
kubectl create configmap -n pgo pgo-config \
	--from-file=$PGOROOT/conf/postgres-operator

echo "############"
echo "Install the operator."
echo " - After install, watch your operator come up using next command."
echo "   $ kubectl get csv -n my-postgresql"
echo "######"
kubectl create -f operators/postgresql.yaml

echo "############"
echo "Create the subsonic PostgreSQL database"
echo "######"
kubectl create -f manifests/db/crunchy_postgresql/subsonic-db.yaml

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

${KUBE_CREATE} -f manifests/services/subsonic/subsonic.yaml
${KUBE_CREATE} -f manifests/services/subsonic/subsonic-service.yaml

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
