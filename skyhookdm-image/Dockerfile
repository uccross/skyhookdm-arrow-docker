ARG CEPH_VERSION=v15.2.4
ARG BRANCH=rados-dataset-dev

FROM ceph/ceph:$CEPH_VERSION

RUN dnf group install -y "Development Tools" && \
    dnf install -y cmake wget curl rados-objclass-devel python3-rados librados-devel && \
    dnf clean all

COPY script.sh /

WORKDIR /

ENV BRANCH=$BRANCH

RUN git clone https://github.com/uccross/arrow --branch "$BRANCH"

RUN ./script.sh
