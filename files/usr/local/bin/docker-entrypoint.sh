#!/bin/bash

set -o xtrace

# Ensure required folders exist with correct owner:group
mkdir -p $FISHEYE_HOME
chmod 0755 $FISHEYE_HOME
chown -Rf $FISHEYE_OWNER:$FISHEYE_GROUP $FISHEYE_HOME

# Running Fisheye in foreground
exec /etc/init.d/fisheye start -fg
