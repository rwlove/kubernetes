FROM alpine
MAINTAINER rwlove <terp4life2001@gmail.com>

RUN apk add --no-cache mpd mpc
COPY mpd.conf /etc/mpd.conf
VOLUME /var/lib/mpd/music
VOLUME /var/lib/mpd/playlists
VOLUME /var/lib/mpd/database

EXPOSE 6600
CMD ["mpd", "--stdout", "--no-daemon"]
