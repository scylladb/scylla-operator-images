FROM to-be-replaced-by-local-ref/base:ubuntu-22.04

ENV GOPATH=/go \
    GOROOT=/usr/local/go \
    GOTOOLCHAIN=local
ENV PATH=${PATH}:${GOROOT}/bin:${GOPATH}/bin

COPY ./download-file.sh /tmp/

RUN apt update && \
    apt install -y --no-install-recommends git make tar gzip gcc g++ libc6-dev dbus-x11 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    case $(arch) in \
        x86_64) architecture="amd64" checksum="f648d7e8e728aedfebe34a5f29ebdcd03e3f70a17791b333738423db8a3db2fb177d73155b0eaa6522410eebef63dcc3841ca484c729e576459de958994ede74" ;; \
        aarch64) architecture="arm64" checksum="2bb8fe4aa9a8cb87ce5d8d1978b4d35dd9ccae4369ab7e06b686239f60506e33fe4cd8bced492e4e168f23dc674cca1cddd31b1003efcf66c9f6cbbcb7a11ddf" ;; \
        *) exit 42;; \
    esac && \
    /tmp/download-file.sh "https://go.dev/dl/go1.21.10.linux-${architecture}.tar.gz" "${checksum}" | tar -C /usr/local -xzf - && \
    go install golang.org/x/vuln/cmd/govulncheck@latest && \
    go install github.com/mikefarah/yq/v4@v4.34.1 && \
    go install helm.sh/helm/v3/cmd/helm@1e210a2 && echo "installed helm v3.12.2" && \
    mv "$( go env GOPATH )/bin/yq" /usr/local/bin/ && \
    rm -rf /tmp/*
