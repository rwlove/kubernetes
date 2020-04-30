#!/bin/bash

KUBE_CREATE='kubectl create'
NAMESPACE='-n home-services'

echo "#### Initialize Calico ####"
kubectl apply -f calico.yaml

${KUBE_CREATE} -f manifests/services/home-services-namespace.json

${KUBE_CREATE} -f manifests/dns/external-dns/external-dns.yaml

${KUBE_CREATE} ${NAMESPACE} -f manifests/volumes/music-volume.yaml

${KUBE_CREATE} ${NAMESPACE} -f manifests/volumes/pvc.yaml

${KUBE_CREATE} ${NAMESPACE} -f manifests/db/mysql-pv.yaml
${KUBE_CREATE} ${NAMESPACE} -f manifests/db/mysql-deployment.yaml

${KUBE_CREATE} ${NAMESPACE} -f manifests/services/pihole/pihole-service.yaml
${KUBE_CREATE} ${NAMESPACE} -f manifests/services/pihole/pihole.yaml

${KUBE_CREATE} ${NAMESPACE} -f manifests/services/nginx-hello/nginx-hello.yaml
${KUBE_CREATE} ${NAMESPACE} -f manifests/services/nginx-hello/nginx-hello-service.yaml

${KUBE_CREATE} ${NAMESPACE} -f manifests/services/homeassistant/homeassistant.yaml
${KUBE_CREATE} ${NAMESPACE} -f manifests/services/homeassistant/homeassistant-service.yaml

${KUBE_CREATE} ${NAMESPACE} -f manifests/services/subsonic/subsonic.yaml
${KUBE_CREATE} ${NAMESPACE} -f manifests/services/subsonic/subsonic-service.yaml

${KUBE_CREATE} -f manifests/lb/metallb-namespace.yaml

${KUBE_CREATE} -f manifests/lb/metallb.yaml

${KUBE_CREATE} secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

${KUBE_CREATE} -f configmap/lb/metallb.yaml

${KUBE_CREATE} -f manifests/lb/nginx-ingress.yaml

${KUBE_CREATE} -f manifests/tools/dnsutils.yaml
