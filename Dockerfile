FROM debian:12.7-slim

RUN apt update && \
    apt install -y curl sudo libcap2-bin && \
    curl -s https://install.crowdsec.net | sh && \
    apt install -y crowdsec-firewall-bouncer-iptables && \
    update-alternatives --set iptables /usr/sbin/iptables-legacy && \
    update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy

# set file capabilities so container can be used by non-root user
RUN for f in /usr/sbin/ipset /sbin/xtables-nft-multi /sbin/xtables-legacy-multi; do setcap cap_net_admin,cap_net_raw+eip "${f}"; done

# needed so non-root user can create xtables lock file
RUN chmod 777 /run

CMD ["/usr/bin/crowdsec-firewall-bouncer", "-c", "/etc/crowdsec/bouncers/crowdsec-firewall-bouncer.yaml"]
