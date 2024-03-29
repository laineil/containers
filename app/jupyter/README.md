![Static Badge](https://img.shields.io/badge/python-3.10%20%7C%203.11-blue) ![Static Badge](https://img.shields.io/badge/cuda-11%20%7C%2012-blue) ![Static Badge](https://img.shields.io/badge/arch-x86__64%20%7C%20arm64%20%7C%20ppc64le-blue) ![GitHub](https://img.shields.io/github/license/laineil/containers)

## About Jupyter Docker Stacks

Jupyter Docker Stacks are a set of ready-to-run **docker images** 

containing Jupyter applications and interactive computing tools.

You can use a stack image to do any of the following (and more):

- Start a personal Jupyter Server with the JupyterLab frontend (default)
- Run JupyterLab for a team using JupyterHub
- Start a personal Jupyter Server with the Jupyter Notebook frontend in a local Docker container
- Write your own project Dockerfile

GitHub Actions in the [laineil/containers/app/jupyter](https://github.com/laineil/containers/tree/main/app/jupyter) project builds and pushes this image to Docker Hub.

Please visit the project documentation site for help to use and contribute to this image and others.

- Jupyter project documentation [Jupyter Docker Stacks on ReadTheDocs](https://jupyter-docker-stacks.readthedocs.io/en/latest/index.html)

## Image information

- The use of **non-root container images** can enhance system security.
- Support the **TZ** environment variable to set up the desired timezone. (see [Services top-level element](https://docs.docker.com/compose/compose-file/05-services/))
- A modified edition of the Dockerfile based on [jupyter/docker-stacks](https://github.com/jupyter/docker-stacks).
- Subscribe to project updates by watching the [laineil/containers GitHub repo](https://github.com/laineil/containers) for more information.

## Image Relationships

![image_relationships](https://github.com/laineil/containers/blob/main/app/jupyter/image_relationships.png) 

## License Agreement

BSD 3-Clause License  
Copyright (c) 2023, Laineil  
All rights reserved.

