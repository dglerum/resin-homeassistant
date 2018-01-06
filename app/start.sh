#!/bin/bash

# make ssh config dir persist
readonly ssh_config_dir="/data/.ssh"

# create ssh config dir if it does not exist
mkdir -p "${ssh_config_dir}" 2>/dev/null || true

# set permissions on ssh config dir
chmod -R 700 "${ssh_config_dir}"

# for each of the key types (rsa, dsa, ecdsa, and ed25519) for which
# host keys do not exist, generate the host keys with the default
# key file path, an empty passphrase, default bits for the key
# type, and default comment
/usr/bin/ssh-keygen -A

echo "starting home assistant..."
/usr/bin/python3 -m homeassistant --config /data &

echo "starting ssh server..."
/usr/sbin/sshd -p 22