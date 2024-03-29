[![Docker Pulls](https://img.shields.io/docker/pulls/laineil/mlflow-server)](https://hub.docker.com/r/laineil/mlflow-server) [![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/laineil/mlflow-server?sort=date)](https://hub.docker.com/r/laineil/mlflow-server/tags) [![Docker Image Version (latest by date)](https://img.shields.io/docker/v/laineil/mlflow-server?sort=date)](https://hub.docker.com/r/laineil/mlflow-server/tags) ![Static Badge](https://img.shields.io/badge/python-3.10%20%7C%203.11-blue) ![Static Badge](https://img.shields.io/badge/arch-x86__64%20%7C%20arm64%20%7C%20ppc64le-blue) ![GitHub](https://img.shields.io/github/license/laineil/containers)

## About MLflow Server

GitHub Actions in the [laineil/containers/app/pysvc](https://github.com/laineil/containers/tree/main/app/pysvc) project builds and pushes this image to Docker Hub.

Please visit the project documentation site for help to use and contribute to this image and others.

- [MLflow Official Website](https://mlflow.org/)
- [MLflow Documentation](https://mlflow.org/docs/latest/index.html)
- [MLflow Github](https://github.com/mlflow/mlflow)
- [MLflow Tracking](https://mlflow.org/docs/latest/tracking.html)
- [MLflow Server](https://www.mlflow.org/docs/latest/cli.html#mlflow-server)

## Image information

- The use of **non-root container images** can enhance system security.
- Support the **TZ** environment variable to set up the desired timezone (see [Services top-level element](https://docs.docker.com/compose/compose-file/05-services/)).
- Subscribe to project updates by watching the [laineil/containers GitHub repo](https://github.com/laineil/containers) for more information.

## Configuration

The container can be easily setup with the following environment variables:

- `MLF_BACKEND_STORE_UIR`: URI to which to persist experiment and run data. Acceptable URIs are SQLAlchemy-compatible database connection strings (e.g. 'sqlite:///path/to/file.db') or local filesystem URIs (e.g. 'file:///absolute/path/to/directory'). Default: **sqlite:////volume/mlflow/mlflow.db**
- `MLF_WORKERS`: Number of gunicorn worker processes to handle requests. Default: **1**
- `MLF_ARTIFACT_ROOT`: Whether to enable `--default-artifact-root <URI>` or not. Default: **disable** (enable)
- `MLF_DEFAULT_ARTIFACT_ROOT`: If MLF_ARTIFACT_ROOT is enabled, it will take effect. Directory in which to store artifacts for any new experiments created. For tracking server backends that rely on SQL, this option is required in order to store artifacts. Note that this flag does not impact already-created experiments with any previous configuration of an MLflow server instance. Default: **none**
- `MLF_PROMETHEUS`: Whether to enable `--expose-prometheus <expose_prometheus>` or not. Default: **disable** (enable)
- `MLF_EXPORSE_PROMETHEUS`: If MLF_PROMETHEUS is enabled, it will take effect. Specify the path to the directory where metrics will be stored. If the directory doesn't exist, it will be created. Default: **/volume/mlflow/metrics**
- `MLF_AUTH`: Basic HTTP authentication to enable access control over experiments and registered models (see [MLflow Authentication](https://mlflow.org/docs/latest/auth/index.html)). Default: **disable**
- `MLF_APP_NAME`: This value is required if MLF_AUTH is enabled (see [MLflow Authentication Overview](https://mlflow.org/docs/latest/auth/index.html#overview)). Default: **basic-auth**
- `MLF_DEBUG`: Whether to enable debug mode or not. Default: **disable** (enable)

## Run a container

- Quick start (Recommended)

```bash
$ docker run -it \
--name mlflow_server \
-v mlflow_volume:/volume/mlflow \
-p [expose_port]:5000 \
laineil/mlflow-server:[tag]
```

- With http Authentication

```bash
$ docker run -it \
--name mlflow_server \
-v mlflow_volume:/volume/mlflow \
-p [expose_port]:5000 \
-e MLF_AUTH=enable \
laineil/mlflow-server:[tag]
```

## Verify

- http://[server_host]:[expose_port]

## Logging

```bash
$ docker logs mlflow_server
```

## Remove

- Stop container

```bash
$ docker container stop mlflow_server
```

- Remove container

```bash
$ docker container rm mlflow_server
```

- Remove volume

```bash
$ docker volume rm mlflow_volume
```

## License Agreement

BSD 3-Clause License  
Copyright (c) 2023, Laineil  
All rights reserved.
