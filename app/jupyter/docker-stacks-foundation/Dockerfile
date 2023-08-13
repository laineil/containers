# BSD 3-Clause License
# Copyright (c) 2023, Laineil
# All rights reserved.

FROM almalinux:8-minimal

ARG TIMEZONE=Asia/Taipei
ARG BASE_PKGS="glibc-langpack-en shadow-utils findutils sudo"
ARG EPEL_RPM="https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm"
ARG APP_PKGS="tini"
ARG CONDA_BIN=Minforge.sh
ARG SCRIPT_SRC=src/script
ARG SCRIPT_DEST=/usr/local/bin

ENV CONDA_DIR=/opt/conda
ENV NB_USER=jovyan
ENV NB_UID=1000
ENV NB_GID=100
ENV HOME=/home/$NB_USER
ENV LANG=en_US.UTF-8
ENV PATH=$CONDA_DIR/bin:$SCRIPT_DEST:$PATH

USER root

COPY --chown=0:0 --chmod=755 $SCRIPT_SRC/ $SCRIPT_DEST/

RUN unlink /etc/localtime && \
    ln -s /usr/share/zoneinfo/$TIMEZONE /etc/localtime && \
    # enable prompt color in the skeleton .bashrc before creating the default NB_USER
    echo "alias ls='ls --color=auto'" >> /etc/skel/.bashrc && \
    echo "alias ll='ls -l --color=auto'" >> /etc/skel/.bashrc && \
    # Add call to conda init script see https://stackoverflow.com/a/58081608/4413446
    echo 'eval "$(command conda shell.bash hook 2> /dev/null)"' >> /etc/skel/.bashrc && \
    microdnf install -y $BASE_PKGS && \
    rpm -ivh $EPEL_RPM && \
    microdnf install -y $APP_PKGS && \
    microdnf clean all && \
    # Create NB_USER with name jovyan user with UID=1000 and in the 'users' group
    # and make sure these dirs are writable by the `users` group.
    useradd $NB_USER -u $NB_UID -g $NB_GID && \
    mkdir -p $CONDA_DIR && \
    chown $NB_USER:$NB_GID $CONDA_DIR && \
    fix-permissions $CONDA_DIR && \
    fix-permissions $HOME

USER $NB_UID

WORKDIR $HOME

RUN set -x && \
    # Setup work directory for backward-compatibility
    mkdir /home/$NB_USER/work && \
    # download the latest miniforge
    curl -L https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-`uname -m`.sh -o $CONDA_BIN && \
    bash $CONDA_BIN -bfp $CONDA_DIR && \
    # remove the miniforge installation binary
    rm -f $CONDA_BIN && \
    conda config --system --set auto_update_conda false && \
    conda config --system --set show_channel_urls true && \
    conda install -qy \
    mamba \
    jupyter_core && \
    mamba list python | grep '^python ' | tr -s ' ' | cut -d ' ' -f 1,2 >> "$CONDA_DIR/conda-meta/pinned" && \
    # clean up temporary conda files
    mamba clean -afy && \
    # correct permissions
    fix-permissions $CONDA_DIR && \
    fix-permissions $HOME

# Configure container startup
ENTRYPOINT ["tini", "-g", "--"]
CMD ["start.sh"]
