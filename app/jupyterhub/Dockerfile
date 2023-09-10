# BSD 3-Clause License
# Copyright (c) 2023, Laineil
# All rights reserved.

FROM almalinux:8-minimal

ARG TIMEZONE=Asia/Taipei
ARG BASE_PKGS="glibc-langpack-en pam"

ENV CONDA_DIR=/opt/conda
ENV SHELL=/bin/bash
ENV LANG=en_US.UTF-8
ENV PATH=$CONDA_DIR/bin:$PATH

# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

WORKDIR /tmp

RUN set -x && \
    unlink /etc/localtime && \
    ln -s /usr/share/zoneinfo/$TIMEZONE /etc/localtime && \
    # Add call to conda init script see https://stackoverflow.com/a/58081608/4413446
    echo 'eval "$(command conda shell.bash hook 2> /dev/null)"' >> /root/.bashrc && \
    microdnf install -y $BASE_PKGS && \
    # uncomment to fix vulnerability
    #microdnf update -y && \
    microdnf clean all && \
    # download the latest miniforge
    curl -L https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-$(uname -m).sh -o $CONDA_BIN && \
    bash $CONDA_BIN -bfp $CONDA_DIR && \
    # remove the miniforge installation binary
    rm -f $CONDA_BIN && \
    conda config --system --set auto_update_conda false && \
    conda config --system --set show_channel_urls true && \
    mamba list python | grep '^python ' | tr -s ' ' | cut -d ' ' -f 1,2 >> "$CONDA_DIR/conda-meta/pinned" && \
    mamba install -qy \
    jupyterhub && \
    # clean up temporary conda files
    mamba clean -afy && \
    mkdir -p /srv/jupyterhub

WORKDIR /srv/jupyterhub

CMD ["jupyterhub"]
