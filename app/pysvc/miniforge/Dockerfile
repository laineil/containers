# BSD 3-Clause License
# Copyright (c) 2023, Laineil
# All rights reserved.

FROM almalinux:8-minimal

ARG BASE_PKGS="glibc-langpack-en shadow-utils"
ARG CONDA_BIN=Minforge.sh

ENV CONDA_DIR=/opt/conda
ENV CONDA_USER=conda
ENV CONDA_UID=1000
ENV HOME=/home/${CONDA_USER}
ENV LANG=en_US.UTF-8
ENV PATH=${CONDA_DIR}/bin:$PATH

# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

# Add call to conda init script see https://stackoverflow.com/a/58081608/4413446
RUN echo 'eval "$(command conda shell.bash hook 2> /dev/null)"' >> /etc/skel/.bashrc && \
    microdnf install -y ${BASE_PKGS} && \
    rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && \
    microdnf install -y tini && \
    # uncomment to fix vulnerability
    #microdnf update -y && \
    microdnf clean all && \
    useradd -u ${CONDA_UID} ${CONDA_USER} && \
    mkdir -p ${CONDA_DIR} && \
    chown ${CONDA_UID}:0 ${CONDA_DIR}

USER ${CONDA_USER}

WORKDIR ${HOME}

RUN set -x && \
    # download the latest miniforge
    curl -L https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-`uname -m`.sh -o ${CONDA_BIN} && \
    bash ${CONDA_BIN} -bfp ${CONDA_DIR} && \
    # remove the miniforge installation binary
    rm -f ${CONDA_BIN} && \
    conda config --system --set auto_update_conda false && \
    conda config --system --set show_channel_urls true && \
    mamba list python | grep '^python ' | tr -s ' ' | cut -d ' ' -f 1,2 >> "${CONDA_DIR}/conda-meta/pinned" && \
    mamba clean -afy
