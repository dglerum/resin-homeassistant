#!/bin/bash

readonly ssh_config_dir="/data/.ssh"

# create ssh config dir if it does not exist
mkdir -p "${ssh_config_dir}" 2>/dev/null || true

# set permissions on ssh config dir
chmod 700 "${ssh_config_dir}"

# For each of the key types (rsa, dsa, ecdsa, and ed25519) for which
# host keys do not exist, generate the host keys with the default
# key file path, an empty passphrase, default bits for the key
# type, and default comment.
/usr/bin/ssh-keygen -A

# start sshd if we don't use the init system
if [ "${INITSYSTEM}" != "on" ]
then
	echo "manually starting sshd..."
	/usr/sbin/sshd -p 22 &
fi

echo "starting home assistant..."
/usr/bin/python3 -m homeassistant --config /data
