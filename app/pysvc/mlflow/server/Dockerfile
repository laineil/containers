# BSD 3-Clause License
# Copyright (c) 2023, Laineil
# All rights reserved.

FROM laineil/mlflow-base:latest

ARG SCRIPT_SRC=src/script
ARG SCRIPT_DEST=/opt/script

ENV MLF_PORT=5000
ENV PATH=${SCRIPT_DEST}:$PATH

USER root

COPY --chown=0:0 --chmod=755 ${SCRIPT_SRC} ${SCRIPT_DEST}

USER ${CONDA_USER}

WORKDIR ${MLFLOW_DATA}

EXPOSE ${MLF_PORT}

ENTRYPOINT ["tini", "--", "entrypoint.sh"]
