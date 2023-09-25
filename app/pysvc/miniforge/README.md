[![Docker Pulls](https://img.shields.io/docker/pulls/laineil/miniforge)](https://hub.docker.com/r/laineil/miniforge) [![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/laineil/miniforge?sort=date)](https://hub.docker.com/r/laineil/miniforge/tags) [![Docker Image Version (latest by date)](https://img.shields.io/docker/v/laineil/miniforge?sort=date)](https://hub.docker.com/r/laineil/miniforge/tags) ![Static Badge](https://img.shields.io/badge/python-3.10%20%7C%203.11-blue) ![Static Badge](https://img.shields.io/badge/arch-x86__64%20%7C%20arm64%20%7C%20ppc64le-blue) ![GitHub](https://img.shields.io/github/license/laineil/containers)

## About Miniforge

GitHub Actions in the [laineil/containers/app/pysvc](https://github.com/laineil/containers/tree/main/app/pysvc) project builds and pushes this image to Docker Hub.

Miniforge is a minimal installer for [Conda](https://conda.io/) specific to [conda-forge](https://conda-forge.org/).

It allows you to install the conda package manager with the following features pre-configured:

- **conda-forge** set as the default (and only) channel.
  - Packages in the base environment are obtained from the [conda-forge channel](https://anaconda.org/conda-forge).
- Optional support for [Mamba](https://github.com/mamba-org/mamba) in place of Conda.

It can be compared to the [Miniconda](https://docs.conda.io/en/latest/miniconda.html) installer.

## Image information

- The use of **non-root container images** can enhance system security.
- Subscribe to project updates by watching the [laineil/containers GitHub repo](https://github.com/laineil/containers) for more information.

## Run a container

- Quick start (Recommended)

```bash
$ docker run -it \
--name mamba_app \
laineil/miniforge:[tag]
```

## Logging

```bash
$ docker logs mamba_app
```

## Remove

- Stop container

```bash
$ docker container stop mamba_app
```

- Remove container

```bash
$ docker container rm mamba_app
```

## License Agreement

BSD 3-Clause License  
Copyright (c) 2023, Laineil  
All rights reserved.
