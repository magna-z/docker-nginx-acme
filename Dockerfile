FROM nginx:stable-alpine

MAINTAINER Maxim Zalysin <zalysin.m@gmail.com>

RUN apk add --no-cache openssl curl && \
    curl https://get.acme.sh | LE_WORKING_DIR=/opt/acme.sh sh && \
    crontab -l | sed "s/acme.sh --cron/acme.sh --cron --renew-hook \"nginx -s reload\"/g" | crontab - && \
    ln -s /opt/acme.sh/acme.sh /usr/bin/acme.sh

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]