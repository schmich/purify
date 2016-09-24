FROM andyshinn/dnsmasq:2.76
MAINTAINER Chris Schmich <schmch@gmail.com>
RUN apk add --no-cache curl
COPY dnsmasq.conf /etc/dnsmasq.conf
COPY update-hosts.sh /etc/periodic/daily/update-hosts
RUN chmod +x /etc/periodic/daily/update-hosts
RUN /etc/periodic/daily/update-hosts
RUN mkdir -p /srv/purify
COPY start.sh /srv/purify
RUN chmod +x /srv/purify/start.sh
EXPOSE 53 53/udp
ENTRYPOINT ["/srv/purify/start.sh"]
