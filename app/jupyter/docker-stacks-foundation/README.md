[![Docker Pulls](https://img.shields.io/docker/pulls/laineil/jupyter-docker-stacks-foundation)](https://hub.docker.com/r/laineil/jupyter-docker-stacks-foundation) [![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/laineil/jupyter-docker-stacks-foundation?sort=date)](https://hub.docker.com/r/laineil/jupyter-docker-stacks-foundation/tags) [![Docker Image Version (latest by date)](https://img.shields.io/docker/v/laineil/jupyter-docker-stacks-foundation?sort=date)](https://hub.docker.com/r/laineil/jupyter-docker-stacks-foundation/tags)

## About Foundation Jupyter Stack

GitHub Actions in the [laineil/containers/app/jupyter](https://github.com/laineil/containers/tree/main/app/jupyter) project builds and pushes this image to Docker Hub.

Please visit the project documentation site for help to use and contribute to this image and others.

- [Jupyter Docker Stacks on ReadTheDocs](https://jupyter-docker-stacks.readthedocs.io/en/latest/index.html)
- [Selecting an Image :: Core Stacks :: jupyter/docker-stacks-foundation](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html#jupyter-docker-stacks-foundation)

## Image information

- The use of **non-root container images** can enhance system security.
- A modified edition of the Dockerfile based on [jupyter/docker-stacks/docker-stacks-foundation](https://github.com/jupyter/docker-stacks/tree/main/docker-stacks-foundation).
- Subscribe to project updates by watching the [laineil/containers GitHub repo](https://github.com/laineil/containers) for more information.

## Run a container

- Run without GPU

```bash
$ docker run -it \
--name jupyter_fondation \
laineil/jupyter-docker-stacks-foundation:[tag]
```

- Run with GPU

```bash
$ docker run -it \
--gpus [# of GPU] \
--name jupyter_fondation \
laineil/jupyter-docker-stacks-foundation:[tag]
```

## Logging

```bash
$ docker logs jupyter_fondation
```

## Remove

- Stop container

```bash
$ docker container stop jupyter_fondation
```

- Remove container

```bash
$ docker container rm jupyter_fondation
```

## License Agreement

BSD 3-Clause License  
Copyright (c) 2023, Laineil  
All rights reserved.