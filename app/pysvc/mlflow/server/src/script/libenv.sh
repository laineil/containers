#!/bin/bash
#
# Library for defining env variable

# system mlflow server
export MLF_HOST=0.0.0.0
export MLF_PORT=5000

# dynamic var
export MLF_BACKEND_STORE_UIR="${MLF_BACKEND_STORE_UIR:-file:///volume/mlflow/mlruns}"
export MLFLOW_ARTIACTS_DESTINATION="${MLFLOW_ARTIACTS_DESTINATION:-file:///volume/mlflow/mlartifacts}"
export MLF_WORKERS="${MLF_WORKERS:-1}"
export MLF_ARTIFACT_ROOT="${MLF_ARTIFACT_ROOT:-disable}"
export MLF_DEFAULT_ARTIFACT_ROOT="${MLF_DEFAULT_ARTIFACT_ROOT:-none}"
export MLF_PROMETHEUS="${MLF_PROMETHEUS:-disable}"
export MLF_EXPORSE_PROMETHEUS="${MLF_EXPORSE_PROMETHEUS:-/volume/mlflow/metrics}"
export MLF_DEBUG="${MLF_DEBUG:-disable}"
export MLF_AUTH="${MLF_AUTH:-disable}"
export MLF_APP_NAME="${MLF_APP_NAME:-basic-auth}"
