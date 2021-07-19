ARG SKYHOOK_VERSION=v0.2.0
FROM uccross/skyhookdm-arrow:${SKYHOOK_VERSION}

RUN dnf group install -y "Development Tools" && \
    dnf install -y yum-utils \ 
                   make \ 
                   gcc \
                   openssl-devel \
                   bzip2-devel \
                   libffi-devel \
                   zlib-devel

RUN wget https://www.python.org/ftp/python/3.9.6/Python-3.9.6.tgz && \
    tar xzf Python-3.9.6.tgz && \
    cd Python-3.9.6 && \
    ./configure --prefix=/usr/local/python3.9.6 --enable-optimizations --enable-shared && \
    make -j$(nproc) && \
    make install && \
    cd .. && \
    rm -rf Python-3.9.6.tgz && \
    rm -rf Python-3.9.6

RUN python3 -V && pip3 --version
