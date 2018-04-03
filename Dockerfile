FROM docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.3

RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install discovery-file

ENV DISCOVER_HOSTNAME= \
ES_OPTIONS="-Ecluster.name=es -Ediscovery.zen.hosts_provider=file" \
DISCOVERY_FREQ_SECONDS=30 \
DISCOVER_FILE=/usr/share/elasticsearch/config/discovery-file/unicast_hosts.txt

ADD https://github.com/krallin/tini/releases/download/v0.14.0/tini /tini
RUN curl -s https://packagecloud.io/install/repositories/imeyer/runit/script.rpm.sh | bash \
&& yum -y install runit-2.1.2-3.el7.centos.x86_64 bind-utils \
&& yum clean all \
&& chmod +x /tini

COPY service /etc/service
COPY run.sh /run.sh

ENTRYPOINT ["/tini", "--", "/run.sh"]
