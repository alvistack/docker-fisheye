# (c) Wong Hoi Sing Edison <hswong3i@pantarei-design.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM ubuntu:18.04

ENV JAVA_VERSION                 "1.8.0"
ENV FISHEYE_VERSION              "4.7.1"
ENV FISHEYE_OWNER                "fisheye"
ENV FISHEYE_GROUP                "fisheye"
ENV FISHEYE_HOME                 "/var/atlassian/application-data/fisheye"
ENV FISHEYE_CATALINA             "/opt/atlassian/fisheye"
ENV JVM_MINIMUM_MEMORY           "512m"
ENV JVM_MAXIMUM_MEMORY           "1024m"
ENV CATALINA_CONNECTOR_PROXYNAME ""
ENV CATALINA_CONNECTOR_PROXYPORT ""
ENV CATALINA_CONNECTOR_SCHEME    "http"
ENV CATALINA_CONNECTOR_SECURE    "false"
ENV CATALINA_CONTEXT_PATH        ""
ENV JVM_SUPPORT_RECOMMENDED_ARGS "-Datlassian.plugins.enable.wait=300 -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:MaxRAMFraction=1"
ENV TZ                           "UTC"
ENV SESSION_TIMEOUT              "120"

VOLUME  $FISHEYE_HOME
WORKDIR $FISHEYE_HOME

EXPOSE 8059
EXPOSE 8060

ENTRYPOINT [ "dumb-init", "--", "docker-entrypoint.sh" ]
CMD        [ "/opt/atlassian/fisheye/bin/start.sh", "-fg" ]

# Explicitly set system user UID/GID
RUN set -ex \
    && groupadd -r $FISHEYE_OWNER \
    && useradd -r -g $FISHEYE_GROUP -d $FISHEYE_HOME -M -s /usr/sbin/nologin $FISHEYE_OWNER

# Prepare APT dependencies
RUN set -ex \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install ca-certificates curl gcc git libffi-dev libssl-dev make python python-dev sudo \
    && rm -rf /var/lib/apt/lists/*

# Install PIP
RUN set -ex \
    && curl -skL https://bootstrap.pypa.io/get-pip.py | python

# Copy files
COPY files /

# Bootstrap with Ansible
RUN set -ex \
    && cd /etc/ansible/roles/localhost \
    && pip install --upgrade --requirement requirements.txt \
    && molecule test \
    && rm -rf /var/cache/ansible/* \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /root/.cache/* \
    && rm -rf /tmp/*
