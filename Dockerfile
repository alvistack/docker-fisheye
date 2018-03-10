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

FROM ubuntu:16.04

ENV FISHEYE_OWNER                "daemon"
ENV FISHEYE_GROUP                "daemon"
ENV FISHEYE_HOME                 "/var/atlassian/application-data/fisheye"
ENV FISHEYE_CATALINA             "/opt/atlassian/fisheye"
ENV FISHEYE_DOWNLOAD_URL         "https://downloads.atlassian.com/software/fisheye/downloads/fisheye-4.5.2.zip"
ENV JAVA_HOME                    "/usr/java/default"
ENV JVM_MINIMUM_MEMORY           "512m"
ENV JVM_MAXIMUM_MEMORY           "1024m"
ENV CATALINA_CONNECTOR_PROXYNAME ""
ENV CATALINA_CONNECTOR_PROXYPORT ""
ENV CATALINA_CONNECTOR_SCHEME    "http"
ENV CATALINA_CONNECTOR_SECURE    "false"
ENV CATALINA_CONTEXT_PATH        ""
ENV JVM_SUPPORT_RECOMMENDED_ARGS "-Datlassian.plugins.enable.wait=300"

VOLUME  $FISHEYE_HOME
WORKDIR $FISHEYE_HOME

EXPOSE 8059
EXPOSE 8060

ENTRYPOINT [ "/usr/local/bin/dumb-init", "--" ]
CMD        [ "/etc/init.d/fisheye", "start", "-fg" ]

# Prepare APT depedencies
RUN set -ex \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y alien apt-transport-https apt-utils aptitude bzip2 ca-certificates curl debian-archive-keyring debian-keyring git htop psmisc python-apt rsync sudo unzip vim wget zip \
    && rm -rf /var/lib/apt/lists/*

# Install Oracle JRE
RUN set -ex \
    && ln -s /usr/bin/update-alternatives /usr/sbin/alternatives \
    && ARCHIVE="`mktemp --suffix=.rpm`" \
    && curl -skL -j -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jre-8u162-linux-x64.rpm > $ARCHIVE \
    && DEBIAN_FRONTEND=noninteractive alien -i -k --scripts $ARCHIVE \
    && rm -rf $ARCHIVE

# Install Atlassian Fisheye
RUN set -ex \
    && ARCHIVE="`mktemp --suffix=.zip`" \
    && curl -skL $FISHEYE_DOWNLOAD_URL > $ARCHIVE \
    && mkdir -p $FISHEYE_CATALINA \
    && TMP_DIR="`mktemp -d`" && unzip -qq $ARCHIVE -x -d $TMP_DIR && rsync -av $TMP_DIR/*/ $FISHEYE_CATALINA && rm -rf $TMP_DIR \
    && chown -Rf $FISHEYE_OWNER:$FISHEYE_GROUP $FISHEYE_CATALINA \
    && rm -rf $ARCHIVE

# Install dumb-init
RUN set -ex \
    && curl -skL https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64 > /usr/local/bin/dumb-init \
    && chmod 0755 /usr/local/bin/dumb-init

# Copy files
COPY files /

# Ensure required folders exist with correct owner:group
RUN set -ex \
    && mkdir -p $FISHEYE_HOME \
    && chown -Rf $FISHEYE_OWNER:$FISHEYE_GROUP $FISHEYE_HOME \
    && chmod 0755 $FISHEYE_HOME \
    && mkdir -p $FISHEYE_CATALINA \
    && chown -Rf $FISHEYE_OWNER:$FISHEYE_GROUP $FISHEYE_CATALINA \
    && chmod 0755 $FISHEYE_CATALINA
