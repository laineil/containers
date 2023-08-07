# BSD 3-Clause License
# Copyright (c) 2023, Laineil
# All rights reserved.

FROM almalinux:8-minimal

ARG TIMEZONE=Asia/Taipei
ARG BASE_PKGS="glibc-langpack-en shadow-utils findutils"
ARG EPEL_RPM="https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm"
ARG APP_PKGS="tini"
ARG CONDA_BIN=Miniconda.sh
ARG SCRIPT_SRC=src/script
ARG CONF_SRC=src/conf/initial-condarc
ARG SCRIPT_DEST=/opt/script

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
    fix-permissions $HOME

USER $NB_UID

WORKDIR $HOME

COPY --chown=$NB_UID:$NB_GID $CONF_SRC $CONDA_DIR/.condarc

RUN set -x && \
    # Setup work directory for backward-compatibility
    mkdir /home/$NB_USER/work && \
    # download and install miniconda
    curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-`uname -m`.sh -o $CONDA_BIN && \
    bash $CONDA_BIN -b -f -p $CONDA_DIR && \
    # remove the miniconda installation binary
    rm -f $CONDA_BIN && \
    conda list python | grep '^python ' | tr -s ' ' | cut -d ' ' -f 1,2 >> "$CONDA_DIR/conda-meta/pinned" && \
    conda install -qy jupyter_core && \
    # clean up temporary conda files
    conda clean -ay && \
    # correct permissions
    fix-permissions /home/$NB_USER && \
    fix-permissions $CONDA_DIR

# Configure container startup
ENTRYPOINT ["tini", "-g", "--"]
CMD ["start.sh"]
