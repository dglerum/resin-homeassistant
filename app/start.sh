#!/bin/bash

# make ssh config dir persist
readonly ssh_config_dir="/data/.ssh"
readonly stopped_timeout="300"

# create ssh config dir if it does not exist
mkdir -p "${ssh_config_dir}" 2>/dev/null || true

# set permissions on ssh config dir
chmod -R 700 "${ssh_config_dir}"

# for each of the key types (rsa, dsa, ecdsa, and ed25519) for which
# host keys do not exist, generate the host keys with the default
# key file path, an empty passphrase, default bits for the key
# type, and default comment
/usr/bin/ssh-keygen -A

echo "starting ssh server..."
/usr/sbin/sshd -p 22 &

echo "starting home assistant..."
/usr/bin/python3 -m homeassistant --config /data &

echo "starting watchdog..."
stopped_seconds=0
while /bin/true
do
    sleep 30
    if ps aux | grep homeassistant | grep -q -v grep
    then
        stopped_seconds=0
    else
        stopped_seconds=$((stopped_seconds + 30))
        echo "homeassistant process not found for ${stopped_seconds} seconds..."
    fi
    if [ ${stopped_seconds} -ge ${stopped_timeout} ]
    then
        echo "stopping container..."
        exit -1
    fi
done