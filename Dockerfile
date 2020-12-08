FROM jcnitdgp25/arrow-cls-dev-env:2020-10-20

ENV LD_LIBRARY_PATH=/usr/local/lib/

COPY script.sh /

WORKDIR /

RUN ./script.sh
