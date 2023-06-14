FROM to-be-replaced-by-local-ref/base:ubuntu-22.04

ENV GOPATH=/go \
    GOROOT=/usr/local/go
ENV PATH=${PATH}:${GOROOT}/bin:${GOPATH}/bin

COPY ./download-file.sh /tmp/

RUN apt-get update && \
    apt-get install -y --no-install-recommends git make tar gzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    /tmp/download-file.sh https://go.dev/dl/go1.19.8.linux-amd64.tar.gz '469ff06d6b86d201bcf01abbb6eed6897091afed2fd47726d90589424e4abd9a561cc24c8c2a5ce3a172a8905bfcdb35e32aef4a72ad380584f549fd20cb1d42' | tar -C /usr/local -xzf - && \
    go install github.com/mikefarah/yq/v4@v4.34.1 && \
    rm -rf /tmp/*
