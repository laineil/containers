[![Docker Pulls](https://img.shields.io/docker/pulls/laineil/openldap)](https://hub.docker.com/r/laineil/openldap) [![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/laineil/openldap?sort=date)](https://hub.docker.com/r/laineil/openldap/tags) [![Docker Image Version (latest by date)](https://img.shields.io/docker/v/laineil/openldap?sort=date)](https://hub.docker.com/r/laineil/openldap/tags)

## About OpenLDAP

[**OpenLDAP Software**](https://www.openldap.org/software/) is an [**open source**](http://www.opensource.org/) implementation of the **L**ightweight **D**irectory **A**ccess **P**rotocol.

The suite includes:

- [lloadd](https://www.openldap.org/software/man.cgi?query=lloadd) - stand-alone LDAP Load Balancer Daemon (server or slapd module)

- [slapd](https://www.openldap.org/software/man.cgi?query=slapd) - stand-alone LDAP daemon (server)

- [libraries](https://www.openldap.org/software/man.cgi?query=ldap) implementing the LDAP protocol, and

- utilities, tools, and sample clients.

## Image information

- The use of **non-root container images** can enhance system security.

- Use [**pqchecker**](http://www.meddeb.net/pqchecker/) to implement complex password policies.

- By default, a **self-signed TLS certificate** is supplied.
- Subscribe to project updates by watching the [laineil/containers GitHub repo](https://github.com/laineil/containers) for more information.

## Configuration

The container can be easily setup with the following environment variables:

- `LDAP_LOG_LEVEL`: Set the log level for the OpenLDAP server (see https://www.openldap.org/doc/admin25/slapdconfig.html for possible values). Default: **256**

- `LDAP_FRONTEND_ADMIN_PASSWORD`: LDAP frontend (config) admin password. Default: **Config@123**

- `LDAP_BACKEND_ADMIN_PASSWORD`: LDAP backend (mdb) admin password. Default: **Admin@123**

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

## EXAMPLE Users & Groups

- Admins

| Fcn                         | ID                         | PWD        |
| :-------------------------- | :------------------------- | :--------- |
| Frontend (**config**) Admin | cn=admin,cn=config         | Config@123 |
| Backend (**mdb**) Admin     | cn=admin,dc=example,dc=org | Admin@123  |

- Users (ou=users)

| Fcn              | ID                                      | PWD     |
| :--------------- | :-------------------------------------- | :------ |
| Service Accounts | uid=svc01-02,ou=users,dc=example,dc=org | Svc@123 |
| General Users    | user01-10,ou=users,dc=example,dc=org    | demopw  |

- Groups (ou=groups)

| Fcn                            | Goup                                    | User      |
| :----------------------------- | :-------------------------------------- | --------- |
| Service Groups (groupOfNames)  | cn=svcgp,ou=groups,dc=example,dc=org    | svc01-02  |
| General Groups 01 (posixGroup) | gid=group01,ou=groups,dc=example,dc=org | user01-02 |
| General Groups 02 (posixGroup) | gid=group02,ou=groups,dc=example,dc=org | user03-04 |
| General Groups 03 (posixGroup) | gid=group03,ou=groups,dc=example,dc=org | user05-06 |

- Departments (ou=departments)

| Fcn             | Departments                                              | User      |
| :-------------- | :------------------------------------------------------- | --------- |
| IT Managers     | cn=itmanagers,ou=it,ou=departments,dc=example,dc=org     | user01-02 |
| IT Employees    | cn=itemployees,ou=it,ou=departments,dc=example,dc=org    | user03-04 |
| HR Managers     | cn=hrmanagers,ou=hr,ou=departments,dc=example,dc=org     | user05    |
| HR Employees    | cn=hremployees,ou=hr,ou=departments,dc=example,dc=org    | user06-07 |
| Sales Managers  | cn=salesmanagers,ou=hr,ou=departments,dc=example,dc=org  | user08    |
| Sales Employees | cn=salesemployees,ou=hr,ou=departments,dc=example,dc=org | user09-10 |

## Example Directory Tree

```txt
dc=example,dc=org
├── cn=admin,dc=example,dc=org
├── ou=pwpolicies
│   ├── cn=default,ou=pwpolicies,dc=example,dc=org
│   └── cn=svc,ou=pwpolicies,dc=example,dc=org
├── ou=users
│   ├── uid=svc01,ou=users,dc=example,dc=org
│   ├── uid=svc02,ou=users,dc=example,dc=org
│   ├── uid=user01,ou=users,dc=example,dc=org
│   ├── uid=user02,ou=users,dc=example,dc=org
│   ├── uid=user03,ou=users,dc=example,dc=org
│   ├── uid=user04,ou=users,dc=example,dc=org
│   ├── uid=user05,ou=users,dc=example,dc=org
│   ├── uid=user06,ou=users,dc=example,dc=org
│   ├── uid=user07,ou=users,dc=example,dc=org
│   ├── uid=user08,ou=users,dc=example,dc=org
│   ├── uid=user09,ou=users,dc=example,dc=org
│   └── uid=user10,ou=users,dc=example,dc=org
├── ou=groups
│   ├── cn=services,ou=groups,dc=example,dc=org
│   │   ├── member=svc01,ou=users,dc=example,dc=org
│   │   └── member=svc02,ou=users,dc=example,dc=org
│   ├── cn=admins,ou=groups,dc=example,dc=org
│   │   ├── member=user01,ou=users,dc=example,dc=org
│   │   └── member=user02,ou=users,dc=example,dc=org
│   ├── cn=developers,ou=groups,dc=example,dc=org
│   │   ├── member=user03,ou=users,dc=example,dc=org
│   │   └── member=user04,ou=users,dc=example,dc=org
│   ├── cn=managers,ou=groups,dc=example,dc=org
│   │   ├── member=user01,ou=users,dc=example,dc=org
│   │   ├── member=user02,ou=users,dc=example,dc=org
│   │   ├── member=user05,ou=users,dc=example,dc=org
│   │   └── member=user08,ou=users,dc=example,dc=org
│   └── cn=employees,ou=groups,dc=example,dc=org
│       ├── member=user03,ou=users,dc=example,dc=org
│       ├── member=user04,ou=users,dc=example,dc=org
│       ├── member=user06,ou=users,dc=example,dc=org
│       ├── member=user07,ou=users,dc=example,dc=org
│       ├── member=user09,ou=users,dc=example,dc=org
│       └── member=user10,ou=users,dc=example,dc=org
└── ou=departments
    ├── ou=it
    │   ├── cn=itmanagers,ou=it,ou=departments,dc=example,dc=org
    │   │   ├── member=user01,ou=users,dc=example,dc=org
    │   │   └── member=user02,ou=users,dc=example,dc=org
    │   ├── cn=itemployees,ou=it,ou=departments,dc=example,dc=org
    │   │   ├── member=user03,ou=users,dc=example,dc=org
    │   │   └── member=user04,ou=users,dc=example,dc=org
    ├── ou=hr
    │   ├── cn=hrmanagers,ou=hr,ou=departments,dc=example,dc=org
    │   │   └── member=user05,ou=users,dc=example,dc=org
    │   ├── cn=hremployees,ou=hr,ou=departments,dc=example,dc=org
    │   │   ├── member=user06,ou=users,dc=example,dc=org
    │   │   └── member=user07,ou=users,dc=example,dc=org
    └── ou=sales
        ├── cn=salesmanagers,ou=sales,ou=departments,dc=example,dc=org
        │   └── member=user08,ou=users,dc=example,dc=org
        └── cn=salesemployees,ou=sales,ou=departments,dc=example,dc=org
            ├── member=user09,ou=users,dc=example,dc=org
            └── member=user10,ou=users,dc=example,dc=org
```

## License Agreement

BSD 3-Clause License  
Copyright (c) 2023, Laineil  
All rights reserved.
