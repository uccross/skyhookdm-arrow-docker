FROM ceph/ceph:v15.2

RUN yum -y update && \
    yum -y install  git \
                    bc \
                    librados-devel \
                    rados-objclass-devel \
                    python3-rados && \
    yum clean all

RUN wget https://github.com/Kitware/CMake/releases/download/v3.15.2/cmake-3.15.2.tar.gz && \
    tar -zxvf cmake-3.15.2.tar.gz && \
    cd cmake-3.15.2 && \
    ./bootstrap && \
    make && \
    make install

COPY script.sh /

WORKDIR /

RUN ./script.sh
