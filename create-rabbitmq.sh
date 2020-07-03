#!/bin/bash

KUBE_CREATE='kubectl create'

${KUBE_CREATE} -f manifests/volumes/rabbitmq-pv.yaml

${KUBE_CREATE} namespace rabbitmq

echo "############"
echo "Install RabbitMQ"
echo "######"
helm repo add bitnami https://charts.bitnami.com/bitnami
helm -n rabbitmq install rabbitmq -f helm/rabbitmq.yaml bitnami/rabbitmq
