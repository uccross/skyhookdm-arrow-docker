FROM jcnitdgp25/skyhookdm-arrow:latest

WORKDIR /

ADD arrow /arrow
COPY client-image/script.sh /

RUN ./script.sh
RUN rm -rf /arrow
