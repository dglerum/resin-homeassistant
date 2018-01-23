#!/bin/bash
	
# create ssh dir if it does not exist
if [ ! -d "/data/.ssh" ]
then
	mkdir -p "/data/.ssh"
fi

# touch authorized_keys if it does not exist
if [ ! -f "/data/.ssh/authorized_keys" ]
then
	touch "/data/.ssh/authorized_keys"
fi

# set permissions on ssh dir
chown -R root:root "/data/.ssh"
chmod -R 700 "/data/.ssh"

# generate host keys
/usr/bin/ssh-keygen -A

# start services
supervisord -c "/etc/supervisord.conf"
