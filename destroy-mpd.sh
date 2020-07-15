#!/bin/bash

KUBE_DELETE='kubectl delete'

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

${KUBE_DELETE} -f manifests/volumes/mpd-music-volume-pv.yaml
