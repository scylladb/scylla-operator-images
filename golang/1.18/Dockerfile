FROM to-be-replaced-by-local-ref/base:ubuntu-22.04

ENV GOPATH=/go \
    GOROOT=/usr/local/go
ENV PATH=${PATH}:${GOROOT}/bin:${GOPATH}/bin

COPY ./download-file.sh /tmp/

RUN apt-get update && \
    apt-get install -y --no-install-recommends git make tar gzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    /tmp/download-file.sh https://go.dev/dl/go1.18.10.linux-amd64.tar.gz '2f1986ae1a95f1e2e735abdf2240770210482215c03293322ce9d3cb7b5c7b2904943827154d048771b00fa95d9b5e659d8077873dea0352d7d8cca8880ce204' | tar -C /usr/local -xzf - && \
    go install github.com/mikefarah/yq/v4@v4.34.1 && \
    mv "$( go env GOPATH )/bin/yq" /usr/local/bin/ && \
    rm -rf /tmp/*
