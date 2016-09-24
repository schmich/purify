#!/bin/sh

/etc/periodic/daily/update-hosts
crond -b
exec dnsmasq -k $*
