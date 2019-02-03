#!/bin/bash

# create ssh dir if it does not exist
if [ ! -d "/data/.ssh" ]
then
	mkdir -p "/data/.ssh"
fi

if [ ! -d "/data/config" ]
then
	mkdir -p "/data/config"
fi

# touch authorized_keys if it does not exist
if [ ! -f "/data/.ssh/authorized_keys" ]
then
	touch "/data/.ssh/authorized_keys" && echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDv47RgaIeJroxa3lHAcNzFeNOn1i119NghckwdyWfLpVCLAy7MS5p0WBR199+eo3TZT7B+dfHup8DMkvLWQ40EYLtJK0K5r3vU57zxegKFDHLxZ7UykAMV5Hb/GcXZt5n1IUfGm1ohv5kHgke8/JsFjViS0KYqQGAq/MPAB2WahLQdREW9zw4wvaFJWE80EVXo0Xd1Ig8gg2S3k9Qo6j74qNQqYhnrqgMPtG+er5UwI24MejOPLXywfVcfR7Zb4YH7JjbZgVuUEgkS+7tiyIsE6QSSrZpIDEBqq8TeClXYcKYbXif81qUzCaXAQvKoH89Hh9IKj5m3Ph4nloIfoC7/1ZnPtx0PvQ3bvLvqRsddnX362ac4ZpgpkxpyXcLilII8ZYQW+GG2GcLvq/5KzyFHqSpbEfCWAPE6/9Sv2FmbLEt96NPQfNu7yq7CSpcbbQOdTsr5weJys4Xwjuw/y1Xd02mAnHpgVgGWh3T29a4TZt/f5Iqse71MP32cpkUBp1pAe0JJNO4Slu+4HiygSH2hcTo52GmYMXxyUrru0EyvQGTW6JufXdcaJM7iqlqylnwKTlJUwJgzxvsyPRIdmn/vmvvsK0cc3E3qoP7Fv7NrAcSERlq9Q3lxVi/YOPzkyzKMdzpjcAZnN30wQj3opeRPsQavBAIQbD7YhUGu206JIQ== dglerum@Davys-MBP.lan > "/data/.ssh/authorized_keys"
fi

# set permissions on ssh dir
chown -R root:root "/data/.ssh"
chmod -R 700 "/data/.ssh"

# make dropbox_uploader executable
chmod +x /etc/periodic/daily/dropbox_uploader
echo "OAUTH_ACCESS_TOKEN=bPff4qDYTZMAAAAAAABGFf6UJoiB5X-IvpRs-RiueITKhbNdMa5bceZRitRgnMFH" > /root/.dropbox_uploader

# start cron
# crond

# generate host keys
/usr/bin/ssh-keygen -A

# install WazeRouteCalc
pip3 install WazeRouteCalculator

# set timezone
cp /usr/share/zoneinfo/Europe/Brussels /etc/localtime
echo "Europe/Brussels" >  /etc/timezone

# start services
supervisord -c "/etc/supervisord.conf"
