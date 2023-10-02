[![Docker Pulls](https://img.shields.io/docker/pulls/laineil/jupyterhub)](https://hub.docker.com/r/laineil/jupyterhub) [![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/laineil/jupyterhub?sort=date)](https://hub.docker.com/r/laineil/jupyterhub/tags) [![Docker Image Version (latest by date)](https://img.shields.io/docker/v/laineil/jupyterhub?sort=date)](https://hub.docker.com/r/laineil/jupyterhub/tags) ![Static Badge](https://img.shields.io/badge/python-3.10%20%7C%203.11-blue) ![Static Badge](https://img.shields.io/badge/arch-x86__64%20%7C%20arm64%20%7C%20ppc64le-blue) ![GitHub](https://img.shields.io/github/license/laineil/containers)

## About JupyterHub

With [JupyterHub](https://jupyterhub.readthedocs.io/) you can create a **multi-user Hub** that spawns, manages, and proxies multiple instances of the single-user [Jupyter notebook](https://jupyter-notebook.readthedocs.io/) server.

[Project Jupyter](https://jupyter.org/) created JupyterHub to support many users. The Hub can offer notebook servers to a class of students, a corporate data science workgroup, a scientific research project, or a high-performance computing group.

## Image information

- Support the **TZ** environment variable to set up the desired timezone (see [Services top-level element](https://docs.docker.com/compose/compose-file/05-services/)).
- A modified edition of the Dockerfile based on [jupyterhub/jupyterhub](https://github.com/jupyterhub/jupyterhub).
- Subscribe to project updates by watching the [laineil/containers GitHub repo](https://github.com/laineil/containers) for more information.

## Run a container

```bash
$ docker run -d \
--name jupyterhub_app \
-p [expose_port]:8000 \
laineil/jupyterhub:[tag]
```

## Verify

- http://[server_host]:[expose_port]

## Logging

```bash
$ docker logs jupyterhub_app
```

## Remove

- Stop container

```bash
$ docker container stop jupyterhub_app
```

- Remove container

```bash
$ docker container rm jupyterhub_app
```

## License Agreement

BSD 3-Clause License  
Copyright (c) 2023, Laineil  
All rights reserved.
