# NGINX Host Static Content Unit [![Docker Pulls](https://img.shields.io/docker/pulls/handcraftedbits/nginx-unit-static.svg?maxAge=2592000)](https://hub.docker.com/r/handcraftedbits/nginx-unit-static)

A [Docker](https://www.docker.com) container that provides a static content unit for
[NGINX Host](https://github.com/handcraftedbits/docker-nginx-host).

# Usage

## Configuration

It is highly recommended that you use container orchestration software such as
[Docker Compose](https://www.docker.com/products/docker-compose) when using this NGINX Host unit as several Docker
containers are required for operation.  This guide will assume that you are using Docker Compose.

To begin, start with a basic `docker-compose.yml` file as described in the
[NGINX Host configuration guide](https://github.com/handcraftedbits/docker-nginx-host#configuration).  Then, add a
service for the NGINX Host static content unit (named `static`):

```yaml
static:
  image: handcraftedbits/nginx-unit-static
  environment:
    - NGINX_UNIT_HOSTS=mysite.com
    - NGINX_URL_PREFIX=/static
  volumes:
    - data:/opt/container/shared
    - /home/me/www-static:/opt/container/www-static
```

Observe the following:

* We mount `/opt/container/www-static` using the local directory `/home/me/www-static`.  This is the directory
  containing the static content that we will be hosting.
* As with any other NGINX Host unit, we mount our data volume, in this case named `data`, to `/opt/container/shared`.

Finally, we need to create a link in our NGINX Host container to the `static` container in order to host the static
content.  Here is our final `docker-compose.yml` file:

```yaml
version: "2.1"

volumes:
  data:

services:
  proxy:
    image: handcraftedbits/nginx-host
    links:
      - static
    ports:
      - "443:443"
    volumes:
      - data:/opt/container/shared
      - /etc/letsencrypt:/etc/letsencrypt
      - /home/me/dhparam.pem:/etc/ssl/dhparam.pem

  static:
    image: handcraftedbits/nginx-unit-static
    environment:
      - NGINX_UNIT_HOSTS=mysite.com
      - NGINX_URL_PREFIX=/static
    volumes:
      - data:/opt/container/shared
      - /home/me/www-static:/opt/container/www-static
```

This will result in making the static content available at `https://mysite.com/static`.

## Running the NGINX Host Static Content Unit

Assuming you are using Docker Compose, simply run `docker-compose up` in the same directory as your
`docker-compose.yml` file.  Otherwise, you will need to start each container with `docker run` or a suitable
alternative, making sure to add the appropriate environment variables and volume references.

# Reference

## Environment Variables

Please see the NGINX Host [documentation](https://github.com/handcraftedbits/docker-nginx-host#units) for information
on the environment variables understood by this unit.
