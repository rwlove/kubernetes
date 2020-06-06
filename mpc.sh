#!/bin/bash

mpd_pod=`kubectl -n mpd get pods | grep mpd | awk '{print $1}'`
kubectl -n mpd exec -ti $mpd_pod -- mpc $@
