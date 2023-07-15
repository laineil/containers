# BSD 3-Clause License
# Copyright (c) 2023, Laineil
# All rights reserved.

### phase01-compiler ###
FROM almalinux:8-minimal as compiler

ARG JAVA_VERSION=1.8.0
ARG DNF_PKGS="diffutils findutils wget tar make gcc openssl-devel groff-base cyrus-sasl-devel libtool-ltdl-devel libtool git java-$JAVA_VERSION-openjdk java-$JAVA_VERSION-openjdk-devel"
ARG LDAP_VERSION=2.5.15
ARG LDAP_BIN_URL=https://www.openldap.org/software/download/OpenLDAP/openldap-release/openldap-$LDAP_VERSION.tgz
ARG LDAP_HOME=/opt/openldap
ARG PQCHECKER_URL=https://bitbucket.org/ameddeb/pqchecker.git

USER root

WORKDIR /tmp

RUN microdnf install -y $DNF_PKGS && \
    microdnf clean all && \
    # download openldap source
    wget $LDAP_BIN_URL --no-check-certificate && \
    tar zxf openldap-$LDAP_VERSION.tgz && \
    # download pqchecker source 
    git clone $PQCHECKER_URL && \
    # build openldap from source
    cd openldap-$LDAP_VERSION && \
    ./configure \
    --prefix=$LDAP_HOME \
    --enable-debug \
    --enable-dynamic \
    --enable-syslog \
    --enable-rlookups \
    --enable-crypt \
    --enable-spasswd \
    --enable-modules \
    --enable-slapd \
    --enable-overlays=mod \
    --with-cyrus-sasl \
    --with-tls=openssl && \
    make depend && \
    make && \
    # uncomment to test build
    #make test && \
    make install && \
    # build pqchecker from source
    cd /tmp/pqchecker && \
    autoreconf -f -i && \
    ./configure LDAPSRC=/tmp/openldap-$LDAP_VERSION \
    JAVAHOME=/usr/lib/jvm/java \
    libdir=$LDAP_HOME/libexec/openldap \
    PARAMDIR=$LDAP_HOME/etc/openldap/pqchecker && \
    make install $LDAP_HOME/etc/openldap/pqchecker

### phase02-TLS-configurator ###
FROM almalinux:8-minimal as configurator

ARG DNF_PKGS="openssl"
ARG CERTS_HOME=/opt/certs
ARG CERTS_CN=openldap
ARG LDAP_HOME=/opt/openldap

USER root

COPY --from=compiler $LDAP_HOME $LDAP_HOME

RUN microdnf install -y $DNF_PKGS && \
    microdnf clean all && \
    mkdir $CERTS_HOME && \
    openssl req -x509 -new -nodes -sha256 -utf8 -days 3650 -newkey rsa:2048 \
    -keyout $CERTS_HOME/server.key -out $CERTS_HOME/server.crt \
    -subj "/C=TW/ST=Taiwan/L=Taipei/O=EXAMPLE/CN=$CERTS_CN.example.org" && \
    cp $CERTS_HOME/server.crt $CERTS_HOME/rootca.crt && \
    chmod 644 $CERTS_HOME/*

### phase03-OpenLDAP image ###
FROM almalinux:8-minimal

ARG TIMEZONE=Asia/Taipei
ARG BASE_PKGS="glibc-langpack-en shadow-utils libtool-ltdl"
ARG PHASE_SRC=/opt
ARG LDAP_CONF=/volume/openldap/slapd.d
ARG LDAP_DATA=/volume/openldap/data
ARG LDAP_UID=1000
ARG LDAP_USER=ldap
ARG LDAP_LDIF_SRC=src/ldif
ARG LDAP_LDIF_DEST=/tmp/ldif
ARG HOME=/home/$LDAP_USER
ARG SCRIPT_SRC=src/script
ARG SCRIPT_DEST=/opt/script

ENV LANG=en_US.UTF-8
ENV LDAP_HOME=/opt/openldap
ENV PATH=$LDAP_HOME/bin:$LDAP_HOME/sbin:$LDAP_HOME/libexec:$SCRIPT_DEST:$PATH

USER root

COPY --from=configurator $PHASE_SRC $PHASE_SRC
COPY --chown=0:0 --chmod=755 $SCRIPT_SRC/ $SCRIPT_DEST/

RUN unlink /etc/localtime && \
    ln -s /usr/share/zoneinfo/$TIMEZONE /etc/localtime && \
    microdnf install -y $BASE_PKGS && \
    # uncomment to fix vulnerability
    #microdnf update -y && \
    microdnf clean all && \
    mkdir -p $LDAP_CONF $LDAP_DATA && \
    useradd -u $LDAP_UID $LDAP_USER && \
    chown $LDAP_UID:0 -R $LDAP_CONF $LDAP_DATA $LDAP_HOME/var/run

USER $LDAP_USER

COPY --chown=$LDAP_USER:$LDAP_USER $LDAP_LDIF_SRC $LDAP_LDIF_DEST

WORKDIR $HOME

EXPOSE 1389 1636

ENTRYPOINT ["entrypoint.sh"]
