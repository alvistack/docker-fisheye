#!/bin/bash

set -o xtrace

# Prepend executable if command starts with an option
if [ "${1:0:1}" = '-' ]; then
    set -- /opt/atlassian/fisheye/bin/start.sh "$@"
fi

# Ensure required folders exist with correct owner:group
mkdir -p $FISHEYE_HOME
chmod 0755 $FISHEYE_HOME
chown -Rf $FISHEYE_OWNER:$FISHEYE_GROUP $FISHEYE_HOME

exec "$@"
