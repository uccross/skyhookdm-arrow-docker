
FROM ubuntu:latest
ARG FOO=hh


RUN echo ${FOO}
