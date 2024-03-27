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
        x86_64) architecture="amd64" checksum="c22d4623dede427057852ef939e593f6ed86b2a873f1cf7cc76bf52713df1e9df5c6dfde98a3185c633eb51a382118d4fc59dd29fd42a6c15123f93cbb0442ea" ;; \
        aarch64) architecture="arm64" checksum="847bc80817d1e55f39d03a18259826167ef7fda50596427266015c30555f07d2cc799bf1ccca0ed5d3d5126b3c23fa23c1f7e7fb29990206b00407e79140f25f" ;; \
        *) exit 42;; \
    esac && \
    /tmp/download-file.sh "https://go.dev/dl/go1.21.8.linux-${architecture}.tar.gz" "${checksum}" | tar -C /usr/local -xzf - && \
    go install golang.org/x/vuln/cmd/govulncheck@latest && \
    go install github.com/mikefarah/yq/v4@v4.34.1 && \
    go install helm.sh/helm/v3/cmd/helm@1e210a2 && echo "installed helm v3.12.2" && \
    mv "$( go env GOPATH )/bin/yq" /usr/local/bin/ && \
    rm -rf /tmp/*
