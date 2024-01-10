FROM to-be-replaced-by-local-ref/base:ubuntu-22.04

ENV GOPATH=/go \
    GOROOT=/usr/local/go
ENV PATH=${PATH}:${GOROOT}/bin:${GOPATH}/bin

COPY ./download-file.sh /tmp/

RUN apt update && \
    apt install -y --no-install-recommends git make tar gzip gcc g++ libc6-dev dbus-x11 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    case $(arch) in \
        x86_64) architecture="amd64" checksum="d589f24fe9a5ba29260b7b2c0ee7cd2f2a4df09cccae7c7abc3bffa3a1633c5557994b4114748fb82923d14f1b949e2138674e9fff5b9e08d6c7bb5b37ebcd53" ;; \
        aarch64) architecture="arm64" checksum="9863a2bae13f5710b7c24f4e8fa85ffd9185309a8825871874b1922aa9cb0aec34a2655ab142e6fa2e4712777cc6c0faa5f534d9477f9dc0b311054f72c4f790" ;; \
        *) exit 42;; \
    esac && \
    /tmp/download-file.sh "https://go.dev/dl/go1.20.13.linux-${architecture}.tar.gz" "${checksum}" | tar -C /usr/local -xzf - && \
    go install golang.org/x/vuln/cmd/govulncheck@latest && \
    go install github.com/mikefarah/yq/v4@v4.34.1 && \
    go install helm.sh/helm/v3/cmd/helm@1e210a2 && echo "installed helm v3.12.2" && \
    mv "$( go env GOPATH )/bin/yq" /usr/local/bin/ && \
    rm -rf /tmp/*
