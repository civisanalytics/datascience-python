FROM ubuntu:14.04
MAINTAINER support@civisanalytics.com

# Ensure UTF-8 locale.
RUN locale-gen en_US.UTF-8

# Set environment variables for UTF-8, conda, and shell environments
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    CONDARC=/opt/conda/.condarc \
    BASH_ENV=/etc/profile \
    PATH=/opt/conda/bin:$PATH

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y && \
  apt-get install -y software-properties-common && \
  apt-get install -y \
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
      curl

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-4.3.11-Linux-x86_64.sh && \
    /bin/bash /Miniconda3-4.3.11-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda3-4.3.11-Linux-x86_64.sh && \
    /opt/conda/bin/conda install --yes conda==4.3.11 && \
    echo "conda ==4.3.11" > /opt/conda/conda-meta/pinned

# Red Hat and Debian use different names for this file. git2R wants the latter.
# See conda-recipes GH 423
RUN ln -s /opt/conda/lib/libopenblas.so /opt/conda/lib/libblas.so && \
    ln -s /opt/conda/lib/libopenblas.so /opt/conda/lib/liblapack.so && \
    ln -s /opt/conda/lib/libssl.so /opt/conda/lib/libssl.so.6 && \
    ln -s /opt/conda/lib/libcrypto.so /opt/conda/lib/libcrypto.so.6

# Install boto in the base environment for private s3 channel support.
# Install Python Packages
COPY .condarc /opt/conda/.condarc
COPY environment.yml environment.yml
RUN conda install -y boto && \
    conda install -y nomkl && \
    conda env update -f environment.yml

# We aren't running a GUI, so force matplotlib to use
# the non-interactive "Agg" backend for graphics.
ENV MATPLOTLIBRC=${HOME}/.config/matplotlib/matplotlibrc
RUN mkdir -p ${HOME}/.config/matplotlib
RUN echo "backend      : Agg" > ${HOME}/.config/matplotlib/matplotlibrc

# Run matplotlib once to build the font cache
RUN python -c "import matplotlib.pyplot"

ENV VERSION=2.0.0 \
    VERSION_MAJOR=2 \
    VERSION_MINOR=0 \
    VERSION_MICRO=0
