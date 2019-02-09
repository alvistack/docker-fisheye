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

ENV FISHEYE_OWNER                "fisheye"
ENV FISHEYE_GROUP                "fisheye"
ENV FISHEYE_HOME                 "/var/atlassian/application-data/fisheye"
ENV FISHEYE_CATALINA             "/opt/atlassian/fisheye"
ENV FISHEYE_DOWNLOAD_URL         "https://product-downloads.atlassian.com/software/fisheye/downloads/fisheye-4.6.1.zip"
ENV JAVA_HOME                    "/usr/lib/jvm/java-8-openjdk-amd64"
ENV JVM_MINIMUM_MEMORY           "512m"
ENV JVM_MAXIMUM_MEMORY           "1024m"
ENV CATALINA_CONNECTOR_PROXYNAME ""
ENV CATALINA_CONNECTOR_PROXYPORT ""
ENV CATALINA_CONNECTOR_SCHEME    "http"
ENV CATALINA_CONNECTOR_SECURE    "false"
ENV CATALINA_CONTEXT_PATH        ""
ENV JVM_SUPPORT_RECOMMENDED_ARGS "-Datlassian.plugins.enable.wait=300"
ENV TZ                           "UTC"
ENV SESSION_TIMEOUT              "120"

VOLUME  $FISHEYE_HOME
WORKDIR $FISHEYE_HOME

EXPOSE 8059
EXPOSE 8060

ENTRYPOINT [ "dumb-init", "--" ]
CMD        [ "docker-entrypoint.sh" ]

# Explicitly set system user UID/GID
RUN set -ex \
    && groupadd -r $FISHEYE_OWNER \
    && useradd -r -g $FISHEYE_GROUP -d $FISHEYE_HOME -M -s /usr/sbin/nologin $FISHEYE_OWNER

# Prepare APT depedencies
RUN set -ex \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install build-essential curl git libffi-dev libssl-dev python python-dev \
    && rm -rf /var/lib/apt/lists/*

# Install PIP
RUN set -ex \
    && curl -skL https://bootstrap.pypa.io/get-pip.py | python

# Install PIP dependencies
RUN set -ex \
    && pip install ansible ansible-lint yamllint \
    && rm -rf /root/.cache/pip

# Copy files
COPY files /

# Bootstrap with Ansible
RUN set -ex \
    && ansible-galaxy install --force --roles-path /etc/ansible/roles --role-file /etc/ansible/ansible-role-requirements.yml \
    && yamllint --config-file /etc/ansible/.yamllint /etc/ansible \
    && ansible-lint /etc/ansible/playbooks/bootstrap.yml \
    && ansible-playbook /etc/ansible/playbooks/bootstrap.yml --syntax-check \
    && ansible-playbook /etc/ansible/playbooks/bootstrap.yml --diff \
    && ansible-playbook /etc/ansible/playbooks/bootstrap.yml --diff
