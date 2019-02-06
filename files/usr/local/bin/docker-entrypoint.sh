#!/bin/bash

set -o xtrace

# Running Fisheye in foreground
exec /etc/init.d/fisheye start -fg
