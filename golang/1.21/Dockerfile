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
        x86_64) architecture="amd64" checksum="137d80bd93957a8f7acbc7cfc4966880e4d91ef4ebe627836f54c9db0a234dea49fe95c713bb93cb151ad68b33e87e1d9617fabddd715cd1cded204de17c6ce7" ;; \
        aarch64) architecture="arm64" checksum="39ebdf04c42508afe2c5048a478f8c308abb982d3b0c3764233f679c59f0b407355b5532d34e6abb69e3e8533d6a809b1f120b86d2a8dcaaeb8c66be08acaeb0" ;; \
        *) exit 42;; \
    esac && \
    /tmp/download-file.sh "https://go.dev/dl/go1.21.6.linux-${architecture}.tar.gz" "${checksum}" | tar -C /usr/local -xzf - && \
    go install golang.org/x/vuln/cmd/govulncheck@latest && \
    go install github.com/mikefarah/yq/v4@v4.34.1 && \
    go install helm.sh/helm/v3/cmd/helm@1e210a2 && echo "installed helm v3.12.2" && \
    mv "$( go env GOPATH )/bin/yq" /usr/local/bin/ && \
    rm -rf /tmp/*
