[![Docker Pulls](https://img.shields.io/docker/pulls/laineil/openldap)](https://hub.docker.com/r/laineil/openldap) [![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/laineil/openldap?sort=date)](https://hub.docker.com/r/laineil/openldap/tags) [![Docker Image Version (latest by date)](https://img.shields.io/docker/v/laineil/openldap?sort=date)](https://hub.docker.com/r/laineil/openldap/tags) ![Static Badge](https://img.shields.io/badge/arch-x86__64%20%7C%20arm64%20%7C%20ppc64le-blue) ![GitHub](https://img.shields.io/github/license/laineil/containers)

## About OpenLDAP

[**OpenLDAP Software**](https://www.openldap.org/software/) is an [**open source**](http://www.opensource.org/) implementation of the **L**ightweight **D**irectory **A**ccess **P**rotocol.

The suite includes:

- [lloadd](https://www.openldap.org/software/man.cgi?query=lloadd) - stand-alone LDAP Load Balancer Daemon (server or slapd module)
- [slapd](https://www.openldap.org/software/man.cgi?query=slapd) - stand-alone LDAP daemon (server)
- [libraries](https://www.openldap.org/software/man.cgi?query=ldap) implementing the LDAP protocol, and utilities, tools, and sample clients.

## Image information

- The use of **non-root container images** can enhance system security.
- Support the **TZ** environment variable to set up the desired timezone (see [Services top-level element](https://docs.docker.com/compose/compose-file/05-services/)).
- Use [**pqchecker**](http://www.meddeb.net/pqchecker/) to implement complex password policies.
- By default, a **self-signed TLS certificate** is supplied.
- Subscribe to project updates by watching the [laineil/containers GitHub repo](https://github.com/laineil/containers) for more information.

## Configuration

The container can be easily setup with the following environment variables:

- `LDAP_LOG_LEVEL`: Set the log level for the OpenLDAP server (see [The slapd Configuration File - loglevel](https://www.openldap.org/doc/admin25/slapdconfig.html) for possible values). Default: **256**

- `LDAP_FE_ADMIN_PWD`: LDAP frontend (config) admin password. Default: **Config@123**

- `LDAP_BE_ADMIN_PWD`: LDAP backend (mdb) admin password. Default: **Admin@123**

- `LDAP_TLS`: Whether to enable TLS for traffic or not. Default: **disable** (enable)
  - enable: 
    - Supply a **self-signed TLS certificate (with CA)**. You can replace the certificate with your own.
    - certs dir: **/opt/certs**
    - certs files: **rootca.crt**, **server.crt**, **server.key**

- `LDAP_ANON_BIND`: Allow anonymous bindings to the LDAP server. Default: **enable** (disable)

- `LDAP_BASE_DN`: LDAP baseDN of the tree. Default: **dc=example,dc=org**

- `LDAP_EX_TREE`: LDAP example tree for testing. Default: **enable** (disable)

- `LDAP_ACS_RULE`: Only when **LDAP_EX_TREE=enable** is valid. LDAP access rules. Default: **flexible** (strict)
  - flexible: self **write**, users/anonymous **read**.
  - strict: self **write**, services group **read**, users/anonymous **none**.

- `LDAP_PWD_POLICY`: Only when **LDAP_EX_TREE=enable** is valid. LDAP password policy. Default: **disable** (enable)
  - enable: 
    - The default password configuration must contain at least one **uppercase letter**, one **lowercase letter**, one **number**, and one **special character**, with a minimum length of **8** characters.
    - Passwords expire after **90** days.
    - The system remembers the last **5** passwords.
    - If there are **5** consecutive incorrect password attempts, the account will be locked for five minutes.
    - The same password policy applies to **service accounts**, except that they do not have a password expiration requirement.

## Run a container

Here are a few methods for running a container.

- Quick start

```bash
$ docker run -d \
--name ldap_app \
-v ldap_volume:/volume/openldap \
-p [expose_port]:1389 \
-p [expose_port]:1636 \
laineil/openldap:[tag]
```

- With your own TLS certificate


```bash
$ docker run -d \
--name ldap_app \
-v ldap_volume:/volume/openldap \
-v [certs_path]:/opt/certs:ro \
-p [expose_port]:1389 \
-p [expose_port]:1636 \
-e LDAP_TLS=enable \
laineil/openldap:[tag]

# To use LDAP with TLS, ensure that LDAP_TLS is enabled.
# [certs_folder] must contains rootca.crt, server.crt, server.key (certificate name must match).
# Make sure the certificate files within [certs_folder] have permission 644.
```

- Recommended Examples

```bash
$ docker run -d \
--name ldap_app \
-v ldap_volume:/volume/openldap \
-p 389:1389 \
-p 636:1636 \
-e LDAP_TLS=enable \
-e LDAP_ANON_BIND=disable \
-e LDAP_ACS_RULE=strict \
-e LDAP_PWD_POLICY=enable \
laineil/openldap:[tag]
```

## Verify

- with ldap

```bash
$ ldapsearch -x -H ldap://[server_ip]:389 -D "cn=admin,dc=example,dc=org" -w Admin@123 -b "dc=example,dc=org"
```

- with ldaps

```bash
$ ldapsearch -x -H ldaps://[server_ip]:636 -D "cn=admin,dc=example,dc=org" -w Admin@123 -b "dc=example,dc=org" 
```

## Logging

```bash
$ docker logs ldap_app
```

## Remove

- Stop container

```bash
$ docker container stop ldap_app
```

- Remove container

```bash
$ docker container rm ldap_app
```

- Remove volume

```bash
$ docker volume rm ldap_volume
```

## EXAMPLE Directory Tree

The detailed information of the default example directory tree can be found [here](https://github.com/laineil/containers/blob/main/app/openldap/ex_dir_tree.md).

## Docker Compose File

You can use the [`docker-compose.yaml`](https://github.com/laineil/containers/tree/main/app/openldap/docker-compose.yaml) file to combine [laineil/openldap](https://hub.docker.com/r/laineil/openldap) with [laineil/phpldapadmin](https://hub.docker.com/r/laineil/phpldapadmin).

- Start containers

```bash
$ docker compose up -d
```

- Stop containers

```bash
$ docker compose down
```

## License Agreement

BSD 3-Clause License  
Copyright (c) 2023, Laineil  
All rights reserved.
