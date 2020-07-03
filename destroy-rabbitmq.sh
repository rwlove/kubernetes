#!/bin/bash

KUBE_DELETE='kubectl delete'

echo "############"
echo "Delete RabbitMQ"
echo "######"
helm -n rabbitmq uninstall rabbitmq
helm repo remove bitnami
