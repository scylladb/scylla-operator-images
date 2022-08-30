FROM to-be-replaced-by-local-ref/base:ubuntu

ENV GOPATH=/go \
    GOROOT=/usr/local/go
ENV PATH=${PATH}:${GOROOT}/bin:${GOPATH}/bin

RUN apt-get update && \
    apt-get install -y --no-install-recommends git make tar gzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    curl --fail --retry 5 -L https://go.dev/dl/go1.18.5.linux-amd64.tar.gz | tar -C /usr/local -xzf -
