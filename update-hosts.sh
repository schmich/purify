#!/bin/sh

urls=$HOSTS_URLS
if [[ -z "$urls" ]]; then
  urls=https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
fi

hosts=$(for url in $(echo "$urls" | tr "|" "\n"); do
  echo "Downloading hosts from $url." 1>&3
  curl -s "$url"
done | sort | uniq) 3>&1
 
if [[ $? -eq 0 ]]; then
  echo 'Updating hosts.blocked.'
  echo "$hosts" | grep -i '^0.0.0.0 ' > /etc/hosts.blocked
fi

dnsmasq=`pidof dnsmasq`
if [[ $? -eq 0 ]]; then
  echo 'Reload dnsmasq hosts.'
  kill -SIGHUP $dnsmasq
fi
