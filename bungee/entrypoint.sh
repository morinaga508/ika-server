#!/bin/sh

envsubst < ../config.yml > config.yml
cp -f ../server-icon.png server-icon.png

exec java ${JAVA_OPTS} "$@"
