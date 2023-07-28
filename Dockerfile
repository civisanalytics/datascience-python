FROM python:3.11.4-bookworm

LABEL maintainer = support@civisanalytics.com

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y --no-install-recommends

RUN apt-get install -y --no-install-recommends locales

RUN locale-gen en_US.UTF-8

RUN apt-get install -y --no-install-recommends software-properties-common

RUN apt-get install -y --no-install-recommends make
RUN apt-get install -y --no-install-recommends automake
RUN apt-get install -y --no-install-recommends  libpq-dev
RUN apt-get install -y --no-install-recommends  libffi-dev
RUN apt-get install -y --no-install-recommends  gfortran
RUN apt-get install -y --no-install-recommends  g++
RUN apt-get install -y --no-install-recommends  git
RUN apt-get install -y --no-install-recommends  libboost-program-options-dev
RUN apt-get install -y --no-install-recommends  libtool
RUN apt-get install -y --no-install-recommends  libxrender1
RUN apt-get install -y --no-install-recommends  wget
RUN apt-get install -y --no-install-recommends  ca-certificates
RUN apt-get install -y --no-install-recommends  curl
RUN apt-get clean -y
RUN rm -rf /var/lib/apt/lists/*

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
