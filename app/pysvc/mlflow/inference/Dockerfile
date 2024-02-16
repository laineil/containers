# BSD 3-Clause License
# Copyright (c) 2023, Laineil
# All rights reserved.

FROM laineil/mlflow-base:latest

ARG SCRIPT_SRC=src/script
ARG SCRIPT_DEST=/opt/script
ARG MLF_MODEL_SRC=src/exmodel
ARG MLF_MODEL_DEST=/volume/mlflow/exmodel

ENV MLF_PORT=5000
ENV PATH=${SCRIPT_DEST}:$PATH

USER root

COPY --chown=0:0 --chmod=755 ${SCRIPT_SRC} ${SCRIPT_DEST}
COPY --chown=1000:1000 ${MLF_MODEL_SRC} ${MLF_MODEL_DEST}

USER ${CONDA_USER}

RUN mamba install -qy \
    lz4 \
    psutil && \
    mamba clean -afy

WORKDIR ${MLFLOW_DATA}

EXPOSE ${MLF_PORT}

ENTRYPOINT ["tini", "--", "entrypoint.sh"]
