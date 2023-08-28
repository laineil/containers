#!/bin/bash
#
# Library for setting up OpenLDAP

# load env & lib
. /opt/script/libenv.sh
. /opt/script/liblog.sh

### expose prometheus ###
mlflow_prometheus() {
    if [[ "$MLF_PROMETHEUS" == "disable" ]]; then
        export MLF_PROMETHEUS_ARGS=""
    elif [[ "$MLF_PROMETHEUS" == "enable" ]]; then
        export MLF_PROMETHEUS_ARGS="--expose-prometheus $MLF_EXPORSE_PROMETHEUS"
    else
        error "ML_PROMETHEUS setting is incorrect."
        exit 1
    fi
}

### set up mlflow server ###
mlflow_setup() {
    info "** Starting MLflow setup **"
    mlflow_prometheus
    #mlflow_auth
    info "** MLflow setup finished **"
}
