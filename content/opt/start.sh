#!/bin/bash

if [ ! "$(ls -A /usr/local/etc/icinga2)" ]; then
	echo "=> Copying fresh config-files for /usr/local/etc/icinga2"
	cp -r /usr/local/etc/icinga2.dist/* /usr/local/etc/icinga2/
    #(cd /usr/local/etc/icinga2/conf.d && rm services.conf downtimes.conf notifications.conf groups.conf templates.conf commands.conf hosts.conf users.conf)
fi

mkdir -p /usr/local/var/cache/icinga2
chown -R icinga:icinga /usr/local/var/cache/icinga2

mkdir -p /usr/local/var/log/icinga2
chown -R icinga:icinga /usr/local/var/log/icinga2

mkdir -p /usr/local/var/run/icinga2
chown -R icinga:icinga /usr/local/var/run/icinga2

mkdir -p /usr/local/var/lib/icinga2
chown -R icinga:icinga /usr/local/var/lib/icinga2

echo "Sleeping now..."

sleep 10000000000000000000000