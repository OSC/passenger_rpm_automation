#!/bin/bash
set -e
source scl_source enable rh-ruby25
exec "$@"
