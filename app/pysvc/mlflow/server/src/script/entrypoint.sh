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

# set up mlflow server
mlflow_setup

# display var setting
print_env_table

# start mlflow server with container startup
info "** Starting MLflow Server **"

mlflow server --backend-store-uri $MLF_BACKEND_STORE_UIR --artifacts-destination $MLFLOW_ARTIACTS_DESTINATION --host $MLF_HOST --port $MLF_PORT --workers $MLF_WORKERS $MLF_ARTIFACT_ROOT_ARGS $MLF_PROMETHEUS_ARGS $MLF_DEBUG_ARGS $MLF_AUTH_ARGS

# end
exec "$@"
