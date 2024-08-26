ARG PLATFORM=linux/x86_64
ARG BASE_IMAGE=python:3.12.5-slim

# This is the primary build target used for the production image
FROM --platform=$PLATFORM $BASE_IMAGE AS production

# Disable pip warnings https://stackoverflow.com/a/72551258
ENV PIP_ROOT_USER_ACTION=ignore

LABEL maintainer=support@civisanalytics.com

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y --no-install-recommends && \
  apt-get install -y --no-install-recommends locales && \
  locale-gen en_US.UTF-8 && \
  apt-get install -y --no-install-recommends software-properties-common && \
  apt-get install -y --no-install-recommends \
  make \
  automake \
  libpq-dev \
  libffi-dev \
  gfortran \
  g++ \
  git \
  libboost-program-options-dev \
  libtool \
  libxrender1 \
  wget \
  ca-certificates \
  curl \
  unzip && \
  apt-get clean -y && \
  rm -rf /var/lib/apt/lists/*

COPY requirements-full.txt .

RUN pip install --progress-bar off --no-cache-dir -r requirements-full.txt && \
  rm requirements-full.txt

# Instruct joblib to use disk for temporary files. Joblib defaults to
# /shm when that directory is present. In the Docker container, /shm is
# present but defaults to 64 MB.
# https://github.com/joblib/joblib/blob/0.11/joblib/parallel.py#L328L342
ENV JOBLIB_TEMP_FOLDER=/tmp

ENV VERSION=8.0.0 \
  VERSION_MAJOR=8 \
  VERSION_MINOR=0 \
  VERSION_MICRO=0

# Install the AWSCLI for moving match targets in the QC workflow.
# See https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#cliv2-linux-install
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws awscliv2.zip

# This build target is for testing in Circle CI.
FROM --platform=$PLATFORM production AS test
COPY .circleci/test_image.py .
COPY CHANGELOG.md .

# This build target is for updating dependencies.
# See generate-requirements.full.sh.
FROM --platform=$PLATFORM $BASE_IMAGE AS pip-tools
RUN pip install -U --no-cache-dir pip pip-tools --progress-bar off
CMD ["/bin/bash"]

# Default to the production build target.
FROM production
