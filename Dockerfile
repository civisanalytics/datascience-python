FROM python:3.11.4-bookworm

LABEL maintainer = support@civisanalytics.com

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0E98404D386FA1D9
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6ED0E7B82643E131
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 54404762BBB6E853
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BDE6D2B9216EC7A8
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F8D2585B8783D481

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y --no-install-recommends

RUN apt-get install -y --no-install-recommends locales

RUN locale-gen en_US.UTF-8

RUN apt-get install -y --no-install-recommends software-properties-common

RUN apt-get install -y --no-install-recommends \
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

RUN pip install -r requirements-full.txt && \
  pip cache purge && \
  rm requirements-full.txt

# Instruct joblib to use disk for temporary files. Joblib defaults to
# /shm when that directory is present. In the Docker container, /shm is
# present but defaults to 64 MB.
# https://github.com/joblib/joblib/blob/0.11/joblib/parallel.py#L328L342
ENV JOBLIB_TEMP_FOLDER=/tmp

ENV VERSION=7.0.0 \
  VERSION_MAJOR=7 \
  VERSION_MINOR=0 \
  VERSION_MICRO=0
