Nginx with embedded Let's Encrypt client ACME.sh
===

[![](https://images.microbadger.com/badges/image/magnaz/nginx-acme.svg)](http://microbadger.com/images/magnaz/nginx-acme "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/magnaz/nginx-acme.svg)](http://microbadger.com/images/magnaz/nginx-acme "Get your own version badge on microbadger.com")

**Very small and easy useable docker container with Nginx web-server and "Let's Encrypt" client - ACME.sh.**

After the initial issue of the certificate, its updating is automated by cron in container!


#### Supported tags:

- **1.10-alpine** or **latest** ([1.10-alpine/Dockerfile](https://github.com/magna-z/docker-nginx-acme/blob/master/1.10-alpine/Dockerfile)) [![](https://images.microbadger.com/badges/image/magnaz/nginx-acme:1.10-alpine.svg)](https://microbadger.com/images/magnaz/nginx-acme:1.10-alpine "Get your own image badge on microbadger.com")
- **1.11-alpine** ([1.11-alpine/Dockerfile](https://github.com/magna-z/docker-nginx-acme/blob/master/1.11-alpine/Dockerfile)) [![](https://images.microbadger.com/badges/image/magnaz/nginx-acme:1.11-alpine.svg)](https://microbadger.com/images/magnaz/nginx-acme:1.11-alpine "Get your own image badge on microbadger.com")
- **1.10-debian** ([1.10-debian/Dockerfile](https://github.com/magna-z/docker-nginx-acme/blob/master/1.10-debian/Dockerfile)) [![](https://images.microbadger.com/badges/image/magnaz/nginx-acme:1.10-debian.svg)](https://microbadger.com/images/magnaz/nginx-acme:1.10-debian "Get your own image badge on microbadger.com")
- **1.11-debian** ([1.11-debian/Dockerfile](https://github.com/magna-z/docker-nginx-acme/blob/master/1.11-debian/Dockerfile)) [![](https://images.microbadger.com/badges/image/magnaz/nginx-acme:1.11-debian.svg)](https://microbadger.com/images/magnaz/nginx-acme:1.11-debian "Get your own image badge on microbadger.com")


#### Container create short manual:

1. **Create directories for docker container volumes:**

    ```sh
    mkdir -p /var/docker/nginx/ssl /var/docker/nginx/conf.d
    ```

1. **Generate a DH Parameter (Key) File (recommended 2048 bits):**

    ```sh
    openssl dhparam -out /var/docker/nginx/ssl/dhparam.pem 2048
    ```

1. **Create configs for Nginx in /var/docker/nginx:**

    See the simple examples in [GitHub Repository](https://github.com/magna-z/docker-nginx-acme/tree/master/example-configs)
    and [Mozilla SSL Configuration Generator](https://mozilla.github.io/server-side-tls/ssl-config-generator/).

1. **Create user-defined network and docker container:**

    ```sh
    sudo docker network create nginx
    ```

1. **Create user-network and docker container:**

    ```sh
    sudo docker run \
    --name nginx \
    --hostname nginx \
    --network nginx \
    -p 80:80 \
    -p 443:443 \
    -e ACCOUNT_CONF_PATH=/etc/nginx/ssl/acme.sh.conf \
    -v /etc/timezone:/etc/timezone:ro -v /etc/localtime:/etc/localtime:ro \
    -v /var/docker/nginx/nginx.conf:/etc/nginx/nginx.conf:ro \
    -v /var/docker/nginx/conf.d:/etc/nginx/conf.d:ro \
    -v /var/docker/nginx/ssl:/etc/nginx/ssl:rw \
    -v /var/docker/nginx/logs:/var/log/nginx:rw \
    -v /var/docker/nginx/www:/var/www:rw \
    -d --restart always \
    magnaz/nginx-acme:1.10-alpine
    ```

1. **Initial issue "Let's Encrypt" certificate:**
    ```sh
    sudo docker exec nginx acme.sh --issue -w /var/www/example.com -d example.com -d www.example.com
    ```
