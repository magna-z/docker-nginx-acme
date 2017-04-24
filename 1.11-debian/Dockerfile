FROM nginx:1.11

ENV DEBIAN_FRONTEND=noninteractive \
    LE_WORKING_DIR=/opt/acme.sh

COPY docker-entrypoint.sh /

RUN set -ex && \
    apt-get update && \
    apt-get install --yes --no-install-recommends ca-certificates cron curl openssl && \
    curl -sSL https://get.acme.sh | sh && \
    mkdir -p /opt/acme.sh/ca/acme-v01.api.letsencrypt.org && \
    crontab -l | sed "s|acme.sh --cron|acme.sh --cron --renew-hook \"nginx -s reload\"|g" | crontab - && \
    ln -s /opt/acme.sh/acme.sh /usr/bin/acme.sh && \
    chmod +x /docker-entrypoint.sh && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /var/log/apt /var/log/dpkg.log

ENTRYPOINT ["/docker-entrypoint.sh"]