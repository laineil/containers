#!/bin/bash
#
# Library for displaying variable settings

# load env & lib
. /opt/script/libenv.sh

# Regular Colors
NC='\033[0m'
#RED='\033[38;5;1m'
#GREEN='\033[38;5;2m'
YELLOW='\033[38;5;3m'
BLUE='\033[38;5;4m'
#MAGENTA='\033[38;5;5m'
#CYAN='\033[38;5;6m'

# print ENV var setting with color
print_env_value() {
    printf "$1 = ${YELLOW}$2${NC}\n"
}

# print ENV var setting table
print_env_table() {
    printf "${BLUE}--------- CHECK ENV VAR ---------${NC}\n"
    print_env_value HTTPD_LOG_LEVEL $HTTPD_LOG_LEVEL
    print_env_value HTTPD_TLS_ROOTCA $HTTPD_TLS_ROOTCA
    print_env_value LDAP_CONN_MODE $LDAP_CONN_MODE
    if [[ $LDAP_CONN_MODE == "ldaps" ]]; then
        print_env_value LDAP_TLS_REQCERT $LDAP_TLS_REQCERT
    else
        :
    fi
    print_env_value LDAP_SERVER_NAME $LDAP_SERVER_NAME
    print_env_value LDAP_SERVER_HOST $LDAP_SERVER_HOST
    print_env_value LDAP_CONN_PORT $LDAP_CONN_PORT
    print_env_value PHPLDAP_LOGIN_ATTR $PHPLDAP_LOGIN_ATTR
    print_env_value PHPLDAP_AUTH_TYPE $PHPLDAP_AUTH_TYPE
    print_env_value PHPLDAP_ANON_BIND $PHPLDAP_ANON_BIND
    print_env_value PHPLDAP_SESSION_TIMEOUT $PHPLDAP_SESSION_TIMEOUT
    print_env_value PHPLDAP_HIDE_WARN $PHPLDAP_HIDE_WARN
    print_env_value PHPLDAP_SAMPLE_DN $PHPLDAP_SAMPLE_DN
    printf "${BLUE}-------------- END --------------${NC}\n"
}
