#!/bin/bash
source /etc/profile.d/rvm.sh
set -e
rvm use 2.2.10
exec "$@"
