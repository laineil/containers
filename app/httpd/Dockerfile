# BSD 3-Clause License
# Copyright (c) 2023, Laineil
# All rights reserved.

### phase01-TLS-configurator ###
FROM almalinux:9-minimal as configurator

ARG BASE_PKGS="openssl"
ARG CERTS_HOME=/opt/certs
ARG CERTS_CN=httpd

USER root

RUN microdnf install -y ${BASE_PKGS} && \
    microdnf clean all && \
    mkdir ${CERTS_HOME} && \
    openssl req -x509 -new -nodes -sha256 -utf8 -days 3650 -newkey rsa:2048 \
    -keyout ${CERTS_HOME}/server.key -out ${CERTS_HOME}/server.crt \
    -subj "/C=TW/ST=Taiwan/L=Taipei/O=EXAMPLE/CN=${CERTS_CN}.example.org" && \
    cp ${CERTS_HOME}/server.crt ${CERTS_HOME}/rootca.crt && \
    chmod 644 ${CERTS_HOME}/*

### phase02-HTTPD image ###
FROM almalinux:9-minimal

ARG BASE_PKGS="glibc-langpack-en shadow-utils"
ARG EXTRA_PKGS="httpd mod_ssl"
ARG PHASE_SRC=/opt/certs
ARG APACHE_UID=1000
ARG APACHE_USER=apache
ARG HOME=/home/${APACHE_USER}
ARG HTTPD_RUN=/run/httpd
ARG HTTPD_LOG=/var/log/httpd
ARG HTTPD_LIB=/var/lib/httpd
ARG HTTPD_ETC=/etc/httpd
ARG HTTPD_CONF=/etc/httpd/conf/httpd.conf
ARG HTTPD_HTML_DIR=/var/www/html
ARG SSL_CONF=/etc/httpd/conf.d/ssl.conf
ARG INT_HTTP_PORT=8080
ARG INT_HTTPS_PORT=8443
ARG LOCALHOST_CA=/etc/pki/tls/certs/ca-bundle.crt
ARG LOCALHOST_CRT=/etc/pki/tls/certs/localhost.crt
ARG LOCALHOST_KEY=/etc/pki/tls/private/localhost.key
ARG ROOT_CA=/opt/certs/rootca.crt
ARG SERVER_CRT=/opt/certs/server.crt
ARG SERVER_KEY=/opt/certs/server.key
ARG SCRIPT_SRC=src/script
ARG SCRIPT_DEST=/opt/script
ARG STDOUT_LOG=/proc/self/fd/1
ARG STDERR_LOG=/proc/self/fd/2

ENV LANG=en_US.UTF-8
ENV PATH=${SCRIPT_DEST}:$PATH

USER root

COPY --from=configurator ${PHASE_SRC} ${PHASE_SRC}
COPY --chown=0:0 --chmod=755 ${SCRIPT_SRC} ${SCRIPT_DEST}

RUN microdnf install -y ${BASE_PKGS} && \
    useradd -u ${APACHE_UID} ${APACHE_USER} && \
    rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && \
    microdnf install -y tini ${EXTRA_PKGS} && \
    # uncomment to fix vulnerability
    #microdnf update -y && \
    microdnf clean all && \
    chown ${APACHE_UID}:0 -R ${HTTPD_RUN} && \
    chown ${APACHE_UID}:0 -R ${HTTPD_LOG} && \
    chown ${APACHE_UID}:0 -R ${HTTPD_LIB} && \
    chown ${APACHE_UID}:0 -R ${HTTPD_ETC}/conf* && \
    chown ${APACHE_UID}:0 -R ${HTTPD_HTML_DIR}

USER ${APACHE_UID}

WORKDIR ${HOME}

RUN sed -i "s/80/${INT_HTTP_PORT}/g" ${HTTPD_CONF} && \
    sed -i "s|logs/access_log|${STDOUT_LOG}|g" ${HTTPD_CONF} && \
    sed -i "s|logs/error_log|${STDERR_LOG}|g" ${HTTPD_CONF} && \
    sed -i "s/443/${INT_HTTPS_PORT}/g" ${SSL_CONF} && \
    sed -i "s|${LOCALHOST_CA}|${ROOT_CA}|g" ${SSL_CONF} && \
    sed -i "s|${LOCALHOST_CRT}|${SERVER_CRT}|g" ${SSL_CONF} && \
    sed -i "s|${LOCALHOST_KEY}|${SERVER_KEY}|g" ${SSL_CONF} && \
    sed -i "s|logs/ssl_access_log|${STDOUT_LOG}|g" ${SSL_CONF} && \
    sed -i "s|logs/ssl_request_log|${STDOUT_LOG}|g" ${SSL_CONF} && \
    sed -i "s|logs/ssl_error_log|${STDERR_LOG}|g" ${SSL_CONF}

EXPOSE ${INT_HTTP_PORT} ${INT_HTTPS_PORT}

ENTRYPOINT ["tini", "--", "entrypoint.sh"]
