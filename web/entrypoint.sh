#!/bin/sh

if [ "$1" != nginx ]; then
  exec "$@"
  echo $?
fi

if [ "${NOHNX}" = true ]; then
  touch /var/run/nohnx
else
  mkdir -p /var/www
  echo up > /var/www/ckhnx
fi

curl -fIs https://main:8123/
echo "Waiting for dynmap"
until curl -fIs http://main:8123/ > /dev/null; do
  echo -n "." 1>&2
  sleep 1
done
echo "Dynmap is up - executing command" 1>&2

export DOLLAR='$'
if [ "${HTTPS}" = true ]; then
  if [ -L /etc/letsencrypt/live/${DOMAIN}/cert.pem ]; then
    certbot renew --standalone --agree-tos -m ${CERTMAIL} -d ${DOMAIN}
  else
    certbot certonly --standalone --agree-tos -m ${CERTMAIL} -d ${DOMAIN}
  fi
  envsubst < /etc/nginx/conf.d/default.conf_443 > /etc/nginx/conf.d/default.conf
else
  envsubst < /etc/nginx/conf.d/default.conf_80 > /etc/nginx/conf.d/default.conf
fi

crond
php-fpm7

exec "$@"
