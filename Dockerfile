FROM nginx:1.10.2-alpine

MAINTAINER Maxim Zalysin <zalysin.m@gmail.com>

LABEL pro.magnaz.docker.nginx-acme.version="{\"container\": \"1.4\", \"nginx\": \"1.10.2-alpine\", \"acme.sh\": \"2.6.0\"}"

COPY docker-entrypoint.sh /

RUN apk add --no-cache openssl curl && \
    curl https://get.acme.sh | LE_WORKING_DIR=/opt/acme.sh sh && \
    crontab -l | sed "s/acme.sh --cron/acme.sh --cron --renew-hook \"nginx -s reload\"/g" | crontab - && \
    ln -s /opt/acme.sh/acme.sh /usr/bin/acme.sh && \
    chmod +x /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]
