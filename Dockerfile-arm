FROM schmich/dnsmasq:2.76-r1-arm
MAINTAINER Chris Schmich <schmch@gmail.com>
COPY dnsmasq.conf /etc/dnsmasq.conf
COPY update-hosts.sh /etc/periodic/daily/update-hosts
COPY start.sh /srv/purify/start.sh
RUN ["cross-build-start"]
RUN apk add --no-cache curl \
 && chmod +x /etc/periodic/daily/update-hosts \
 && /etc/periodic/daily/update-hosts \
 && chmod +x /srv/purify/start.sh
RUN ["cross-build-end"]
EXPOSE 53 53/udp
ENTRYPOINT ["/srv/purify/start.sh"]
