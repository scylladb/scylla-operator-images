FROM to-be-replaced-by-local-ref/base:ubuntu-22.04

ENV GOPATH=/go \
    GOROOT=/usr/local/go
ENV PATH=${PATH}:${GOROOT}/bin:${GOPATH}/bin

COPY ./download-file.sh /tmp/

RUN apt-get update && \
    apt-get install -y --no-install-recommends git make tar gzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    /tmp/download-file.sh https://go.dev/dl/go1.20.2.linux-amd64.tar.gz 'bd196b7bb89548d6cf7a3a23f3709aa9695f02fcac979b31f47a061145004a71da5791696486e26a3b589620b15a2a2fdc8c3540649d73c7fa866e2b6bdbc7f9' | tar -C /usr/local -xzf - && \
    rm -rf /tmp/*
