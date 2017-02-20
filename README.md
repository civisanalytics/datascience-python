# Data Science Docker Image

[![CircleCI](https://circleci.com/gh/civisanalytics/datascience-python/tree/master.svg?style=svg)](https://circleci.com/gh/civisanalytics/datascience-python/tree/master)

This image is created from the official Ubuntu 14.04 Docker image and contains popular Python packages for data science.

# Introduction

This repository defines the "[civisanalytics/datascience-python](https://hub.docker.com/r/civisanalytics/datascience-python/)"
Docker image. This Docker image provides an environment with data science tools
from the Python ecosystem. This image is the execution environment for Python
jobs in the [Civis data science platform](https://civisanalytics.com/products/civis-platform/),
and it includes the Civis [Python API client](https://github.com/civisanalytics/civis-python).

# Installation

Either build the Docker image locally
```bash
docker build -t datascience-python .
```

or download the image from DockerHub
```bash
docker pull civisanalytics/datascience-python:latest
```

The `latest` tag (Docker's default if you don't specify a tag)
will give you the most recently-built version of the datascience-python
image. You can replace the tag `latest` with a version number such as `1.0`
to retrieve a reproducible environment.

# Usage

Inside the datascience-python Docker image, Python packages are installed in the `root`
environment. For a full list of included Python libraries, see the
[environment.yml](environment.yml) file.

To start a Docker container from the datascience-python image and
interact with it from a bash prompt, use
```bash
docker run -i -t civisanalytics/datascience-python:latest /bin/bash
```

You can run a Python command with
```bash
docker run civisanalytics/datascience-python:latest python -c "import pandas; print(pandas.__version__)"
```

The image contains environment variables which allow you to find
the current version. There are four environment variables defined:
```
VERSION
VERSION_MAJOR
VERSION_MINOR
VERSION_MICRO
```
VERSION contains the full version string, e.g. "1.0.3". VERSION_MAJOR,
VERSION_MINOR, and VERSION_MICRO each contain a single integer.

# Creating Equivalent Local Environments

The `environment.yml` file in this repo can be used to create a python environment that is 
equivalent to the one in the container. **However, you should change the name of the 
environment in the `environment.yml` file first!** Otherwise, you might stomp on packages in 
your root environment or get an error.

# Contributing

See [CONTRIBUTING](CONTRIBUTING.md) for information about contributing to this project.

If you make any changes, be sure to build a container to verify that it successfully completes:
```bash
docker build -t datascience-python:test .
```
and describe any changes in the [change log](CHANGELOG.md).

## For Maintainers

This repo has autobuild enabled. Any PR that is merged to master will
be built as the `latest` tag on Dockerhub.
Once you are ready to create a new version, go to the "releases" tab of the repository and click
"Draft a new release". Github will prompt you to create a new tag, release title, and release
description. The tag should use semantic versioning in the form "vX.X.X"; "major.minor.micro".
The title of the release should be the same as the tag. Include a change log in the release description.
Once the release is tagged, DockerHub will automatically build three identical containers, with labels
"major", "major.minor", and "major.minor.micro".

# License

BSD-3

See [LICENSE.md](LICENSE.md) for details.
