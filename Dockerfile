FROM jcnitdgp25/arrow-cls-dev-env:2020-10-20

COPY script.sh /

WORKDIR /

RUN ./script.sh
