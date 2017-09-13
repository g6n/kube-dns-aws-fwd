FROM ubuntu:16.04
MAINTAINER G6NUK (g6n@pnpenterprises.co.uk)
RUN apt-get update && \
    apt-get install -y bind9 bind9utils cron ntp ntpdate vim &&\
    apt-get clean && \
    /usr/sbin/rndc-confgen -a

COPY rootupd.cron /tmp/ 
COPY ukntp.conf /etc/ntp.conf
COPY named.conf.options /etc/bind/named.conf.options

CMD touch /var/lib/dhcp/dhcpd.leases && crontab /tmp/rootupd.cron && tail -f /var/lib/dhcp/dhcpd.leases
