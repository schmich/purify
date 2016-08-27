#!/bin/sh

crond -b
exec dnsmasq -k $*
