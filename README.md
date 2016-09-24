# Purify

A lightweight DNS-based adblocker packaged as an 8MB Docker image. Blocked domains are updated daily from [Steven Black's hosts project](https://github.com/StevenBlack/hosts).

## Running

You can pull and run the server directly from Docker Hub. It's safest to [choose a stable tag](https://hub.docker.com/r/schmich/purify/tags) to use in place of `latest` below.

```
docker run --name purify \
  -d -p 53:53/tcp -p 53:53/udp --cap-add=NET_ADMIN \
  --restart always schmich/purify:latest
```

You can specify your own hosts to block with the `HOSTS_URLS` Docker environment variable. Each URL in `HOSTS_URLS` (separated by `|`) is downloaded to create the combined blocked hosts list. Only hosts that resolve to `0.0.0.0` are used. See [here](https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts) for an example.

Blocked hosts are updated daily.

## Updating Clients

- DNS nameservers can be set on your router or on individual devices
- Phones must be rooted to set DNS for cellular networks
- Flush your device's DNS cache to see immediate effects
  - macOS: `sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder`
  - Windows: `ipconfig /flushdns`
  - Chrome: `chrome://net-internals/#dns`
  - Phones: Reboot

## Debugging

Run the server in the foreground and log all DNS queries:

```
docker run --name purify \
  -p 53:53/tcp -p 53:53/udp --cap-add=NET_ADMIN \
  schmich/purify:latest \
  --log-facility=- --log-queries
```

Run a DNS query directly against your server (where `1.2.3.4` is your DNS server's IP):

```
dig @1.2.3.4 doubleclick.net
```

Blocked domains resolve to `0.0.0.0`.

## Credits

- Blocked domains: [Steven Black's hosts project](https://github.com/StevenBlack/hosts)
- dnsmasq base image: [Andy Shinn's docker-dnsmasq project](https://github.com/andyshinn/docker-dnsmasq)

## License

Copyright &copy; 2016 Chris Schmich  
MIT License. See [LICENSE](LICENSE) for details.
