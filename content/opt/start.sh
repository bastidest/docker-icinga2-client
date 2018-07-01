#!/bin/bash

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