# Docker Image Packaging for Atlassian Fisheye

[![Travis](https://img.shields.io/travis/alvistack/docker-fisheye.svg)](https://travis-ci.org/alvistack/docker-fisheye)
[![GitHub release](https://img.shields.io/github/release/alvistack/docker-fisheye.svg)](https://github.com/alvistack/docker-fisheye/releases)
[![GitHub license](https://img.shields.io/github/license/alvistack/docker-fisheye.svg)](https://github.com/alvistack/docker-fisheye/blob/master/LICENSE)
[![Docker Pulls](https://img.shields.io/docker/pulls/alvistack/fisheye.svg)](https://hub.docker.com/r/alvistack/fisheye/)

FishEye is the on-premise source code repository browser for enterprise teams. It provides your developers with advanced browsing and search for SVN, Git, Mercurial, Perforce and CVS code repositories, from any web browser.

Learn more about Fisheye: <https://www.atlassian.com/software/fisheye>

## Supported Tags and Respective `Dockerfile` Links

  - [`latest` (master/Dockerfile)](https://github.com/alvistack/docker-fisheye/blob/master/Dockerfile)
  - [`4.6` (4.6/Dockerfile)](https://github.com/alvistack/docker-fisheye/blob/4.6/Dockerfile)
  - [`4.5` (4.5/Dockerfile)](https://github.com/alvistack/docker-fisheye/blob/4.5/Dockerfile)

## Overview

This Docker container makes it easy to get an instance of Fisheye up and running.

### Quick Start

For the `FISHEYE_HOME` directory that is used to store the repository data (amongst other things) we recommend mounting a host directory as a [data volume](https://docs.docker.com/engine/tutorials/dockervolumes/#/data-volumes), or via a named volume if using a docker version \>= 1.9.

Volume permission is managed by entry scripts. To get started you can use a data volume, or named volumes.

Start Atlassian Fisheye Server:

    # Pull latest image
    docker pull alvistack/fisheye
    
    # Run as detach
    docker run \
        -itd \
        --name fisheye \
        --publish 8060:8060 \
        --volume /var/atlassian/application-data/fisheye:/var/atlassian/application-data/fisheye \
        alvistack/fisheye

**Success**. Fisheye is now available on <http://localhost:8060>

Please ensure your container has the necessary resources allocated to it. We recommend 2GiB of memory allocated to accommodate both the application server and the git processes. See [Supported Platforms](https://confluence.atlassian.com/display/Fisheye/Supported+Platforms) for further information.

### Memory / Heap Size

If you need to override Fisheye's default memory allocation, you can control the minimum heap (Xms) and maximum heap (Xmx) via the below environment variables.

#### JVM\_MINIMUM\_MEMORY

The minimum heap size of the JVM

Default: `512m`

#### JVM\_MAXIMUM\_MEMORY

The maximum heap size of the JVM

Default: `1024m`

### Reverse Proxy Settings

If Fisheye is run behind a reverse proxy server, then you need to specify extra options to make Fisheye aware of the setup. They can be controlled via the below environment variables.

#### CATALINA\_CONNECTOR\_PROXYNAME

The reverse proxy's fully qualified hostname.

Default: *NONE*

#### CATALINA\_CONNECTOR\_PROXYPORT

The reverse proxy's port number via which Fisheye is accessed.

Default: *NONE*

#### CATALINA\_CONNECTOR\_SCHEME

The protocol via which Fisheye is accessed.

Default: `http`

#### CATALINA\_CONNECTOR\_SECURE

Set 'true' if CATALINA\_CONNECTOR\_SCHEME is 'https'.

Default: `false`

#### CATALINA\_CONTEXT\_PATH

The context path via which Fisheye is accessed.

Default: *NONE*

### JVM configuration

If you need to pass additional JVM arguments to Fisheye such as specifying a custom trust store, you can add them via the below environment variable

#### JVM\_SUPPORT\_RECOMMENDED\_ARGS

Additional JVM arguments for Fisheye

Default: `-Datlassian.plugins.enable.wait=300`

### Misc configuration

Other else misc configuration.

#### TZ

Default timezone for the docker instance

Default: `UTC`

#### SESSION\_TIMEOUT

Default session timeout for Apache Tomcat

Default: `120`

## Upgrade

To upgrade to a more recent version of Fisheye Server you can simply stop the Fisheye
container and start a new one based on a more recent image:

    docker stop fisheye
    docker rm fisheye
    docker run ... (see above)

As your data is stored in the data volume directory on the host, it will still
be available after the upgrade.

Note: Please make sure that you don't accidentally remove the fisheye container and its volumes using the -v option.

## Backup

For evaluations you can use the built-in database that will store its files in the Fisheye Server home directory. In that case it is sufficient to create a backup archive of the directory on the host that is used as a volume (`/var/atlassian/application-data/fisheye` in the example above).

## Versioning

The `latest` tag matches the most recent version of this repository. Thus using `alvistack/fisheye:latest` or `alvistack/fisheye` will ensure you are running the most up to date version of this image.

## License

  - Code released under [Apache License 2.0](LICENSE)
  - Docs released under [CC BY 4.0](http://creativecommons.org/licenses/by/4.0/)

## Author Information

  - Wong Hoi Sing Edison
      - <https://twitter.com/hswong3i>
      - <https://github.com/hswong3i>
