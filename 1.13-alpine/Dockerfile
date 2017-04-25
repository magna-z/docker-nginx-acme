FROM nginx:1.13-alpine

ENV LE_WORKING_DIR=/opt/acme.sh

COPY docker-entrypoint.sh /

RUN set -ex && \
    apk add --no-cache ca-certificates curl openssl && \
    curl -sSL https://get.acme.sh | sh && \
    mkdir -p /opt/acme.sh/ca/acme-v01.api.letsencrypt.org && \
    crontab -l | sed "s|acme.sh --cron|acme.sh --cron --renew-hook \"nginx -s reload\"|g" | crontab - && \
    ln -s /opt/acme.sh/acme.sh /usr/bin/acme.sh && \
    chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
