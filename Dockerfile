FROM debian:stretch

ENV ICINGA2_USER_FULLNAME="Icinga2"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8 

RUN export DEBIAN_FRONTEND=noninteractive \
     && apt-get update \
     && apt-get upgrade -y \
     && apt-get install -y --no-install-recommends \
          ca-certificates \
          dnsutils \
          gnupg \
          locales \
          snmp \
          ssmtp \
          sudo \
          git \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/* 

RUN export DEBIAN_FRONTEND=noninteractive \
    && cd /usr/share \
    && apt-get update \
    && apt-get install -y cmake build-essential pkg-config libssl-dev libboost-all-dev bison flex \
        libsystemd-dev default-libmysqlclient-dev libpq-dev libyajl-dev libedit-dev \
    && apt-get clean \
    && groupadd icinga \
    && groupadd icingacmd \
    && useradd -c "icinga" -s /sbin/nologin -G icingacmd -g icinga icinga \
    && usermod -a -G icingacmd www-data \
    && git clone https://github.com/Icinga/icinga2.git icinga2 \
    && cd icinga2 \
    && mkdir build && cd build \
    && cmake .. \
    && make \
    && make install

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        monitoring-plugins \
        nagios-nrpe-plugin \
        nagios-snmp-plugins \
        nagios-plugins-contrib \
     && apt-get clean

ADD content/ /

# Final fixes
RUN true \
    && chmod +x /opt/start.sh \
    && chmod u+s,g+s \
        /bin/ping \
        /bin/ping6 \
        /usr/lib/nagios/plugins/check_icmp 

# Initialize and run Supervisor
ENTRYPOINT ["/opt/start.sh"]
