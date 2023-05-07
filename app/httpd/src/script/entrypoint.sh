#!/bin/bash

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail

# load env & lib
. /opt/script/libenv.sh
. /opt/script/liblog.sh
. /opt/script/libdisplay.sh

# clean up proccess
rm -rf $HTTPD_PID_FILE

# display var setting
print_env_table

# start httpd with container startup
info "** Starting Apache HTTPD **"
httpd -f $HTTPD_CONF -DFOREGROUND -e $HTTPD_LOG_LEVEL

# end
exec "$@"
