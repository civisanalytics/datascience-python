
FROM buildpack-deps:bookworm

# ensure local python is preferred over distribution python
ENV PATH /usr/local/bin:$PATH

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

# runtime dependencies
RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
  libbluetooth-dev \
  tk-dev \
  uuid-dev \
  ;

ENV GPG_KEY A035C8C19219BA821ECEA86B64E628F8D684696D
ENV PYTHON_VERSION 3.11.4

RUN set -eux; \
  \
  wget -O python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz"; \
  wget -O python.tar.xz.asc "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz.asc"; \
  GNUPGHOME="$(mktemp -d)"; export GNUPGHOME; \
  gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys "$GPG_KEY"; \
  gpg --batch --verify python.tar.xz.asc python.tar.xz; \
  gpgconf --kill all; \
  rm -rf "$GNUPGHOME" python.tar.xz.asc; \
  mkdir -p /usr/src/python; \
  tar --extract --directory /usr/src/python --strip-components=1 --file python.tar.xz; \
  rm python.tar.xz; \
  \
  cd /usr/src/python; \
  gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)"; \
  ./configure \
  --build="$gnuArch" \
  --enable-loadable-sqlite-extensions \
  --enable-optimizations \
  --enable-option-checking=fatal \
  --enable-shared \
  --with-lto \
  --with-system-expat \
  --without-ensurepip \
  ; \
  nproc="$(nproc)"; \
  EXTRA_CFLAGS="$(dpkg-buildflags --get CFLAGS)"; \
  LDFLAGS="$(dpkg-buildflags --get LDFLAGS)"; \
  make -j "$nproc" \
  "EXTRA_CFLAGS=${EXTRA_CFLAGS:-}" \
  "LDFLAGS=${LDFLAGS:-}" \
  "PROFILE_TASK=${PROFILE_TASK:-}" \
  ; \
  # https://github.com/docker-library/python/issues/784
  # prevent accidental usage of a system installed libpython of the same version
  rm python; \
  make -j "$nproc" \
  "EXTRA_CFLAGS=${EXTRA_CFLAGS:-}" \
  "LDFLAGS=${LDFLAGS:--Wl},-rpath='\$\$ORIGIN/../lib'" \
  "PROFILE_TASK=${PROFILE_TASK:-}" \
  python \
  ; \
  make install; \
  \
  # enable GDB to load debugging data: https://github.com/docker-library/python/pull/701
  bin="$(readlink -ve /usr/local/bin/python3)"; \
  dir="$(dirname "$bin")"; \
  mkdir -p "/usr/share/gdb/auto-load/$dir"; \
  cp -vL Tools/gdb/libpython.py "/usr/share/gdb/auto-load/$bin-gdb.py"; \
  \
  cd /; \
  rm -rf /usr/src/python; \
  \
  find /usr/local -depth \
  \( \
  \( -type d -a \( -name test -o -name tests -o -name idle_test \) \) \
  -o \( -type f -a \( -name '*.pyc' -o -name '*.pyo' -o -name 'libpython*.a' \) \) \
  \) -exec rm -rf '{}' + \
  ; \
  \
  ldconfig; \
  \
  python3 --version

# make some useful symlinks that are expected to exist ("/usr/local/bin/python" and friends)
RUN set -eux; \
  for src in idle3 pydoc3 python3 python3-config; do \
  dst="$(echo "$src" | tr -d 3)"; \
  [ -s "/usr/local/bin/$src" ]; \
  [ ! -e "/usr/local/bin/$dst" ]; \
  ln -svT "$src" "/usr/local/bin/$dst"; \
  done

# if this is called "PIP_VERSION", pip explodes with "ValueError: invalid truth value '<VERSION>'"
ENV PYTHON_PIP_VERSION 23.1.2
# https://github.com/docker-library/python/issues/365
ENV PYTHON_SETUPTOOLS_VERSION 65.5.1
# https://github.com/pypa/get-pip
ENV PYTHON_GET_PIP_URL https://github.com/pypa/get-pip/raw/0d8570dc44796f4369b652222cf176b3db6ac70e/public/get-pip.py
ENV PYTHON_GET_PIP_SHA256 96461deced5c2a487ddc65207ec5a9cffeca0d34e7af7ea1afc470ff0d746207

RUN set -eux; \
  \
  wget -O get-pip.py "$PYTHON_GET_PIP_URL"; \
  echo "$PYTHON_GET_PIP_SHA256 *get-pip.py" | sha256sum -c -; \
  \
  export PYTHONDONTWRITEBYTECODE=1; \
  \
  python get-pip.py \
  --disable-pip-version-check \
  --no-cache-dir \
  --no-compile \
  "pip==$PYTHON_PIP_VERSION" \
  "setuptools==$PYTHON_SETUPTOOLS_VERSION" \
  ; \
  rm -f get-pip.py; \
  \
  pip --version

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
