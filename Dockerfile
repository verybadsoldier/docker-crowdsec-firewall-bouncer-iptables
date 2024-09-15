FROM debian:12.7-slim

ARG update-ipsets_commit=86b1729b37cf45250ef71b4c3fc2314a66de7d34

ARG USERNAME=firehol-update-ipsets
ARG USER_UID=6721
ARG USER_GID=$USER_UID


# Create the user
#RUN addgroup -g $USER_GID $USERNAME \
#    && adduser -u $USER_UID --disabled-password --uid $USER_UID -G $USERNAME --ingroup $USERNAME $USERNAME

RUN apt update && apt install -y curl sudo

RUN curl -s https://install.crowdsec.net | sudo sh


RUN apt install -y crowdsec-firewall-bouncer-iptables

RUN update-alternatives --set iptables /usr/sbin/iptables-legacy && update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
#RUN update-alternatives --set iptables /usr/sbin/iptables-legacy && update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy && update-alternatives --set arptables /usr/sbin/arptables-legacy && update-alternatives --set ebtables /usr/sbin/ebtables-legacy

CMD ["/bin/update-ipsets-periodic"]
