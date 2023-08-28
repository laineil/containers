#!/bin/bash
#
# Library for defining env variable

# system ldap
export MLF_HOST=0.0.0.0
export MLF_PORT=5000

# dynamic var
export MLF_BACKEND_STORE_UIR="${MLF_BACKEND_STORE_UIR:-sqlite:////volume/mlflow/mlflow.db}"
export MLF_DEFAULT_ARTIFACT_ROOT="${MLF_DEFAULT_ARTIFACT_ROOT:-file:///volume/mlflow/mlruns}"
export MLF_WORKERS="${MLF_WORKERS:-1}"
export MLF_PROMETHEUS="${MLF_PROMETHEUS:-disable}"
export MLF_EXPORSE_PROMETHEUS="${MLF_EXPORSE_PROMETHEUS:-/volume/mlflow/metrics}"
