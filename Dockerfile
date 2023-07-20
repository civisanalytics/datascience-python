FROM python:3.11.4-bookworm

LABEL maintainer = support@civisanalytics.com

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
  curl && \
  apt-get clean -y && \
  rm -rf /var/lib/apt/lists/*

COPY requirements-full.txt .

RUN pip install -r requirements-full.txt

# Instruct joblib to use disk for temporary files. Joblib defaults to
# /shm when that directory is present. In the Docker container, /shm is
# present but defaults to 64 MB.
# https://github.com/joblib/joblib/blob/0.11/joblib/parallel.py#L328L342
ENV JOBLIB_TEMP_FOLDER=/tmp

ENV VERSION=6.6.0 \
  VERSION_MAJOR=6 \
  VERSION_MINOR=6 \
  VERSION_MICRO=0
