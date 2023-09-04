# BSD 3-Clause License
# Copyright (c) 2023, Laineil
# All rights reserved.

FROM laineil/jupyter-base-notebook:latest

# Common useful utilities
# less is needed to run help in R
# see: https://github.com/jupyter/docker-stacks/issues/1588
# nbconvert dependencies
# https://nbconvert.readthedocs.io/en/latest/install.html#installing-tex
# Enable clipboard on Linux host systems
ARG BASE_PKGS="git tar unzip openssh-clients less xclip texlive-xetex texlive-bibtex texlive-eurosym texlive-jknapltx texlive-lm-math texlive-rsfs texlive-ec texlive-parskip texlive-ulem texlive-titling texlive-tcolorbox texlive-adjustbox texlive-ucharcat texlive-upquote"
ARG CONF_SRC=src/conf
ARG CONF_DEST=/opt/conda/lib/R/etc
ARG SCRIPT_SRC=src/setup-scripts
ARG SCRIPT_DEST=/opt/setup-scripts

# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

# Install all OS dependencies for Server that starts but lacks all
# features (e.g., download as all possible file formats)
RUN microdnf install -y $BASE_PKGS && \
    microdnf clean all

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID

# Add R mimetype option to specify how the plot returns from R to the browser
COPY --chown=$NB_UID:$NB_GID --chmod=644 $CONF_SRC $CONF_DEST

# Add setup scripts that may be used by downstream images or inherited images
COPY --chown=0:0 --chmod=755 $SCRIPT_SRC $SCRIPT_DEST
