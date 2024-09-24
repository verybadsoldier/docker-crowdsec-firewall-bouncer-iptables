# docker-crowdsec-firewall-bouncer-iptables

Docker image for docker-crowdsec-firewall-bouncer-iptable. Can also run as non-root user by using specific capabilities.

## Example docker-compose.yml
```
services:
  crowdsec-firewall-bouncer-iptables:
    image: ghcr.io/verybadsoldier/docker-crowdsec-firewall-bouncer-iptables:1.0.0
    container_name: crowdsec-firewall-bouncer-iptables
    volumes:
      - ./config:/etc/crowdsec/bouncers
    network_mode: "host"    # To ensure it can modify host's iptables
    user: 983:982
    environment:
      - TZ=Europe/Berlin
    cap_drop:
      - ALL
    cap_add:
    - NET_ADMIN
    - NET_RAW
    restart: always
```
