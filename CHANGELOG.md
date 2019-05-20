# Docker Image Packaging for Atlassian Fisheye

## 4.7.0-0alvistackx - TBC

### Major Changes

## 4.7.0-0alvistack7 - 2019-05-20

### Major Changes

  - Bugfix "Build times out because no output was received"
  - Upgrade minimal Ansible support to 2.8.0

## 4.7.0-0alvistack5 - 2019-04-16

### Major Changes

  - Run systemd service with specific system user
  - Explicitly set system user UID/GID
  - Porting to Molecule based

## 4.6.1-1alvistack1 - 2018-12-10

### Major Changes

  - Update base image to Ubuntu 18.04
  - Revamp deployment with Ansible roles
  - Replace Oracle Java with OpenJDK

## 4.6.1-0alvistack4 - 2018-10-29

### Major Changes

  - Handle changes with patch
  - Update dumb-init to v.1.2.2
  - Upgrade MySQL Connector/J and PostgreSQL JDBC support
  - Add TZ support
  - Add SESSION\_TIMEOUT support
  - Add CVS, SVN, GIT, Mercurial, Perforce support

## 4.5.2-0alvistack3 - 2018-03-11

### Major Changes

  - Simplify Docker image naming

## 4.5.2-0alvistack1 - 2018-02-28

  - Migrate from <https://github.com/alvistack/ansible-container-fisheye>
  - Pure Dockerfile implementation
  - Ready for both Docker and Kubernetes use cases
