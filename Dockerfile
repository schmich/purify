FROM andyshinn/dnsmasq:2.76
RUN apk --no-cache add curl
COPY dnsmasq.conf /etc/dnsmasq.conf
COPY update-hosts.sh /etc/periodic/daily/update-hosts.sh
RUN chmod +x /etc/periodic/daily/update-hosts.sh
RUN /etc/periodic/daily/update-hosts.sh
EXPOSE 53 53/udp
CMD ["crond"]
ENTRYPOINT ["dnsmasq", "-k"]