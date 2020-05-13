#!/bin/bash

docker build $* -t rwlove/mpd .

docker push rwlove/mpd
