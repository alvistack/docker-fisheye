# Docker Image Packaging for Atlassian Fisheye

<a href="https://alvistack.com" title="AlviStack" target="_blank"><img src="/alvistack.svg" height="75" alt="AlviStack"></a>

[![GitLab pipeline
status](https://img.shields.io/gitlab/pipeline/alvistack/docker-fisheye/master)](https://gitlab.com/alvistack/docker-fisheye/-/pipelines)
[![GitHub
tag](https://img.shields.io/github/tag/alvistack/docker-fisheye.svg)](https://github.com/alvistack/docker-fisheye/tags)
[![GitHub
license](https://img.shields.io/github/license/alvistack/docker-fisheye.svg)](https://github.com/alvistack/docker-fisheye/blob/master/LICENSE)
[![Docker
Pulls](https://img.shields.io/docker/pulls/alvistack/fisheye-4.8.svg)](https://hub.docker.com/r/alvistack/fisheye-4.8)

FishEye is the on-premise source code repository browser for enterprise
teams. It provides your developers with advanced browsing and search for
SVN, Git, Mercurial, Perforce and CVS code repositories, from any web
browser.

Learn more about Fisheye: <https://www.atlassian.com/software/fisheye>

## Supported Tags and Respective Packer Template Links

-   [`alvistack/fisheye-4.8`](https://hub.docker.com/r/alvistack/fisheye-4.8)
    -   [`packer/docker-4.8/packer.json`](https://github.com/alvistack/docker-fisheye/blob/master/packer/docker-4.8/packer.json)

## Overview

This Docker container makes it easy to get an instance of Fisheye up and
running.

Based on [Official Ubuntu Docker
Image](https://hub.docker.com/_/ubuntu/) with some minor hack:

-   Packaging by Packer Docker builder and Ansible provisioner in single
    layer
-   Handle `ENTRYPOINT` with
    [catatonit](https://github.com/openSUSE/catatonit)

### Quick Start

For the `FISHEYE_HOME` directory that is used to store the repository
data (amongst other things) we recommend mounting a host directory as a
[data
volume](https://docs.docker.com/engine/tutorials/dockervolumes/#/data-volumes),
or via a named volume if using a docker version \>= 1.9.

Volume permission is NOT managed by entry scripts. To get started you
can use a data volume, or named volumes.

Start Atlassian Fisheye Server:

    # Pull latest image
    docker pull alvistack/fisheye-4.8

    # Run as detach
    docker run \
        -itd \
        --name fisheye \
        --publish 8060:8060 \
        --volume /var/atlassian/application-data/fisheye:/var/atlassian/application-data/fisheye \
        alvistack/fisheye-4.8

**Success**. Fisheye is now available on <http://localhost:8060>

Please ensure your container has the necessary resources allocated to
it. We recommend 2GiB of memory allocated to accommodate both the
application server and the git processes. See [Supported
Platforms](https://confluence.atlassian.com/display/Fisheye/Supported+Platforms)
for further information.

## Upgrade

To upgrade to a more recent version of Fisheye Server you can simply
stop the Fisheye container and start a new one based on a more recent
image:

    docker stop fisheye
    docker rm fisheye
    docker run ... (see above)

As your data is stored in the data volume directory on the host, it will
still be available after the upgrade.

Note: Please make sure that you don't accidentally remove the fisheye
container and its volumes using the -v option.

## Backup

For evaluations you can use the built-in database that will store its
files in the Fisheye Server home directory. In that case it is
sufficient to create a backup archive of the directory on the host that
is used as a volume (`/var/atlassian/application-data/fisheye` in the
example above).

## Versioning

### `YYYYMMDD.Y.Z`

Release tags could be find from [GitHub
Release](https://github.com/alvistack/docker-fisheye/tags) of this
repository. Thus using these tags will ensure you are running the most
up to date stable version of this image.

### `YYYYMMDD.0.0`

Version tags ended with `.0.0` are rolling release rebuild by [GitLab
pipeline](https://gitlab.com/alvistack/docker-fisheye/-/pipelines) in
weekly basis. Thus using these tags will ensure you are running the
latest packages provided by the base image project.

## License

-   Code released under [Apache License 2.0](LICENSE)
-   Docs released under [CC BY
    4.0](http://creativecommons.org/licenses/by/4.0/)

## Author Information

-   Wong Hoi Sing Edison
    -   <https://twitter.com/hswong3i>
    -   <https://github.com/hswong3i>
