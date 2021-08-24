FROM docker.elastic.co/elasticsearch/elasticsearch:7.14.0

ENV DISCOVER_HOSTNAME= \
ES_OPTIONS="-Ecluster.name=es -Ediscovery.seed_providers=file" \
DISCOVERY_FREQ_SECONDS=30 \
DISCOVER_FILE=/usr/share/elasticsearch/config/unicast_hosts.txt

ADD https://github.com/krallin/tini/releases/download/v0.18.0/tini /tini
RUN yum -y install bind-utils wget \
&& wget --content-disposition https://packagecloud.io/imeyer/runit/packages/el/7/runit-2.1.2-3.el7.centos.x86_64.rpm/download.rpm \
&& yum -y localinstall runit-2.1.2-3.el7.centos.x86_64.rpm \
&& rm runit-2.1.2-3.el7.centos.x86_64.rpm \
&& yum clean all \
&& chmod +x /tini

COPY service /etc/service
COPY run.sh /run.sh

ENTRYPOINT ["/tini", "--", "/run.sh"]
