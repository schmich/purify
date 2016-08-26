#!/bin/sh
                                                                                 
hosts=$(curl -s https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts)
if [[ $? -eq 0 ]]; then         
  echo 'Updating hosts.blocked.'    
  echo "$hosts" | grep -i '^0.0.0.0 ' > /etc/hosts.blocked
fi                          

dnsmasq=`pidof dnsmasq`
if [[ $? -eq 0 ]]; then
  echo 'Reload dnsmasq hosts.'
  kill -SIGHUP `pidof dnsmasq`
fi
