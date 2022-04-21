ARG CEPH_VERSION=v16.2
FROM ceph/ceph:${CEPH_VERSION}

ARG UCCROSS_ARROW_BRANCH=arrow-master

ADD script.sh /
WORKDIR /

RUN cd /etc/yum.repos.d/ && \
    sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-* && \
    yum update -y && \
    cd / && \
    dnf group install -y "Development Tools" && \
    dnf install -y cmake \
                   wget \
                   libarchive \
                   curl \
                   rados-objclass-devel \
                   python3-rados \
                   librados-devel && \
    dnf clean all && \
    git clone \
        --branch ${UCCROSS_ARROW_BRANCH} \
        --depth=1 \
        https://github.com/uccross/arrow /arrow && \
    ./script.sh && \
    rm -r /arrow
