![Static Badge](https://img.shields.io/badge/python-3.10%20%7C%203.11-blue) ![Static Badge](https://img.shields.io/badge/cuda-11.8%20%7C%2012.2-blue) ![Static Badge](https://img.shields.io/badge/arch-x86__64%20%7C%20arm64%20%7C%20ppc64le-blue) ![GitHub](https://img.shields.io/github/license/laineil/containers)

## About PySVC Docker Stacks

Pysvc provides a set of ready-to-run **docker images** for **Python Services**.

You can use a stack image to do any of the following (and more):

- Miniforge
- Flask
- MLflow

GitHub Actions in the [laineil/containers/app/pysvc](https://github.com/laineil/containers/tree/main/app/pysvc) project builds and pushes this image to Docker Hub.

## Image information

- The use of **non-root container images** can enhance system security.
- Support the **TZ** environment variable to set up the desired timezone (see [Services top-level element](https://docs.docker.com/compose/compose-file/05-services/)).
- Subscribe to project updates by watching the [laineil/containers GitHub repo](https://github.com/laineil/containers) for more information.

## Image Relationships

![image_relationships](https://github.com/laineil/containers/blob/main/app/pysvc/image_relationships.png) 

## License Agreement

BSD 3-Clause License  
Copyright (c) 2023, Laineil  
All rights reserved.

