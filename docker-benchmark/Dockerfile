ARG CEPH_VERSION=v16.2
FROM ceph/ceph:${CEPH_VERSION}

ARG UCCROSS_ARROW_BRANCH=arrow-master

ADD script.sh /
WORKDIR /

RUN dnf group install -y "Development Tools" && \
    dnf install -y cmake \
                   make \
                   gcc \
                   wget \
                   yum-utils \
                   libarchive \
                   curl \
                   xz-devel \
                   openssl-devel \
                   bzip2-devel \
                   libffi-devel \
                   python3-rados \
                   zlib-devel \
                   rados-objclass-devel \
                   librados-devel && \
    dnf clean all && \
    wget https://www.python.org/ftp/python/3.9.6/Python-3.9.6.tgz && \
    tar xzf Python-3.9.6.tgz && \
    cd Python-3.9.6 && \
    ./configure --enable-optimizations && \
    make -j$(nproc) && \
    make altinstall && \
    cd .. && \
    rm -rf Python-3.9.6.tgz && \
    rm -rf Python-3.9.6 && \
    python3.9 -V && pip3.9 --version && \
    git clone \
        --branch ${UCCROSS_ARROW_BRANCH} \
        --depth=1 \
        https://github.com/uccross/arrow /arrow && \
    ./script.sh && \
    rm -r /arrow
