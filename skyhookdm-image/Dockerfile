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

WORKDIR /

ADD arrow /arrow
ADD skyhookdm-image/script.sh /

RUN ./script.sh 
RUN rm -rf /arrow
