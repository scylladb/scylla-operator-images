FROM to-be-replaced-by-local-ref/base:ubuntu-22.04

ENV GOPATH=/go \
    GOROOT=/usr/local/go
ENV PATH=${PATH}:${GOROOT}/bin:${GOPATH}/bin

COPY ./download-file.sh /tmp/

RUN apt-get update && \
    apt-get install -y --no-install-recommends git make tar gzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    /tmp/download-file.sh https://go.dev/dl/go1.20.3.linux-amd64.tar.gz 'b6e74b9b0bf03371e746b1b579235665a692425847b685f1a862345a5858329ec24e184db4ddbd2fd617e22df4c48d3e95fe7ba79b19d737c6d6afa63a129773' | tar -C /usr/local -xzf - && \
    go install github.com/mikefarah/yq/v4@v4.34.1 && \
    rm -rf /tmp/*
