FROM to-be-replaced-by-local-ref/base:ubuntu

ENV GOPATH=/go \
    GOROOT=/usr/local/go
ENV PATH=${PATH}:${GOROOT}/bin:${GOPATH}/bin

COPY ./download-file.sh /tmp/

RUN apt-get update && \
    apt-get install -y --no-install-recommends git make tar gzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    /tmp/download-file.sh https://go.dev/dl/go1.18.5.linux-amd64.tar.gz 'c83a94b12a762f458d38e1bcd41612dc53960c16baa02a58a7a86cf2c19542f4b5255562dc83d3cdd5cdbfb4678db3c4cfcf8be6e020347f5d56f79bba0b1f1c' | tar -C /usr/local -xzf - && \
    rm -rf /tmp/
