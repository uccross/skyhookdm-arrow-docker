ARG CEPH_VERSION=v15.2.4

FROM ceph/ceph:$CEPH_VERSION

RUN dnf group install -y "Development Tools" && \
    dnf install -y cmake \
                   wget \
                   curl \
                   rados-objclass-devel \
                   python3-rados \
                   libcephfs-devel \
                   librados-devel && \
    dnf clean all

COPY script.sh /

WORKDIR /

ADD arrow/ /arrow

RUN ./script.sh 

RUN rm -rf /arrow
