FROM to-be-replaced-by-local-ref/base:ubuntu-22.04

ENV GOPATH=/go \
    GOROOT=/usr/local/go
ENV PATH=${PATH}:${GOROOT}/bin:${GOPATH}/bin

COPY ./download-file.sh /tmp/

RUN apt-get update && \
    apt-get install -y --no-install-recommends git make tar gzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    /tmp/download-file.sh https://go.dev/dl/go1.19.5.linux-amd64.tar.gz '41cb5e267aca9c3120bc218a81921e4ef1e1b8a5eeb609f82f697092a86fbfc252130a5b87794ce08a21c41f7926b0672273cf1b831d57208e8caaa18c5181bf' | tar -C /usr/local -xzf - && \
    rm -rf /tmp/*
