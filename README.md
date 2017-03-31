Nginx with embedded Let's Encrypt client ACME.sh
====

[![](https://images.microbadger.com/badges/image/magnaz/nginx-acme.svg)](http://microbadger.com/images/magnaz/nginx-acme "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/magnaz/nginx-acme.svg)](http://microbadger.com/images/magnaz/nginx-acme "Get your own version badge on microbadger.com")

**Very small and easy useable docker container with Nginx web-server and Let's Encrypt client - ACME.sh.**

Official sites: 
Nginx: https://nginx.org
ACME.sh: https://acme.sh

1. **Create directories for docker container volumes**

    ```sh
    mkdir -p /var/docker/nginx/ssl /var/docker/nginx/conf.d
    ```

2. **Generate a DH Parameter (Key) File (recommended 2048 bits)**

    ```sh
    openssl dhparam -out /var/docker/nginx/ssl/dhparam.pem 2048
    ```

3. **Create configs for Nginx **
    See the simple examples in 

4. **Create user-defined network and docker container**

    ```sh
    sudo docker network create nginx
    ```

5. **Create user-network and docker container**
```sh
sudo docker run \
--name nginx \
--hostname nginx \
--network nginx
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
