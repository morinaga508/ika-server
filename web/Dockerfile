FROM nginx:1-alpine

RUN apk upgrade --no-cache &&\
    apk add --no-cache certbot curl bash 

RUN apk add --no-cache py2-pip &&\
    pip install mcstatus

RUN apk add --no-cache php7 php7-fpm php7-mysqli php7-session php7-json

COPY default.conf_80 /etc/nginx/conf.d/
COPY default.conf_443 /etc/nginx/conf.d/

COPY crontab /var/spool/cron/crontabs/root

COPY ckhnx /usr/local/bin/
RUN chmod +x /usr/local/bin/ckhnx

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
