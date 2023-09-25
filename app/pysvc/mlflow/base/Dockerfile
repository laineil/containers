# BSD 3-Clause License
# Copyright (c) 2023, Laineil
# All rights reserved.

FROM laineil/miniforge:latest

ENV MLFLOW_DATA=/volume/mlflow

# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

RUN mkdir -p $MLFLOW_DATA && \
    chown $MAMBA_UID:0 $MLFLOW_DATA

USER $MAMBA_USER

WORKDIR $HOME

RUN mamba install -qy \
    mlflow && \
    mamba clean -afy

WORKDIR $HOME
