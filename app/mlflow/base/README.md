[![Docker Pulls](https://img.shields.io/docker/pulls/laineil/mlflow-base)](https://hub.docker.com/r/laineil/mlflow-base) [![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/laineil/mlflow-base?sort=date)](https://hub.docker.com/r/laineil/mlflow-base/tags) [![Docker Image Version (latest by date)](https://img.shields.io/docker/v/laineil/mlflow-base?sort=date)](https://hub.docker.com/r/laineil/mlflow-base/tags) ![Static Badge](https://img.shields.io/badge/python-3.10%20%7C%203.11-blue) ![Static Badge](https://img.shields.io/badge/arch-x86__64%20%7C%20arm64%20%7C%20ppc64le-blue) ![GitHub](https://img.shields.io/github/license/laineil/containers)

## About MLflow Base

GitHub Actions in the [laineil/containers/app/mlflow](https://github.com/laineil/containers/tree/main/app/mlflow) project builds and pushes this image to Docker Hub.

Please visit the project documentation site for help to use and contribute to this image and others.

- [MLflow Official Website](https://mlflow.org/)
- [MLflow Documentation](https://mlflow.org/docs/latest/index.html)
- [MLflow Github](https://github.com/mlflow/mlflow)

## Image information

- The use of **non-root container images** can enhance system security.
- Base images for the [laineil/containers/app/mlflow](https://github.com/laineil/containers/tree/main/app/mlflow) project.
- Subscribe to project updates by watching the [laineil/containers GitHub repo](https://github.com/laineil/containers) for more information.

## Run a container

- Quick start (Recommended)

```bash
$ docker run -it \
--name mlflow_base \
laineil/mlflow-base:[tag]
```

## Logging

```bash
$ docker logs mlflow_base
```

## Remove

- Stop container

```bash
$ docker container stop mlflow_base
```

- Remove container

```bash
$ docker container rm mlflow_base
```

## License Agreement

BSD 3-Clause License  
Copyright (c) 2023, Laineil  
All rights reserved.
