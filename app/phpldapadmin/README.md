[![Docker Pulls](https://img.shields.io/docker/pulls/laineil/phpldapadmin)](https://hub.docker.com/r/laineil/phpldapadmin) [![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/laineil/phpldapadmin?sort=date)](https://hub.docker.com/r/laineil/phpldapadmin/tags) [![Docker Image Version (latest by date)](https://img.shields.io/docker/v/laineil/phpldapadmin?sort=date)](https://hub.docker.com/r/laineil/phpldapadmin/tags)

## About phpLDAPadmin

[phpLDAPadmin](https://phpldapadmin.sourceforge.net/wiki/index.php/Main_Page) (also known as PLA) is a web-based LDAP client. It provides easy, anywhere-accessible, multi-language administration for your LDAP server.

Its hierarchical tree-viewer and advanced search functionality make it intuitive to browse and administer your LDAP directory. Since it is a web application, this LDAP browser works on many platforms, making your LDAP server easily manageable from any location.

phpLDAPadmin is the perfect LDAP browser for the LDAP professional and novice alike. Its user base consists mostly of LDAP administration professionals.

You might also like to see [About](https://phpldapadmin.sourceforge.net/wiki/index.php/About).

## Image information

- The use of **non-root container images** can enhance system security.
- Base on [Apache HTTPD versions supported by Red Hat](https://access.redhat.com/solutions/445713).
- Base on [phpLDAPadmin version support by Extra Packages for Enterprise Linux (EPEL)](https://docs.fedoraproject.org/en-US/epel/).
- By default, a **self-signed TLS certificate** is supplied.
- Subscribe to project updates by watching the [laineil/containers GitHub repo](https://github.com/laineil/containers) for more information.

## Configuration

The container can be easily setup with the following environment variables:

- `HTTPD_LOG_LEVEL`: Set the log level for the apache httpd server (see [LogLevel Directive](https://httpd.apache.org/docs/2.4/mod/core.html#loglevel) for possible values). Default: **warn**
- `HTTPD_TLS_ROOTCA`: Whether to enable rootca for TLS or not. Default: **disable**
  - enable: 
    - Supply a **self-signed TLS certificate (with CA)**. You can replace the certificate with your own.
    - certs dir: **/opt/certs**
    - certs files: **rootca.crt**, **server.crt**, **server.key**

- `LDAP_CONN_MODE`: Connecting to an LDAP server using LDAP or LDAPS. Default: **ldap** (ldaps)
- `LDAP_TLS_REQCERT`: Specifies what checks to perform on server certificates in a TLS session (see [ldap_tls_reqcert](https://linux.die.net/man/5/sssd-ldap)). Default: **never** (allow / try / demand)
- `LDAP_SERVER_HOST`: The IP address or fully qualified domain name (FQDN) of the LDAP server. Default: **127.0.0.1**
- `LDAP_CONN_PORT`: The TCP port for establishing a connection to the LDAP server. Default: **389**
- `LDAP_SERVER_NAME`: A convenient name that will appear in the tree viewer and throughout phpLDAPadmin to identify this LDAP server to users. Default: **default** (default is same as the **Local LDAP Server**)
- `PHPLDAP_LOGIN_ATTR`: When presenting the login form, this will determine what is used as the **User ID** (see https://phpldapadmin.sourceforge.net/wiki/index.php/Server:login:attr for possible values). Default: **dn**
- `PHPLDAP_AUTH_TYPE`: This configuration parameter will control where phpLDAPadmin stores and subsequently gets its authentication information from, once the users has logged in. (see https://phpldapadmin.sourceforge.net/wiki/index.php/Server:login:auth_type or possible values). Default: **session** (config / cookie / http / proxy)
- `PHPLDAP_ANON_BIND`: Whether to enable anonymous bind logins to the LDAP server or not. Default: **enable** (disable)
- `PHPLDAP_SESSION_TIMEOUT`: The time out value in minutes for the phpLDAPadmin web. Default: **disable** (#, ex: 5)
- `PHPLDAP_HIDE_WARN`: Whether to hide the warnings for invalid objectClasses/attributes in templates or not. Default: **enable** (disable)
- `PHPLDAP_SAMPLE_DN`: The sample DN of the user for phpLDAPadmin to bind with. Default: **disable** (ex. uid=xxx,ou=users,dc=example,dc=org)

## Run a container

Here are a few methods for running a container.

- Quick start

```bash
$ docker run -d \
--name ldapadmin_app \
-p [expose_port]:8080 \
-p [expose_port]:8443 \
-e LDAP_SERVER_HOST=[LDAP_server_host]
laineil/phpldapadmin:[tag]
```

- With your own TLS certificate with CA


```bash
$ docker run -d \
--name ldapadmin_app \
-v [certs_path]:/opt/certs:ro \
-p [expose_port]:8080 \
-p [expose_port]:8443 \
-e HTTPD_TLS_ROOTCA=enable \
-e LDAP_CONN_MODE=ldaps
-e LDAP_TLS_REQCERT=[LDAP_tls_reqcert]
-e LDAP_SERVER_HOST=[LDAP_server_host]
-e LDAP_CONN_PORT=[LDAP_connection_port]
laineil/phpldapadmin:[tag]

# [certs_folder] must contains rootca.crt, server.crt, server.key, ldapca.crt (certificate name must match).
# Make sure the certificate files within [certs_folder] have permission 644.
```

- Recommended Examples

```bash
$ docker run -d \
--name ldapadmin_app \
-p 80:8080 \
-p 443:8443 \
-e LDAP_CONN_MODE=ldaps
-e LDAP_SERVER_HOST=[LDAP_server_host]
-e LDAP_CONN_PORT=636
-e PHPLDAP_ANON_BIND=disable
-e PHPLDAP_SESSION_TIMEOUT=5
laineil/phpldapadmin:[tag]
```

## Verify

- with http
  - http://[server_ip]:[http_port]/phpldapadmin
- with https
  - https://[server_ip]:[https_port]/phpldapadmin

## Logging

```bash
$ docker logs ldapadmin_app
```

## Remove

- Stop container

```bash
$ docker container stop ldapadmin_app
```

- Remove container

```bash
$ docker container rm ldapadmin_app
```

## License Agreement

BSD 3-Clause License  
Copyright (c) 2023, Laineil  
All rights reserved.
