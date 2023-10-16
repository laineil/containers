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

# set up mlflow models serve
mlflow_setup

# display var setting
print_env_table

# start mlflow models serve with container startup
info "** Starting MLflow Models Serve **"

mlflow models serve --no-conda --host $MLF_HOST --port $MLF_PORT --workers $MLF_WORKERS --model-uri $MLF_MODEL_URI

# end
exec "$@"
