FROM registry.access.redhat.com/ubi9/podman:9.2-15@sha256:e29e52923aeb2e3b2558df522318624843e2de4e1c22f79aa0102ff03dddc9d3

ENV GOPATH=/go \
    GOROOT=/usr/local/go

COPY ./download-file.sh /tmp/

RUN set -euExo pipefail && shopt -s inherit_errexit && \
    dnf install -y rsync git make tar gzip skopeo && \
    dnf clean all && \
    case $(arch) in \
        x86_64) architecture="amd64" checksum="c6a35d16faddf2434da7717206a9cdd81e502fb49d79596d5a005f680611d0f34d3c8d1c68a1b2ce84bdc66883d725e2a94d60e714b3cb3f4fbafea7666b1d6c" ;; \
        aarch64) architecture="arm64" checksum="243dfe3f53f263f11dd6d44cd2290704769070807b9f43a54c8b1766327a6b0bd75d8613085bdee1a68fbeb70fe095e610cd1288723c865a39c9d69f3fb48116" ;; \
        *) exit 42;; \
    esac && \
    /tmp/download-file.sh "https://go.dev/dl/go1.21.9.linux-${architecture}.tar.gz" "${checksum}" | tar -C /usr/local -xzf - && \
    ln -s /usr/local/go/bin/go /usr/local/bin/go && \
    go install github.com/mikefarah/yq/v4@v4.34.1 && \
    mv "$( go env GOPATH )/bin/yq" /usr/local/bin/ && \
    mkdir -p /go/src/k8s.io/ && \
    cd /go/src/k8s.io/ && \
    git clone --depth=1 --branch v1.29.1 https://github.com/kubernetes/kubernetes.git && \
    cd ./kubernetes && \
    make WHAT=cmd/kubectl && \
    mv /go/src/k8s.io/kubernetes/_output/bin/kubectl /usr/bin/ && \
    rm -rf /go/src/k8s.io/ && \
    rm -rf /tmp/*
