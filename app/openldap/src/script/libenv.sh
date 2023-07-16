#!/bin/bash
#
# Library for defining env variable

# system ldap
export LDAP_HOME=/opt/openldap
export LDAP_SLAPD=$LDAP_HOME/libexec/slapd
export LDAP_URLS="ldapi:// ldap://:1389 ldaps://:1636"
export LDAP_CONF_DIR=/volume/openldap/slapd.d
export LDAP_PID_FILE=$LDAP_HOME/var/run/slapd.pid
export LDAP_LDIF_TMP=/tmp/ldif

# dynamic var
export SLEEP_TIME="${SLEEP_TIME:-1}"
export LDAP_LOG_LEVEL="${LDAP_LOG_LEVEL:-256}"
export LDAP_FE_ADMIN_PWD="${LDAP_FE_ADMIN_PWD:-default}"
export LDAP_BE_ADMIN_PWD="${LDAP_BE_ADMIN_PWD:-default}"
export LDAP_TLS="${LDAP_TLS:-disable}"
export LDAP_ANON_BIND="${LDAP_ANON_BIND:-enable}"
export LDAP_BASE_DN="${LDAP_BASE_DN:-dc=example,dc=org}"
export LDAP_EX_TREE="${LDAP_EX_TREE:-enable}"
export LDAP_ACS_RULE="${LDAP_ACS_RULE:-flexible}"
export LDAP_PWD_POLICY="${LDAP_PWD_POLICY:-disable}"
