FROM to-be-replaced-by-local-ref/base:ubuntu

ENV GOPATH=/go \
    GOROOT=/usr/local/go
ENV PATH=${PATH}:${GOROOT}/bin:${GOPATH}/bin

COPY ./download-file.sh /tmp/

RUN apt-get update && \
    apt-get install -y --no-install-recommends git make tar gzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    /tmp/download-file.sh https://go.dev/dl/go1.18.6.linux-amd64.tar.gz 'd71abdf8a3639207185b373697888ec5a95b282ac798ce1a112ac6edcd41c3f331609560b6915336b316018b22e8fff4df1a3cb12d075bbc5492c869013f7f59' | tar -C /usr/local -xzf - && \
    rm -rf /tmp/
