FROM docker.elastic.co/elasticsearch/elasticsearch:7.2.0

ENV DISCOVER_HOSTNAME= \
ES_OPTIONS="-Ecluster.name=es -Ediscovery.seed_providers=file" \
DISCOVERY_FREQ_SECONDS=30 \
DISCOVER_FILE=/usr/share/elasticsearch/config/unicast_hosts.txt

ADD https://github.com/krallin/tini/releases/download/v0.18.0/tini /tini
RUN curl -s https://packagecloud.io/install/repositories/imeyer/runit/script.rpm.sh | bash \
&& yum -y install runit-2.1.2-3.el7.centos.x86_64 bind-utils \
&& yum clean all \
&& chmod +x /tini

COPY service /etc/service
COPY run.sh /run.sh

ENTRYPOINT ["/tini", "--", "/run.sh"]
