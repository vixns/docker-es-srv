FROM elasticsearch:5.6

MAINTAINER Stephane Cottin <stephane.cottin@vixns.com>

RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install discovery-file \
	&& /usr/share/elasticsearch/bin/elasticsearch-plugin install x-pack

ENV DISCOVER_HOSTNAME= \
ES_OPTIONS="-Expack.security.enabled=false -Ecluster.name=es -Ediscovery.zen.hosts_provider=file" \
DISCOVERY_FREQ_SECONDS=30 \
DISCOVER_FILE=/usr/share/elasticsearch/config/discovery-file/unicast_hosts.txt

ADD https://github.com/krallin/tini/releases/download/v0.14.0/tini /tini
RUN export DEBIAN_FRONTEND=noninteractive \
&& apt-get update \
&& apt-get install -y --no-install-recommends runit dnsutils \
&& rm -rf /var/lib/apt/lists/* \
&& chmod +x /tini

COPY service /etc/service
COPY run.sh /run.sh

ENTRYPOINT ["/tini", "--", "/run.sh"]
