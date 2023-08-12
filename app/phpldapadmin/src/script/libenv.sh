#!/bin/bash
#
# Library for defining env variable

# system httpd & phpldapadmin
export HTTPD_PID_FILE=/run/httpd/httpd.pid
export HTTPD_CONF=/etc/httpd/conf/httpd.conf
export SSL_CONF=/etc/httpd/conf.d/ssl.conf
export LDAP_CONF=/etc/openldap/ldap.conf
export LDAP_CA=/opt/certs/ldapca.crt
export PHP_CONF=/etc/phpldapadmin/config.php
export PHP_FPM_CONF=/etc/php-fpm.conf
export SUPERVISORD_CONF=/opt/conf/supervisord.conf

# dynamic var
export HTTPD_LOG_LEVEL="${HTTPD_LOG_LEVEL:-warn}"
export HTTPD_TLS_ROOTCA="${HTTPD_TLS_ROOTCA:-disable}"
export LDAP_TLS_REQCERT="${LDAP_TLS_REQCERT:-never}"
export LDAP_CONN_MODE="${LDAP_CONN_MODE:-ldap}"
export LDAP_SERVER_HOST="${LDAP_SERVER_HOST:-127.0.0.1}"
export LDAP_SERVER_NAME="${LDAP_SERVER_NAME:-default}"
export LDAP_CONN_PORT="${LDAP_CONN_PORT:-389}"
export PHPLDAP_LOGIN_ATTR="${PHPLDAP_LOGIN_ATTR:-dn}"
export PHPLDAP_AUTH_TYPE="${PHPLDAP_AUTH_TYPE:-session}"
export PHPLDAP_ANON_BIND="${PHPLDAP_ANON_BIND:-enable}"
export PHPLDAP_SESSION_TIMEOUT="${PHPLDAP_SESSION_TIMEOUT:-disable}"
export PHPLDAP_HIDE_WARN="${PHPLDAP_HIDE_WARN:-enable}"
export PHPLDAP_SAMPLE_DN="${PHPLDAP_SAMPLE_DN:-disable}"
