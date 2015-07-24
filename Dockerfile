FROM phusion/baseimage:0.9.11

MAINTAINER madevil

# Set correct environment variables
ENV DEBIAN_FRONTEND noninteractive

ENV MADSONIC madsonic
ENV MADSONIC_VERSION 6.0
ENV MADSONIC_BUILD 6870
ENV MADSONIC_DATE 20150724

ENV HOME            /root
ENV LC_ALL          en_US.UTF-8
ENV LANG            en_US.UTF-8
ENV LANGUAGE        en_US.UTF-8

# Use init system
CMD ["/sbin/my_init"]

# Fix ids
RUN usermod -u 99 nobody
RUN usermod -g 100 nobody

# recheck updates
RUN apt-get update -q

# install dependencies for madsonic
RUN apt-get install -qqy unzip wget openjdk-7-jre locales
RUN apt-get clean

# install madsonic
RUN wget http://madsonic.org/download/6.0/20150724_madsonic-6.0.6870.deb /tmp/madsonic.deb
RUN dpkg -i /tmp/madsonic.deb && rm -f /tmp/*.deb

# default http https port
EXPOSE 4040 4050

# App configuration
VOLUME /config

# media directory
VOLUME /media

# set security
RUN chown -R nobody:users /var/madsonic
RUN chown -R nobody:users /var/madsonic/transcode/
RUN chmod -R 777 /var/madsonic/transcode/

# Add madsonic to runit
RUN mkdir /etc/service/madsonic
ADD madsonic.sh /etc/service/madsonic/run
RUN chmod +x /etc/service/madsonic/run

