FROM ubuntu:20.04

# install wget to download the deb
RUN  apt-get update \
  && apt-get install -y wget unzip \
  && rm -rf /var/lib/apt/lists/*

# download and install openttd
ENV VERSION=1.10.3
RUN  wget -q -O /tmp/openttd.deb https://cdn.openttd.org/openttd-releases/$VERSION/openttd-$VERSION-linux-ubuntu-focal-amd64.deb \
  && dpkg -i /tmp/openttd.deb; \
     apt-get update \
  && apt-get install -y -f \
  && rm -rf /var/lib/apt/lists/* \
  && rm -f /tmp/openttd.deb
# game should be installed to /usr/games/openttd

# create an unprivileged user account to run the server with
RUN groupadd -r openttd && useradd -rm -g openttd openttd
WORKDIR /home/openttd

USER openttd
RUN mkdir -p /home/openttd/.openttd/save

VOLUME /home/openttd/.openttd
VOLUME /home/openttd/.openttd/save

# set graphics set version
ENV OPENGFX_VERSION=0.6.0

EXPOSE 3979
EXPOSE 3979/udp
COPY --chown=openttd:openttd start-server.sh /home/openttd/start-server.sh
CMD ["/home/openttd/start-server.sh"]
