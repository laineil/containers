[![Docker Pulls](https://img.shields.io/docker/pulls/laineil/jupyter-scipy-notebook)](https://hub.docker.com/r/laineil/jupyter-scipy-notebook) [![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/laineil/jupyter-scipy-notebook?sort=date)](https://hub.docker.com/r/laineil/jupyter-scipy-notebook/tags) [![Docker Image Version (latest by date)](https://img.shields.io/docker/v/laineil/jupyter-scipy-notebook?sort=date)](https://hub.docker.com/r/laineil/jupyter-scipy-notebook/tags) ![Static Badge](https://img.shields.io/badge/python-3.10%20%7C%203.11-blue) ![Static Badge](https://img.shields.io/badge/cuda-11.8%20%7C%2012.2-blue) ![Static Badge](https://img.shields.io/badge/arch-x86__64%20%7C%20arm64%20%7C%20ppc64le-blue) ![GitHub](https://img.shields.io/github/license/laineil/containers)

## About Jupyter Notebook Scientific Python Stack

GitHub Actions in the [laineil/containers/app/jupyter](https://github.com/laineil/containers/tree/main/app/jupyter) project builds and pushes this image to Docker Hub.

Please visit the project documentation site for help to use and contribute to this image and others.

- [Jupyter Docker Stacks on ReadTheDocs](https://jupyter-docker-stacks.readthedocs.io/en/latest/index.html)
- [Selecting an Image :: Core Stacks :: jupyter/scipy-notebook](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html#jupyter-scipy-notebook)

## Image information

- The use of **non-root container images** can enhance system security.
- A modified edition of the Dockerfile based on [jupyter/docker-stacks/scipy-notebook](https://github.com/jupyter/docker-stacks/blob/main/images/scipy-notebook/Dockerfile).
- Subscribe to project updates by watching the [laineil/containers GitHub repo](https://github.com/laineil/containers) for more information.

## Run a container

- Run without GPU

```bash
$ docker run -d \
--name jupyter_scipy \
-p [expose_port]:8888 \
laineil/jupyter-scipy-notebook:[tag]
```

- Run with GPU

```bash
$ docker run -d \
--name jupyter_scipy \
--gpus [number_of_GPUs] \
-p [expose_port]:8888 \
laineil/jupyter-scipy-notebook:[tag]
```

- Run sudo within container

```bash
$ docker run -d \
--name jupyter_scipy \
-p [expose_port]:8888 \
--user root \
-e GRANT_SUDO=yes \
laineil/jupyter-scipy-notebook:[tag]
```

## Logging

```bash
$ docker logs jupyter_scipy
```

- **Tip**: A token for login is generated at startup.

## Verify

- http://[server_host]:[expose_port]/lab?=token=[generate_token]

## Remove

- Stop container

```bash
$ docker container stop jupyter_scipy
```

- Remove container

```bash
$ docker container rm jupyter_scipy
```

## License Agreement

BSD 3-Clause License  
Copyright (c) 2023, Laineil  
All rights reserved.
