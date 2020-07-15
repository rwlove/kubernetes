#!/bin/bash

KUBE_CREATE='kubectl create'

${KUBE_CREATE} -f manifests/volumes/mpd-music-volume-pv.yaml

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
