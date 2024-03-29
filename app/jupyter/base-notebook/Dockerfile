# BSD 3-Clause License
# Copyright (c) 2023, Laineil
# All rights reserved.

FROM laineil/jupyter-docker-stacks-foundation:latest

# https://yum-info.contradodigital.com/view-package/base/liberation-fonts-common/
#   it's not present in the aarch64 Ubuntu image, so we install it here pandoc
# util-linux is needed for the 'flock' command, which 'run-one' requires.
# - run-one - a wrapper script that runs no more
#   than one unique  instance  of  some  command with a unique set of arguments,
#   we use `run-one-constantly` to support the `RESTARTABLE` option
ARG TARGETARCH
ARG BASE_PKGS="liberation-fonts util-linux"
ARG SCRIPT_SRC=src/script
ARG SCRIPT_DEST=/usr/local/bin
ARG CONF_SRC=src/conf
ARG CONF_DEST=/etc/jupyter

ENV JUPYTER_PORT=8888

# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Copy local files as late as possible to avoid cache busting
COPY --chown=0:0 --chmod=755 ${SCRIPT_SRC} ${SCRIPT_DEST}
COPY --chown=0:100 ${CONF_SRC} ${CONF_DEST}

USER root

# Install all OS dependencies for the Server that starts but lacks all
# features (e.g., download as all possible file formats)
RUN microdnf install -y ${BASE_PKGS} && \
    microdnf clean all

USER ${NB_UID}

WORKDIR /tmp

# Install JupyterLab, Jupyter Notebook, JupyterHub and NBClassic
# Generate a Jupyter Server config
# Cleanup temporary files
# Correct permissions
# Do all this in a single RUN command to avoid duplicating all of the
# files across image layers when the permissions change
# - pandoc is used to convert notebooks to html and latex files
# mamba installed jupyterhub includes pandoc dependency(except for ppc64le).
RUN set -x && \
    mamba install -qy \
    jupyterlab \
    notebook \
    jupyterhub \
    nbclassic && \
    if [[ ${TARGETARCH} == "ppc64le" ]]; then \
        mamba install -qy -c anaconda pandoc; \
        # fix pandoc: error while loading shared libraries: libffi.so.7: cannot open shared object file: No such file or directory
        ln -s /opt/conda/lib/libffi.so.8 /opt/conda/lib/libffi.so.7; \
    fi && \
    jupyter server --generate-config && \
    # Disable news notifications
    #jupyter labextension disable "@jupyterlab/apputils-extension:announcements" && \
    mamba clean -afy && \
    npm cache clean --force && \
    jupyter lab clean && \
    rm -rf "/home/${NB_USER}/.cache/yarn" && \
    fix-permissions ${CONDA_DIR} && \
    fix-permissions ${HOME}

USER root

# Fix permissions on /etc/jupyter as root
RUN fix-permissions /etc/jupyter/

# HEALTHCHECK documentation: https://docs.docker.com/engine/reference/builder/#healthcheck
# This healtcheck works well for `lab`, `notebook`, `nbclassic`, `server`, and `retro` jupyter commands
# https://github.com/jupyter/docker-stacks/issues/915#issuecomment-1068528799
HEALTHCHECK --interval=5s --timeout=3s --start-period=5s --retries=3 \
    CMD /etc/jupyter/docker_healthcheck.py || exit 1

# Switch back to jovyan to avoid accidental container runs as root
USER ${NB_UID}

WORKDIR ${HOME}

EXPOSE ${JUPYTER_PORT}

# Configure container startup
CMD ["start-notebook.py"]
