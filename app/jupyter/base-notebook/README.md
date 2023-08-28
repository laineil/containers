[![Docker Pulls](https://img.shields.io/docker/pulls/laineil/jupyter-base-notebook)](https://hub.docker.com/r/laineil/jupyter-base-notebook) [![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/laineil/jupyter-base-notebook?sort=date)](https://hub.docker.com/r/laineil/jupyter-base-notebook/tags) [![Docker Image Version (latest by date)](https://img.shields.io/docker/v/laineil/jupyter-base-notebook?sort=date)](https://hub.docker.com/r/laineil/jupyter-base-notebook/tags) ![Static Badge](https://img.shields.io/badge/python-3.10%20%7C%203.11-blue) ![Static Badge](https://img.shields.io/badge/cuda-11.8%20%7C%2012.2-blue) ![Static Badge](https://img.shields.io/badge/arch-x86__64%20%7C%20arm64%20%7C%20ppc64le-blue) ![GitHub](https://img.shields.io/github/license/laineil/containers)

## About Jupyter Notebook Stack

GitHub Actions in the [laineil/containers/app/jupyter](https://github.com/laineil/containers/tree/main/app/jupyter) project builds and pushes this image to Docker Hub.

Please visit the project documentation site for help to use and contribute to this image and others.

- [Jupyter Docker Stacks on ReadTheDocs](https://jupyter-docker-stacks.readthedocs.io/en/latest/index.html)
- [Selecting an Image :: Core Stacks :: jupyter/base-notebook](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html#jupyter-base-notebook)

## Image information

- The use of **non-root container images** can enhance system security.
- A modified edition of the Dockerfile based on [jupyter/docker-stacks/base-notebook](https://github.com/jupyter/docker-stacks/tree/main/base-notebook).
- Subscribe to project updates by watching the [laineil/containers GitHub repo](https://github.com/laineil/containers) for more information.

## Run a container

- Run without GPU

```bash
$ docker run -d \
--name jupyter_base \
-p [expose_port]:8888 \
laineil/jupyter-base-notebook:[tag]
```

- Run with GPU

```bash
$ docker run -d \
--name jupyter_base \
--gpus [number_of_GPUs] \
-p [expose_port]:8888 \
laineil/jupyter-base-notebook:[tag]
```

- Run sudo within container

```bash
$ docker run -d \
--name jupyter_base \
-p [expose_port]:8888 \
--user root \
-e GRANT_SUDO=yes \
laineil/jupyter-base-notebook:[tag]
```

## Logging

```bash
$ docker logs jupyter_base
```

- **Tip**: A token for login is generated at startup.

## Verify

- http://[server_host]:[expose_port]/lab?=token=[generate_token]

## Remove

- Stop container

```bash
$ docker container stop jupyter_base
```

- Remove container

```bash
$ docker container rm jupyter_base
```

## License Agreement

BSD 3-Clause License  
Copyright (c) 2023, Laineil  
All rights reserved.
