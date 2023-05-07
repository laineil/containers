[![Docker Pulls](https://img.shields.io/docker/pulls/laineil/httpd)](https://hub.docker.com/r/laineil/httpd) [![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/laineil/httpd?sort=date)](https://hub.docker.com/r/laineil/httpd/tags) [![Docker Image Version (latest by date)](https://img.shields.io/docker/v/laineil/httpd?sort=date)](https://hub.docker.com/r/laineil/httpd/tags)

## About Apache HTTPD

[The Apache HTTP Server Project](https://httpd.apache.org/) is an effort to develop and maintain an open-source HTTP server for modern operating systems including UNIX and Windows. The goal of this project is to provide a secure, efficient and extensible server that provides HTTP services in sync with the current HTTP standards.

- **Apache Module [mod_ssl](https://httpd.apache.org/docs/2.4/mod/mod_ssl.html)**
  - This module provides SSL v3 and TLS v1.x support for the Apache HTTP Server. SSL v2 is no longer supported.
  - This module relies on [OpenSSL](http://www.openssl.org/) to provide the cryptography engine.
  - Further details, discussion, and examples are provided in the [SSL documentation](https://httpd.apache.org/docs/2.4/ssl/).

## Image information

- The use of **non-root container images** can enhance system security.
- Base on [Apache HTTPD versions supported by Red Hat](https://access.redhat.com/solutions/445713).
- By default, a **self-signed TLS certificate** is supplied.
- Subscribe to project updates by watching the [laineil/containers GitHub repo](https://github.com/laineil/containers) for more information.

## Configuration

The container can be easily setup with the following environment variables:

- `HTTPD_LOG_LEVEL` : Set the log level for the apache httpd server (see https://httpd.apache.org/docs/2.4/mod/core.html#loglevel for possible values). Default : **warn**

To customize the configuration of the httpd server, first obtain the upstream default configuration from the container:

- **httpd.conf**

```bash
$ docker run --rm --entrypoint '' laineil/httpd:[tag] cat /etc/httpd/conf/httpd.conf > custom_httpd.conf
```

- **ssl.conf**

```bash
$ docker run --rm --entrypoint '' laineil/httpd:[tag] cat /etc/httpd/conf.d/ssl.conf > custom_ssl.conf
```

## Run a container

Here are a few methods for running a container.

- Quick start

```bash
$ docker run -d \
--name httpd_app \
-v [ext_html_dir]:/var/www/html/[int_html_dir] \
-p [expose_port]:8080 \
-p [expose_port]:8443 \
laineil/httpd:[tag]

# Make sure the owner uid of [ext_html_dir] is 1000.
```

- With your own TLS certificate


```bash
$ docker run -d \
--name httpd_app \
-v [ext_html_dir]:/var/www/html/[int_html_dir] \
-v [certs_path]:/opt/certs:ro \
-p [expose_port]:8080 \
-p [expose_port]:8443 \
laineil/httpd:[tag]

# [certs_folder] must contains server.crt, server.key (certificate name must match).
# Make sure the certificate files within [certs_folder] have permission 644.
```

- With customeize conf

```bash
$ docker run -d \
--name httpd_app \
-v custom_httpd.conf:/etc/httpd/conf/httpd.conf \
-v custom_ssl.conf:/etc/httpd/conf.d/ssl.conf \
-p [expose_port]:8080 \
-p [expose_port]:8443 \
laineil/httpd:[tag]

# Make sure the permission of conf files is 644.
```

- Recommended Test Examples

```bash
$ docker run -d \
--name httpd_app \
-p 80:8080 \
-p 443:8443 \
laineil/httpd:[tag]
```



## Verify

- with http
  - http://[server_ip]:[http_port]
- with https
  - https://[server_ip]:[https_port]

## Logging

```bash
$ docker logs httpd_app
```

## Remove

- Stop container

```bash
$ docker container stop httpd_app
```

- Remove container

```bash
$ docker container rm httpd_app
```

## License Agreement

BSD 3-Clause License  
Copyright (c) 2023, Laineil  
All rights reserved.