# Purify

A lightweight DNS-based adblocker packaged as a Docker image. Blocked hosts are updated daily from [Steven Black's hosts project](https://github.com/StevenBlack/hosts).

## Tags

`schmich/purify:2.76-r1`: dnsmasq 2.76-r1 on Alpine 3.5 x86-64  
`schmich/purify:2.76-r1-arm`: dnsmasq 2.76-r1 on Alpine 3.5 ARM

## Usage

You can pull and run the server directly from Docker Hub. Choose a stable tag from above to use in place of `latest` below.

```
docker run --name purify -d -p 53:53/tcp -p 53:53/udp --cap-add=NET_ADMIN \
  --restart always schmich/purify:latest
```

This exposes TCP/UDP port 53 on the host machine to listen for DNS requests.

## Updating Clients

Once you have your dnsmasq server running, you'll need to update your router's or client's DNS settings to point to your server's IP.

- Phones must be rooted to set DNS for cellular networks
- Flush your device's DNS cache to see immediate effects
  - macOS: `sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder`
  - Windows: `ipconfig /flushdns`
  - Chrome: `chrome://net-internals/#dns`
  - Phones: Reboot

## Advanced

### Upstream DNS

By default, this container uses the host's DNS settings for upstream name resolution. Alternatively, you can specify custom upstream DNS servers with Docker's `--dns` option. For example, to use Google's DNS servers:

```
docker run --name purify -d -p 53:53/tcp -p 53:53/udp --cap-add=NET_ADMIN \
  --dns 8.8.8.8 --dns 8.8.4.4 \
  --restart always schmich/purify:latest
```

### Custom hosts

You can specify your own host block list with the `HOSTS_URLS` Docker environment variable. Each URL in `HOSTS_URLS` (separated by `;`) is downloaded to create the combined blocked hosts list. Only hosts that resolve to `0.0.0.0` are used.

Blocked hosts are updated daily. See [Steven Black's blocked hosts lists](https://github.com/StevenBlack/hosts#list-of-all-hosts-file-variants) for more options.

```
docker run --name purify -d -p 53:53/tcp -p 53:53/udp --cap-add=NET_ADMIN \
  -e HOSTS_URLS="https://raw.githubusercontent.com/my/hosts/list" \
  --restart always schmich/purify:latest
```

### Debugging

Run the server in the foreground and log all DNS queries:

```
docker run --name purify -p 53:53/tcp -p 53:53/udp --cap-add=NET_ADMIN \
  schmich/purify:latest --log-facility=- --log-queries
```

Run a DNS query directly against your server (where `192.168.1.100` is your DNS server's IP):

```
dig @192.168.1.100 doubleclick.net
```

Blocked domains resolve to `0.0.0.0`.

## Credits

- Blocked domains: [Steven Black's hosts project](https://github.com/StevenBlack/hosts)
- dnsmasq x86-64 base image: [Andy Shinn's docker-dnsmasq project](https://github.com/andyshinn/docker-dnsmasq)

## License

Copyright &copy; 2016 Chris Schmich  
MIT License. See [LICENSE](LICENSE) for details.
