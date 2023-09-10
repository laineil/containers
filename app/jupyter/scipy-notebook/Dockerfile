# BSD 3-Clause License
# Copyright (c) 2023, Laineil
# All rights reserved.

FROM laineil/jupyter-minimal-notebook:latest

# To check if the arch is ppc64le
ARG TARGETARCH
# for cython: https://cython.readthedocs.io/en/latest/src/quickstart/install.html
# for latex labels
ARG RPMFUSION_RPM="https://download1.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm"
ARG BASE_PKGS="gcc gcc-c++ kernel-devel make texlive-cm-super texlive-dvipng ffmpeg"
# jupyterlab-git does not currently support JupyterLab v4.x.x, but support v3.x.x
ARG CONDA_BASE_PKGS="altair beautifulsoup4 bokeh bottleneck cloudpickle conda-forge::blas=*=openblas cython dask dill h5py ipympl ipywidgets matplotlib-base numba numexpr openpyxl pandas patsy protobuf pytables scikit-image scikit-learn scipy sqlalchemy sympy widgetsnbextension xlrd"
ARG CONDA_DIFF_PKGS="seaborn statsmodels"

# Import matplotlib the first time to build the font cache.
ENV XDG_CACHE_HOME=/home/$NB_USER/.cache/

# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

# Install all OS dependencies for Server that starts but lacks all
# features (e.g., download as all possible file formats)
RUN rpm -ivh $RPMFUSION_RPM && \
    sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/almalinux-powertools.repo && \
    microdnf install -y $BASE_PKGS && \
    microdnf clean all

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID

WORKDIR /tmp

# mamba downgrades these packages to previous major versions, which causes issues
# jupyterlab-git does not currently support JupyterLab v4.x.x, but support v3.x.x
# Install facets which does not have a pip or conda package at the moment
RUN echo "jupyterlab >=$(jupyter-lab --version)" >> "$CONDA_DIR/conda-meta/pinned" && \
    echo "notebook >=$(jupyter-notebook --version)" >> "$CONDA_DIR/conda-meta/pinned" && \
    if [[ $TARGETARCH == "ppc64le" ]]; then \
        mamba install -qy $CONDA_BASE_PKGS; \
        mamba install -qy -c anaconda $CONDA_DIFF_PKGS; \
    else \
        mamba install -qy $CONDA_BASE_PKGS $CONDA_DIFF_PKGS; \
    fi && \
    mamba clean -afy && \
    git clone https://github.com/PAIR-code/facets && \
    jupyter nbclassic-extension install facets/facets-dist/ --sys-prefix && \
    rm -rf /tmp/facets && \
    MPLBACKEND=Agg python -c "import matplotlib.pyplot" && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

WORKDIR $HOME
