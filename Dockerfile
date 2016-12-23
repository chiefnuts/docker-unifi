FROM lsiobase/xenial

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"

# install packages
RUN \
# echo "deb http://www.ubnt.com/downloads/unifi/debian unifi5 ubiquiti" >> /etc/apt/sources.list && \
#apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50 && \
 apt-get update && \
 apt-get install -y \
	openjdk-8-jre-headless \
	wget 
wget -nv https://www.ubnt.com/downloads/unifi/5.4.7-36a141f5fa/unifi_sysvinit_all.deb && \
dpkg --install unifi_sysvinit_all.deb && \
rm unifi_sysvinit_all.deb && \
# cleanup
 apt-get clean && \
 rm -rfv /tmp/* /var/lib/apt/lists/* /var/tmp/*

# add local files
COPY root/ /

# Volumes and Ports
WORKDIR /usr/lib/unifi
VOLUME /config
EXPOSE 8080 8081 8443 8843 8880
