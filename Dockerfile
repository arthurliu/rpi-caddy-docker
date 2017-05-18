FROM resin/rpi-raspbian:jessie

MAINTAINER Matthias Geisler matthias@openwebcraft.com

RUN groupadd -r caddy && useradd -d /var/lib/caddy -g caddy caddy

RUN apt-get update -y && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
  && rm -rf /var/lib/apt/lists/*

# grab gosu for easy step-down from root and tini for signal handling
# https://github.com/apache/couchdb-docker
# 
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License.
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
  && curl -o /usr/local/bin/gosu -fSL "https://github.com/tianon/gosu/releases/download/1.7/gosu-$(dpkg --print-architecture)" \
  && curl -o /usr/local/bin/gosu.asc -fSL "https://github.com/tianon/gosu/releases/download/1.7/gosu-$(dpkg --print-architecture).asc" \
  && gpg --verify /usr/local/bin/gosu.asc \
  && rm /usr/local/bin/gosu.asc \
  && chmod +x /usr/local/bin/gosu \
  && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 6380DC428747F6C393FEACA59A84159D7001A4E5 \
  && curl -o /usr/local/bin/tini -fSL "https://github.com/krallin/tini/releases/download/v0.14.0/tini-armhf" \
  && curl -o /usr/local/bin/tini.asc -fSL "https://github.com/krallin/tini/releases/download/v0.14.0/tini-armhf.asc" \
  && gpg --verify /usr/local/bin/tini.asc \
  && rm /usr/local/bin/tini.asc \
  && chmod +x /usr/local/bin/tini

ENV CADDY_VERSION v0.10.2

RUN mkdir -p /srv && \
    curl -sL  https://github.com/mholt/caddy/releases/download/$CADDY_VERSION/caddy_linux_arm7.tar.gz | \
    tar xz -C /tmp/ && mv /tmp/caddy_linux_arm7 /usr/local/bin/caddy && \
    chmod +x /usr/local/bin/caddy && \
    /usr/local/bin/caddy -version

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

EXPOSE 80 443 2015
WORKDIR /var/lib/caddy

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
CMD ["caddy"]