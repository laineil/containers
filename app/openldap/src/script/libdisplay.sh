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
    printf "${1} = ${YELLOW}${2}${NC}\n"
}

# print ENV var setting table
print_env_table() {
    printf "${BLUE}--------- CHECK ENV VAR ---------${NC}\n"
    print_env_value LDAP_LOG_LEVEL ${LDAP_LOG_LEVEL}
    print_env_value LDAP_FE_ADMIN_PWD ${LDAP_FE_ADMIN_PWD}
    print_env_value LDAP_BE_ADMIN_PWD ${LDAP_BE_ADMIN_PWD}
    print_env_value LDAP_TLS ${LDAP_TLS}
    print_env_value LDAP_ANON_BIND ${LDAP_ANON_BIND}
    print_env_value LDAP_BASE_DN ${LDAP_BASE_DN}
    print_env_value LDAP_EX_TREE ${LDAP_EX_TREE}
    if [[ ${LDAP_EX_TREE} == "enable" ]]; then
        print_env_value LDAP_ACS_RULE ${LDAP_ACS_RULE}
        print_env_value LDAP_PWD_POLICY ${LDAP_PWD_POLICY}
    fi
    printf "${BLUE}-------------- END --------------${NC}\n"
}
