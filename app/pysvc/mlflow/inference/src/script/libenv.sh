#!/bin/bash
#
# Library for defining env variable

# system mlflow models serve
export MLF_HOST=0.0.0.0
export MLF_PORT=5000
export MLF_EX_MODEL_URI=exmodel
export MLF_EX_MODEL_PATH=/volume/mlflow/$MLF_EX_MODEL_URI

# dynamic var
export MLF_WORKERS="${MLF_WORKERS:-1}"
export MLF_TIMEOUT="${MLF_TIMEOUT:-60}"
export MLF_EX_MODEL="${MLF_EX_MODEL:-enable}"
export MLF_MODEL_URI="${MLF_MODEL_URI:-$MLF_EX_MODEL_URI}"
