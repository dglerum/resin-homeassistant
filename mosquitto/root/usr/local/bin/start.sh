#!/bin/bash

# create ssh dir if it does not exist
if [ ! -d "/data/mqtt/data" ]
then
	mkdir -p "/data/mqtt/data"
fi

# create ssh dir if it does not exist
if [ ! -d "/data/mqtt/config" ]
then
	mkdir -p "/data/mqtt/config"
fi

# create ssh dir if it does not exist
if [ ! -d "/data/mqtt/log" ]
then
	mkdir -p "/data/mqtt/log"
fi

# touch authorized_keys if it does not exist
if [ ! -f "/data/mqtt/log/mosquitto.log" ]
then
	touch "/data/mqtt/log/mosquitto.log" && chmod o+w "/data/mqtt/log/mosquitto.log"
fi

/usr/sbin/mosquitto -c /data/mqtt/config/mosquitto.conf
