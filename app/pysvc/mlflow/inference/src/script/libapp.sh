#!/bin/bash
#
# Library for setting up OpenLDAP

# load env & lib
. /opt/script/libenv.sh
. /opt/script/liblog.sh

### check example model ###
mlflow_ex_model() {
    info "Example Model is being set..."
    if [[ ${MLF_EX_MODEL} == "enable" ]]; then
        :
    elif [[ ${MLF_EX_MODEL} == "disable" ]]; then
        info "Clear the MLFlow Example Model."
        warn "When MLF_EX_MODEL is set to 'disable', you must provide your model."
        rm -rf ${MLF_EX_MODEL_PATH}
    else
        error "MLF_EX_MODEL setting is incorrect."
        exit 1
    fi
}

### check model uri ###
mlflow_model_uri() {
    info "Model URI is being set..."
    if [[ ${MLF_MODEL_URI} == ${MLF_EX_MODEL_URI} ]]; then
        if [[ ${MLF_EX_MODEL} == "disable" ]]; then
            error "When MLF_MODEL_URI is default, MLF_EX_MODEL must be 'enable'."
            exit 1
        fi
    else
        if [[ ${MLF_EX_MODEL} == "enable" ]]; then
            error "When MLF_EX_MODEL is non-default, MLF_EX_MODEL must be 'disable'."
            exit 1
        fi
    fi
}

### set up mlflow models serve ###
mlflow_setup() {
    info "** Starting MLflow models serve setup **"
    mlflow_ex_model
    mlflow_model_uri
    info "** MLflow models serve setup finished **"
}
