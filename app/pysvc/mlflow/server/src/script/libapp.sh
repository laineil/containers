#!/bin/bash
#
# Library for setting up OpenLDAP

# load env & lib
. /opt/script/libenv.sh
. /opt/script/liblog.sh

### default artifact root ###
mlflow_artifact_root() {
    info "Artifact root being set..."
    if [[ $MLF_ARTIFACT_ROOT == "disable" ]]; then
        export MLF_ARTIFACT_ROOT_ARGS=""
    elif [[ $MLF_ARTIFACT_ROOT == "enable" ]]; then
        if [[ $MLF_DEFAULT_ARTIFACT_ROOT == "none" ]]; then
            error "When MLF_ARTIFACT_ROOT is enabled, MLF_DEFAULT_ARTIFACT_ROOT must be provided."
            exit 1
        fi
        export MLF_ARTIFACT_ROOT_ARGS="--default-artifact-root $MLF_DEFAULT_ARTIFACT_ROOT"
    else
        error "MLF_ARTIFACT_ROOT setting is incorrect."
        exit 1
    fi
}

### expose prometheus ###
mlflow_prometheus() {
    info "Prometheus exporter being set..."
    if [[ $MLF_PROMETHEUS == "disable" ]]; then
        export MLF_PROMETHEUS_ARGS=""
    elif [[ $MLF_PROMETHEUS == "enable" ]]; then
        export MLF_PROMETHEUS_ARGS="--expose-prometheus $MLF_EXPORSE_PROMETHEUS"
    else
        error "ML_PROMETHEUS setting is incorrect."
        exit 1
    fi
}

### debug mode ###
mlflow_debug() {
    info "Debug logging being set..."
    if [[ $MLF_DEBUG == "disable" ]]; then
        export MLF_DEBUG_ARGS=""
    elif [[ $MLF_DEBUG == "enable" ]]; then
        export MLF_DEBUG_ARGS="--dev"
    else
        error "MLF_DEBUG setting is incorrect."
        exit 1
    fi
}

### app name ###
# This feature is still experimental and may change in a future release without warning.
mlflow_auth() {
    info "Authentication being set..."
    if [[ "$MLF_AUTH" == "disable" ]]; then
        export MLF_AUTH_ARGS=""
    elif [[ "$MLF_AUTH" == "enable" ]]; then
        export MLF_AUTH_ARGS="--app-name $MLF_APP_NAME"
    else
        error "MLF_AUTH setting is incorrect."
        exit 1
    fi
}

### set up mlflow server ###
mlflow_setup() {
    info "** Starting MLflow server setup **"
    mlflow_artifact_root
    mlflow_prometheus
    mlflow_debug
    mlflow_auth
    info "** MLflow server setup finished **"
}
