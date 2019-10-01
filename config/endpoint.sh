#!/bin/sh

set -e

if [ -z $BEARER_TOKEN ]; then
  echo >&2 "BEARER_TOKEN must be set"
  exit 1
fi

if [ -z $PROXY_PASS_UPSTREAM ]; then
  echo >&2 "PROXY_PASS_UPSTREAM must be set"
  exit 1
fi

sed \
  -e "s/##CLIENT_MAX_BODY_SIZE##/$CLIENT_MAX_BODY_SIZE/g" \
  -e "s/##PROXY_READ_TIMEOUT##/$PROXY_READ_TIMEOUT/g" \
  -e "s/##WORKER_PROCESSES##/$WORKER_PROCESSES/g" \
  -e "s/##SERVER_NAME##/$SERVER_NAME/g" \
  -e "s/##PORT##/$PORT/g" \
  -e "s|##PROXY_PASS_UPSTREAM##|$PROXY_PASS_UPSTREAM|g" \
  /nginx.conf.tmpl > /usr/local/openresty/nginx/conf/nginx.conf

exec openresty  -g "daemon off;"
