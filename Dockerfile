FROM phusion/baseimage:0.9.16
MAINTAINER pcjacobse <pcjacobse@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

# Set correct environment variables
ENV HOME /root

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Fix a Debianism of the nobody's uid being 65534
RUN usermod -u 99 nobody
RUN usermod -g 100 nobody

RUN add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ trusty universe multiverse"
RUN add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ trusty-updates universe multiverse"
RUN apt-get update -qq
RUN apt-get install -qqy libevent-2.0-5 libnatpmp1

#RUN mkdir /opt/couchpotato
#RUN wget https://github.com/RuudBurger/CouchPotatoServer/archive/master.tar.gz -O /tmp/couchpotato.tar.gz
#RUN tar -C /opt/couchpotato -xvf /tmp/couchpotato.tar.gz --strip-components 1
#RUN chown nobody:users /opt/couchpotato

ADD libminiupnpc10_1.9.20140610-2ubuntu1_amd64.deb /tmp/libminiupnpc10_1.9.20140610-2ubuntu1_amd64.deb
ADD transmission-common_2.84-0.2ubuntu1_all.deb /tmp/transmission-common_2.84-0.2ubuntu1_all.deb
ADD transmission-daemon_2.84-0.2ubuntu1_amd64.deb /tmp/transmission-daemon_2.84-0.2ubuntu1_amd64.deb
RUN dpkg -i /tmp/libminiupnpc10_1.9.20140610-2ubuntu1_amd64.deb
RUN dpkg -i /tmp/transmission-common_2.84-0.2ubuntu1_all.deb
RUN dpkg -i /tmp/transmission-daemon_2.84-0.2ubuntu1_amd64.deb

# Path to a directory that only contains the sabnzbd.conf
VOLUME /config
VOLUME /downloads

EXPOSE 9091
EXPOSE 51413

# Add sabnzbd to runit
RUN mkdir /etc/service/transmission
ADD transmission.sh /etc/service/transmission/run
RUN chmod +x /etc/service/transmission/run

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
