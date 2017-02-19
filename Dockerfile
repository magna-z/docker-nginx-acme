FROM nginx:1.10-alpine

MAINTAINER Maxim Zalysin <zalysin.m@gmail.com>

ENV LE_WORKING_DIR=/opt/acme.sh

COPY docker-entrypoint.sh /

RUN apk add --no-cache openssl curl && \
    curl -sSL https://get.acme.sh | sh && \
    crontab -l | sed "s|acme.sh --cron|acme.sh --cron --renew-hook \"nginx -s reload\"|g" | crontab - && \
    ln -s /opt/acme.sh/acme.sh /usr/bin/acme.sh && \
    chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
