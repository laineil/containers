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

# clean up proccess
rm -rf $HTTPD_PID_FILE

# set up apache httpd
httpd_setup

### set up phpldapadmin ###
phpldapadmin_setup

# display var setting
print_env_table

# start httpd with container startup
info "** Starting phpLDAPadmin **"
supervisord -c $SUPERVISORD_CONF

# end
exec "$@"
