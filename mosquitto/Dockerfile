# Pull base image
FROM resin/rpi-raspbian:jessie

RUN apt-get update && apt-get install -y wget apt-transport-https
RUN apt-get install -y --no-install-recommends apt-utils

RUN wget -q -O - http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key | apt-key add -
RUN wget -q -O /etc/apt/sources.list.d/mosquitto-jessie.list http://repo.mosquitto.org/debian/mosquitto-jessie.list
RUN apt-get update && apt-get install -y mosquitto

RUN adduser --system --disabled-password --disabled-login mosquitto

# install filesystem overlay
COPY /root /
COPY config /data/mqtt/config
VOLUME ["/data/mqtt/config", "/data/mqtt/data", "/data/mqtt/log"]

CMD ["/bin/bash", "/usr/local/bin/start.sh"]
