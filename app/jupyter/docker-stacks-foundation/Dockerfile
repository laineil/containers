# BSD 3-Clause License
# Copyright (c) 2023, Laineil
# All rights reserved.

FROM almalinux:8-minimal

ARG TIMEZONE=Asia/Taipei
ARG BASE_PKGS="glibc-langpack-en shadow-utils findutils sudo coreutils-common"
ARG CONDA_BIN=Minforge.sh
ARG SCRIPT_SRC=src/script
ARG SCRIPT_DEST=/usr/local/bin

ENV CONDA_DIR=/opt/conda
ENV SHELL=/bin/bash
ENV NB_USER=jovyan
ENV NB_UID=1000
ENV NB_GID=100
ENV HOME=/home/$NB_USER
ENV LANG=en_US.UTF-8
ENV PATH=$CONDA_DIR/bin:$SCRIPT_DEST:$PATH

# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

COPY --chown=0:0 --chmod=755 $SCRIPT_SRC/ $SCRIPT_DEST/

RUN unlink /etc/localtime && \
    ln -s /usr/share/zoneinfo/$TIMEZONE /etc/localtime && \
    # enable prompt color in the skeleton .bashrc before creating the default NB_USER
    echo "PS1='\[\033[1;30m\][\[\033[01;32m\]\u@\h\[\033[1;30m\]:\[\033[01;34m\]\w\[\033[1;30m\]]\[\033[00m\]\\$ '" >> /etc/skel/.bashrc && \
    # Add call to conda init script see https://stackoverflow.com/a/58081608/4413446
    echo 'eval "$(command conda shell.bash hook 2> /dev/null)"' >> /etc/skel/.bashrc && \
    microdnf install -y $BASE_PKGS && \
    rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && \
    microdnf install -y tini && \
    # uncomment to fix vulnerability
    #microdnf update -y && \
    microdnf clean all && \
    # Create NB_USER with name jovyan user with UID=1000 and in the 'users' group
    # and make sure these dirs are writable by the `users` group.
    useradd $NB_USER -u $NB_UID -g $NB_GID && \
    mkdir -p $CONDA_DIR /usr/local/bin/start-notebook.d /usr/local/bin/before-notebook.d && \
    chown $NB_USER:$NB_GID $CONDA_DIR && \
    #chmod g+w /etc/passwd && \
    fix-permissions $CONDA_DIR && \
    fix-permissions $HOME

USER $NB_UID

WORKDIR $HOME

RUN set -x && \
    # Setup work directory for backward-compatibility
    mkdir /home/$NB_USER/work && \
    # download the latest miniforge
    curl -L https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-$(uname -m).sh -o $CONDA_BIN && \
    bash $CONDA_BIN -bfp $CONDA_DIR && \
    # remove the miniforge installation binary
    rm -f $CONDA_BIN && \
    conda config --system --set auto_update_conda false && \
    conda config --system --set show_channel_urls true && \
    mamba list python | grep '^python ' | tr -s ' ' | cut -d ' ' -f 1,2 >> "$CONDA_DIR/conda-meta/pinned" && \
    mamba install -qy \
    jupyter_core && \
    # clean up temporary conda files
    mamba clean -afy && \
    # correct permissions
    fix-permissions $CONDA_DIR && \
    fix-permissions $HOME

# Configure container startup
ENTRYPOINT ["tini", "-g", "--"]
CMD ["start.sh"]
