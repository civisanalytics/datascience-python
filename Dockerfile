FROM ubuntu/python:3.12-24.04_stable AS production

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
  curl && \
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

ENV VERSION=7.3.0 \
  VERSION_MAJOR=7 \
  VERSION_MINOR=3 \
  VERSION_MICRO=0

FROM production AS test
COPY .circleci/test_image.py .
COPY CHANGELOG.md .

# Defaults to production as the final stage
FROM production
