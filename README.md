### Changes from official

- use tini
- add xpack and discovery-file plugins

env vars

DISCOVER_HOSTNAME : dns hostname, use associated srv records to populate unicast_hosts.txt

ES_OPTIONS : use this var to pass elasticsearch command line options. defaults are "-Expack.security.enabled=false -Ecluster.name=es"
