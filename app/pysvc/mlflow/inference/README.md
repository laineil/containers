[![Docker Pulls](https://img.shields.io/docker/pulls/laineil/mlflow-inference)](https://hub.docker.com/r/laineil/mlflow-inference) [![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/laineil/mlflow-inference?sort=date)](https://hub.docker.com/r/laineil/mlflow-inference/tags) [![Docker Image Version (latest by date)](https://img.shields.io/docker/v/laineil/mlflow-inference?sort=date)](https://hub.docker.com/r/laineil/mlflow-inference/tags) ![Static Badge](https://img.shields.io/badge/python-3.10%20%7C%203.11-blue) ![Static Badge](https://img.shields.io/badge/arch-x86__64%20%7C%20arm64%20%7C%20ppc64le-blue) ![GitHub](https://img.shields.io/github/license/laineil/containers)

## About MLflow Inference

GitHub Actions in the [laineil/containers/app/pysvc](https://github.com/laineil/containers/tree/main/app/pysvc) project builds and pushes this image to Docker Hub.

Please visit the project documentation site for help to use and contribute to this image and others.

- [MLflow Official Website](https://mlflow.org/)
- [MLflow Documentation](https://mlflow.org/docs/latest/index.html)
- [MLflow Github](https://github.com/mlflow/mlflow)
- [MLflow Model (models serve)](https://mlflow.org/docs/latest/models.html)

## Image information

- The use of **non-root container images** can enhance system security.
- Support the **TZ** environment variable to set up the desired timezone (see [Services top-level element](https://docs.docker.com/compose/compose-file/05-services/)).
- Subscribe to project updates by watching the [laineil/containers GitHub repo](https://github.com/laineil/containers) for more information.

## Configuration

The container can be easily setup with the following environment variables:

- `MLF_WORKERS`: Number of gunicorn worker processes to handle requests. Default: **1**
- `MLF_EX_MODEL`: Whether to enable mlflow example model (see [mlflow-example](https://github.com/mlflow/mlflow-example)) or not. Default: **enable** (disable)
- `MLF_MODEL_URI`: Set up the model URI (see [Storage Format](https://mlflow.org/docs/latest/models.html#storage-format)). Default: **exmodel**
  - tip: `MLF_EX_MODEL`=enable <=> `MLF_MODEL_URL`=exmodel

## Run a container

- Quick start

```bash
$ docker run -it \
--name mlflow_infrence \
-p [expose_port]:5000 \
laineil/mlflow-inference:[tag]
```

- Recommended example

```bash
$ docker run -it \
--name mlflow_infrence \
-v [model_uri_path]:/volume/mlflow/[model_uri] \
-p [expose_port]:5000 \
-e MLF_EX_MODEL=disable \
-e MLF_MODEL_URI=[model_uri] \
laineil/mlflow-inference:[tag]
```

## Verify

- Use curl to test

```bash
$ curl -X POST http://localhost:5001/invocations -H "Content-Type:application/json" -d '{"dataframe_split": {"columns":["fixed acidity", "volatile acidity", "citric acid", "residual sugar", "chlorides", "free sulfur dioxide", "total sulfur dioxide", "density", "pH", "sulphates", "alcohol"],"data":[[6.2, 0.66, 0.48, 1.2, 0.029, 29, 75, 0.98, 3.33, 0.39, 12.8]]}}'
```

- Result

```bash
{"predictions": [6.142794103046581]}
```

## Logging

```bash
$ docker logs mlflow_infrence
```

## Remove

- Stop container

```bash
$ docker container stop mlflow_infrence
```

- Remove container

```bash
$ docker container rm mlflow_infrence
```

- Remove volume

```bash
$ docker volume rm mlflow_infrence
```

## License Agreement

BSD 3-Clause License  
Copyright (c) 2023, Laineil  
All rights reserved.
