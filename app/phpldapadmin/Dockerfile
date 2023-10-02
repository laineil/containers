# BSD 3-Clause License
# Copyright (c) 2023, Laineil
# All rights reserved.

### phase01-TLS-configurator ###
FROM almalinux:8-minimal as configurator

ARG DNF_PKGS="openssl"
ARG CERTS_HOME=/opt/certs
ARG CERTS_CN=phpldapadmin

USER root

RUN microdnf install -y $DNF_PKGS && \
    microdnf clean all && \
    mkdir $CERTS_HOME && \
    openssl req -x509 -new -nodes -sha256 -utf8 -days 3650 -newkey rsa:2048 \
    -keyout $CERTS_HOME/server.key -out $CERTS_HOME/server.crt \
    -subj "/C=TW/ST=Taiwan/L=Taipei/O=EXAMPLE/CN=$CERTS_CN.example.org" && \
    cp $CERTS_HOME/server.crt $CERTS_HOME/rootca.crt && \
    cp $CERTS_HOME/server.crt $CERTS_HOME/ldapca.crt && \
    chmod 644 $CERTS_HOME/*

### phase02-phpLDAPadmin image ###
FROM almalinux:8-minimal

ARG BASE_PKGS="glibc-langpack-en shadow-utils"
ARG EXTRA_PKGS="httpd mod_ssl phpldapadmin supervisor"
ARG PHASE_SRC=/opt/certs
ARG APACHE_UID=1000
ARG APACHE_USER=apache
ARG HOME=/home/$APACHE_USER
ARG HTTPD_RUN=/run/httpd
ARG HTTPD_LOG=/var/log/httpd
ARG HTTPD_LIB=/var/lib/httpd
ARG HTTPD_ETC=/etc/httpd
ARG HTTPD_CONF=/etc/httpd/conf/httpd.conf
ARG HTTPD_HTML_DIR=/var/www/html
ARG SSL_CONF=/etc/httpd/conf.d/ssl.conf
ARG PHP_RUN=/run/php-fpm
ARG PHP_LOG=/var/log/php-fpm
ARG PHP_ETC=/etc/phpldapadmin
ARG PHP_INI=/etc/php.ini
ARG PHP_WWW=/etc/php-fpm.d/www.conf
ARG PHP_LDAP_CONF=/etc/httpd/conf.d/phpldapadmin.conf
ARG LDAP_CONF=/etc/openldap/ldap.conf
ARG INT_HTTP_PORT=8080
ARG INT_HTTPS_PORT=8443
ARG LOCALHOST_CA=/etc/pki/tls/certs/ca-bundle.crt
ARG LOCALHOST_CRT=/etc/pki/tls/certs/localhost.crt
ARG LOCALHOST_KEY=/etc/pki/tls/private/localhost.key
ARG ROOT_CA=/opt/certs/rootca.crt
ARG SERVER_CRT=/opt/certs/server.crt
ARG SERVER_KEY=/opt/certs/server.key
ARG SCRIPT_SRC=src/script
ARG CONF_SRC=src/conf
ARG SCRIPT_DEST=/opt/script
ARG CONF_DEST=/opt/conf

ENV LANG=en_US.UTF-8
ENV PATH=$SCRIPT_DEST:$PATH

USER root

COPY --from=configurator $PHASE_SRC $PHASE_SRC
COPY --chown=0:0 --chmod=755 $SCRIPT_SRC/ $SCRIPT_DEST/
COPY --chown=0:0 --chmod=644 $CONF_SRC/ $CONF_DEST/

RUN microdnf install -y $BASE_PKGS && \
    useradd -u $APACHE_UID $APACHE_USER && \
    rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && \
    microdnf install -y tini $EXTRA_PKGS && \
    # uncomment to fix vulnerability
    #microdnf update -y && \
    microdnf clean all && \
    chown $APACHE_UID:0 -R $HTTPD_RUN && \
    chown $APACHE_UID:0 -R $HTTPD_LOG && \
    chown $APACHE_UID:0 -R $HTTPD_LIB && \
    chown $APACHE_UID:0 -R $HTTPD_ETC/conf* && \
    chown $APACHE_UID:0 -R $HTTPD_HTML_DIR && \
    mkdir $PHP_RUN && \
    chown $APACHE_UID:0 -R $PHP_RUN && \
    chown $APACHE_UID:0 -R $PHP_LOG && \
    chown $APACHE_UID:0 -R $PHP_ETC && \
    sed -i "s/memory_limit =.*/memory_limit = 256M/g" $PHP_INI && \
    sed -i "s/^user =/;user =/g" $PHP_WWW && \
    sed -i "s/^group =/;group =/g" $PHP_WWW && \
    chown $APACHE_UID:0 $LDAP_CONF

USER $APACHE_UID

WORKDIR $HOME

RUN sed -i "s/80/$INT_HTTP_PORT/g" $HTTPD_CONF && \
    sed -i "s/443/$INT_HTTPS_PORT/g" $SSL_CONF && \
    sed -i "s|$LOCALHOST_CA|$ROOT_CA|g" $SSL_CONF && \
    sed -i "s|$LOCALHOST_CRT|$SERVER_CRT|g" $SSL_CONF && \
    sed -i "s|$LOCALHOST_KEY|$SERVER_KEY|g" $SSL_CONF && \
    sed -i "s/Require local/Require all granted/g" $PHP_LDAP_CONF

EXPOSE $INT_HTTP_PORT $INT_HTTPS_PORT

ENTRYPOINT ["tini", "--", "entrypoint.sh"]
