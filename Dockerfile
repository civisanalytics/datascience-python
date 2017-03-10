FROM ubuntu:14.04
MAINTAINER support@civisanalytics.com

# We need this file to install the right version of numpy.
COPY requirements.txt /requirements.txt

# Python install by wlattner.

# Eemove several traces of debian python.
RUN apt-get purge -y python.*

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG=C.UTF-8 \
    BASH_ENV=/etc/profile
# Set environment variables for UTF-8, conda, and shell environments
#ENV LANG=en_US.UTF-8 \
#    LANGUAGE=en_US:en \
#    LC_ALL=en_US.UTF-8 \
#    BASH_ENV=/etc/profile

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        libsqlite3-0 \
        libssl1.0.0 \
        libgfortran3 \
        git \
        postgresql \
        postgresql-contrib \
        libpq-dev && \
    rm -rf /var/lib/apt/lists/*

# We like PGP and so are going through this pain. Notes for the future. Yay!
# I *think* this is how this works.
#
#     1) Figure out who the release manager is for your python version. (I *think* they usually make
#        a PEP for it, because, like, they make a PEP for everything. See here for 3.6.0
#        https://www.python.org/dev/peps/pep-0494/.)
#     2) Then go look them up on a key server (This one is nice https://pgp.mit.edu/)
#     3) Search by their name and find the short 8 character key ID. You might have to try a few
#        different keys since people can have more than one and it is not always clear which one
#        was used to sign the package.
#     4) Put the 8 character key ID below.
#
# If everything goes well, you will successfully verify that the download (over https) in fact
# returned the correct, uncorrupted file. Yay!
ENV GPG_KEY AA65421D

ENV PYTHON_VERSION 3.6.0

# If this is called "PIP_VERSION", pip explodes with "ValueError: invalid truth value '<VERSION>'"
ENV PYTHON_PIP_VERSION 9.0.1

RUN set -ex && \
    buildDeps=' \
        curl \
        gcc \
        g++ \
        gfortran \
        libbz2-dev \
        libc6-dev \
        liblzma-dev \
        libncurses-dev \
        libreadline-dev \
        libsqlite3-dev \
        libssl-dev \
        make \
        xz-utils \
        zlib1g-dev' && \
    apt-get update && \
    apt-get install -y $buildDeps --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* && \
    curl -fSL "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz" -o python.tar.xz && \
    curl -fSL "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz.asc" -o python.tar.xz.asc && \
    export GNUPGHOME="$(mktemp -d)" && \
    gpg --keyserver pgp.mit.edu --recv-keys "$GPG_KEY" && \
    gpg --batch --verify python.tar.xz.asc python.tar.xz && \
    rm -r "$GNUPGHOME" python.tar.xz.asc && \
    mkdir -p /usr/src/python && \
    tar -xJC /usr/src/python --strip-components=1 -f python.tar.xz && \
    rm python.tar.xz && \
    \
    cd /usr/src/python && \
    ./configure --enable-shared --enable-unicode=ucs4 && \
    make -j$(nproc) && \
    make install && \
    ldconfig && \
    pip3 install --no-cache-dir --upgrade --ignore-installed pip==$PYTHON_PIP_VERSION && \
    pip3 install --no-cache-dir `grep 'numpy' /requirements.txt` && \
    find /usr/local -depth \
        \( \
            \( -type d -a -name test -o -name tests \) \
            -o \
            \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        \) -exec rm -rf '{}' + && \
    rm -rf /usr/src/python ~/.cache

# Make some useful symlinks that are expected to exist.
RUN cd /usr/local/bin && \
    ln -s python3 python && \
    ln -s python3-config python-config

# Now install the rest of the dependencies from the requirements file.
RUN pip install --no-cache-dir -r /requirements.txt
RUN rm -rf ~/.cache/*

# We aren't running a GUI, so force matplotlib to use
# the non-interactive "Agg" backend for graphics.
ENV MATPLOTLIBRC=${HOME}/.config/matplotlib/matplotlibrc
RUN mkdir -p `dirname ${MATPLOTLIBRC}`
RUN echo "backend      : Agg" > ${MATPLOTLIBRC}

# Run matplotlib once to build the font cache.
RUN python -c "import matplotlib.pyplot"

ENV VERSION=3.0.0 \
    VERSION_MAJOR=3 \
    VERSION_MINOR=0 \
    VERSION_MICRO=0
