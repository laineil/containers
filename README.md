![Static Badge](https://img.shields.io/badge/arch-x86__64%20%7C%20arm64%20%7C%20ppc64le-blue) ![GitHub](https://img.shields.io/github/license/laineil/containers)

# Containers Library from Laineil

Some applications containerized and ready to launch, provided by Laineil.

## Image information

Some key tips about the laineil container images:

- Support **x86_64** | **arm64** | **ppc64le**.

- Based on **Alma Linux minimal** | **Rocky Linux minimal** | **Red Hat UBI minimal**.

- The use of **non-root container images** can enhance system security.

## Acquiring an image

Here are a few methods for acquiring an image.

- The recommended way to get any of the laineil container images is to pull the prebuilt image from the [Docker Hub Registry](https://hub.docker.com/r/laineil/).

```bash
$ docker pull laineil/[app_name]
```

- To use a specific version, you can pull a versioned tag.

```bash
$ docker pull laineil/[app_name]:[tag]
```

- If you wish, you can also build the image yourself by cloning the repository, changing to the directory containing the Dockerfile and executing the `docker build` command.

```bash
$ git clone https://github.com/laineil/containers.git
$ cd laineil/[app_name]
$ docker build -t laineil/[app_name] .
```

## Vulnerability scan

As part of the release process, use [Docker Scout](https://docs.docker.com/scout/) | [snyk](https://app.snyk.io/) to scan and analyze vulnerabilities.

## Issues and Contributing

To improve app performance, you can either create an [issue](https://github.com/laineil/containers/issues/new/choose) or submit a [pull request](https://github.com/laineil/containers/pulls).

## License Agreement

BSD 3-Clause License  
Copyright (c) 2023, Laineil  
All rights reserved.
