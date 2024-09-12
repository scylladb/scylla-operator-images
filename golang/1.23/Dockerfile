FROM to-be-replaced-by-local-ref/base:ubi-9.4-minimal

ENV GOPATH=/go \
    GOROOT=/usr/local/go \
    GOTOOLCHAIN=local \
    GOPROXY=direct
ENV PATH=${PATH}:${GOROOT}/bin:${GOPATH}/bin

COPY ./download-file.sh /tmp/

RUN microdnf update -y && \
    microdnf install -y git make tar gzip gcc g++ findutils && \
    microdnf install -y dbus-x11 --enablerepo=almalinux-appstream-9 && \
    microdnf clean all && \
    rm -rf /var/cache/dnf/* && \
    case $(arch) in \
        x86_64) architecture="amd64" checksum="4e88d889f9c8ee0b532a3db18674b73e2510ac4a03e155f18d3772e51f517b99ed50d108a0826d96e7a08ac0fcc5261a91f243541d12a03c331a2d06af803d6f" ;; \
        aarch64) architecture="arm64" checksum="2747eda74c132bdcb69640692f5165448a84b41a48bfd214e6396a7fa583167ca7b00d0306185e14a77296d5510df27e9b0f586ae4604547a31370edfb146c6f" ;; \
        *) exit 42;; \
    esac && \
    /tmp/download-file.sh "https://go.dev/dl/go1.23.1.linux-${architecture}.tar.gz" "${checksum}" | tar -C /usr/local -xzf - && \
    go install golang.org/x/vuln/cmd/govulncheck@latest && \
    go install github.com/mikefarah/yq/v4@v4.44.3 && \
    go install helm.sh/helm/v3/cmd/helm@1e210a2 && echo "installed helm v3.12.2" && \
    mv "$( go env GOPATH )/bin/yq" /usr/local/bin/ && \
    rm -rf /tmp/*
