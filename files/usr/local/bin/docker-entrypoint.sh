#!/bin/bash

set -o xtrace

# Prepend executable if command starts with an option
if [ "${1:0:1}" = '-' ]; then
    set -- /opt/atlassian/fisheye/bin/start.sh "$@"
fi

# Allow the container to be stated with `--user`
if [ "$1" = '/opt/atlassian/fisheye/bin/start.sh' ] && [ "$(id -u)" = '0' ]; then
    mkdir -p $FISHEYE_HOME
    chmod 0755 $FISHEYE_HOME
    chown -Rf $FISHEYE_OWNER:$FISHEYE_GROUP $FISHEYE_HOME
    exec gosu $FISHEYE_OWNER "$BASH_SOURCE" "$@"
fi

exec "$@"
