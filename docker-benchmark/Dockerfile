ARG SKYHOOK_VERSION=v0.2.0
FROM uccross/skyhookdm-arrow:${SKYHOOK_VERSION}

RUN dnf group install -y "Development Tools" && \
    dnf install -y yum-utils \ 
                   make \ 
                   gcc \
                   xz-devel \
                   openssl-devel \
                   bzip2-devel \
                   libffi-devel \
                   zlib-devel && \
    wget https://www.python.org/ftp/python/3.9.6/Python-3.9.6.tgz && \
    tar xzf Python-3.9.6.tgz && \
    cd Python-3.9.6 && \
    ./configure --enable-optimizations && \
    make -j$(nproc) && \
    make altinstall && \
    cd .. && \
    rm -rf Python-3.9.6.tgz && \
    rm -rf Python-3.9.6 && \
    python3.9 -V && pip3.9 --version
