# Docker Image Packaging for Atlassian Fisheye

## YYYYMMDD.Y.Z - TBC

### Major Changes

  - Upgrade minimal Ansible community package support to 4.1.0

## 20210602.1.1 - 2021-06-02

### Major Changes

  - Initialize with `verify.yml` with first start
  - Upgrade minimal Ansible support to 4.0.0

## 20210313.1.1 - 2021-03-13

### Major Changes

  - Bugfix [ansible-lint `namespace`](https://github.com/ansible-community/ansible-lint/pull/1451)
  - Bugfix [ansible-lint `no-handler`](https://github.com/ansible-community/ansible-lint/pull/1402)
  - Bugfix [ansible-lint `unnamed-task`](https://github.com/ansible-community/ansible-lint/pull/1413)
  - Remove adhoc config with environment variables
  - Change GIT tag as per Vagrant Box naming and versioning limitation

## 4.8.4-4alvistack9 - 2020-12-09

### Major Changes

  - Migrate from Travis CI to GitLab CI
  - Revamp with Packer

## 4.8.4-4alvistack5 - 2020-10-14

### Major Changes

  - Refine Molecule matrix

## 4.8.3-4alvistack4 - 2020-08-26

### Major Changes

  - Upgrade minimal Ansible Lint support to 4.3.2
  - Upgrade Travis CI test as Ubuntu Focal based
  - Upgrade minimal Ansible support to 2.10.0

## 4.8.2-4alvistack6 - 2020-06-10

### Major Changes

  - Revamp `create`, `side_effect`, `verify` and `destroy` logic
  - Replace `tini` with `catatonit`
  - Rename `post_tasks.yml` as `side_effect.yml`
  - Upgrade base image to Ubuntu 20.04

## 4.8.1-4alvistack4 - 2020-03-05

### Major Changes

  - Revamp with Molecule and `docker commit`
  - Consolidate molecule tests into `default` (noop)
  - Hotfix for systemd

## 4.8.0-3alvistack1 - 2020-01-15

### Major Changes

  - Replace `dumb-init` with `tini`, as like as `docker --init`
  - Replace `java` with `openjdk`
  - Include release specific vars and tasks

## 4.7.2-2alvistack3 - 2019-11-05

### Major Changes

  - Upgrade minimal Ansible support to 2.9.0
  - Upgrade Travis CI test as Ubuntu Bionic based
  - Default with Python 3
  - Hotfix for en\_US.utf8 locale
  - Allow the container to be stated with `--user`
  - Simplify parameters combination with `FISHEYE_VERSION`
  - Prepend executable if command starts with an option
  - Improve `ENTRYPOINT` and `CMD`

## 4.7.0-0alvistack8 - 2019-05-20

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
