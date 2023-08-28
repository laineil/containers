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

# set up ldap
mlflow_setup

# display var setting
print_env_table

# start mlflow server with container startup
info "** Starting MLflow Server **"
mlflow server --backend-store-uri $MLF_BACKEND_STORE_UIR --default-artifact-root $MLF_DEFAULT_ARTIFACT_ROOT --host $MLF_HOST --port $MLF_PORT --workers $MLF_WORKERS $MLF_PROMETHEUS_ARGS

# end
exec "$@"
