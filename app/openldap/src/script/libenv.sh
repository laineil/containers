#!/bin/bash
#
# Library for defining env variable

# system ldap
LDAP_HOME=/opt/openldap
LDAP_SLAPD=$LDAP_HOME/libexec/slapd
LDAP_URLS="ldapi:// ldap://:1389 ldaps://:1636"
LDAP_CONF_DIR=/volume/openldap/slapd.d
LDAP_PID_FILE=$LDAP_HOME/var/run/slapd.pid
LDAP_LDIF_TMP=/tmp/ldif

# dynamic var
SLEEP_TIME="${SLEEP_TIME:-1}"
LDAP_LOG_LEVEL="${LDAP_LOG_LEVEL:-256}"
LDAP_FE_ADMIN_PWD="${LDAP_FE_ADMIN_PWD:-default}"
LDAP_BE_ADMIN_PWD="${LDAP_BE_ADMIN_PWD:-default}"
LDAP_TLS="${LDAP_TLS:-disable}"
LDAP_ANON_BIND="${LDAP_ANON_BIND:-enable}"
LDAP_BASE_DN="${LDAP_BASE_DN:-dc=example,dc=org}"
LDAP_EX_TREE="${LDAP_EX_TREE:-enable}"
LDAP_ACS_RULE="${LDAP_ACS_RULE:-flexible}"
LDAP_PWD_POLICY="${LDAP_PWD_POLICY:-disable}"
