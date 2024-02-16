#!/bin/bash

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail

# load env & lib
. /opt/script/libenv.sh
. /opt/script/liblog.sh
. /opt/script/libapp.sh
. /opt/script/libdisplay.sh

if [[ -z "$(ls ${LDAP_CONF_DIR})" ]]; then
   # set up ldap
   ldap_setup
   # display var setting
   print_env_table
else
   # clean up ldap ldif tmp
   rm -rf ${LDAP_LDIF_TMP}
   info "Starting OpenLDAP with an external volume, all parameters except LDAP_LOG_LEVEL are ignored."
   print_env_value LDAP_LOG_LEVEL ${LDAP_LOG_LEVEL}
fi

# start ldap with container startup
info "** Starting OpenLDAP **"
${LDAP_SLAPD} -h "${LDAP_URLS}" -F ${LDAP_CONF_DIR} -d ${LDAP_LOG_LEVEL}

# end
exec "$@"
