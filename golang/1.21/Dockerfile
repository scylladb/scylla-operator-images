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
        x86_64) architecture="amd64" checksum="c27934b819020e8199cfafc9740543da245bee22c3811fc0cf7f9fd513407229b9c016411b5f18deed38f010dfd5ca9c8948fdffb19cd56621f81f2c99164d07" ;; \
        aarch64) architecture="arm64" checksum="9f8841b863394cb2cd70f497df99e92b4128d283f36e3cde78a504fef88535486b69b2210462de4aa5c86f25b43bad73a372a60c349b6a9e924274c705e03030" ;; \
        *) exit 42;; \
    esac && \
    /tmp/download-file.sh "https://go.dev/dl/go1.21.12.linux-${architecture}.tar.gz" "${checksum}" | tar -C /usr/local -xzf - && \
    go install golang.org/x/vuln/cmd/govulncheck@latest && \
    go install github.com/mikefarah/yq/v4@v4.34.1 && \
    go install helm.sh/helm/v3/cmd/helm@1e210a2 && echo "installed helm v3.12.2" && \
    mv "$( go env GOPATH )/bin/yq" /usr/local/bin/ && \
    rm -rf /tmp/*
