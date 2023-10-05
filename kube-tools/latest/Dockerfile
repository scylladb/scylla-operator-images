FROM registry.access.redhat.com/ubi9/podman:9.2-15@sha256:e29e52923aeb2e3b2558df522318624843e2de4e1c22f79aa0102ff03dddc9d3

ENV GOPATH=/go \
    GOROOT=/usr/local/go

COPY ./download-file.sh /tmp/

RUN set -euExo pipefail && shopt -s inherit_errexit && \
    dnf install -y rsync git make tar gzip skopeo && \
    dnf clean all && \
    case $(arch) in \
        x86_64) architecture="amd64" checksum="b6e74b9b0bf03371e746b1b579235665a692425847b685f1a862345a5858329ec24e184db4ddbd2fd617e22df4c48d3e95fe7ba79b19d737c6d6afa63a129773" ;; \
        aarch64) architecture="arm64" checksum="77cd5056936f060a39ad79d485c160cec849fe2c4925e1cd9461b023912cf7cad90e8a88bfba26e74d94a4b518670333398d2abcd01bf1e78fbe8c2be4008388" ;; \
        *) exit 42;; \
    esac && \
    /tmp/download-file.sh "https://go.dev/dl/go1.20.3.linux-${architecture}.tar.gz" "${checksum}" | tar -C /usr/local -xzf - && \
    ln -s /usr/local/go/bin/go /usr/local/bin/go && \
    go install github.com/mikefarah/yq/v4@v4.34.1 && \
    mv "$( go env GOPATH )/bin/yq" /usr/local/bin/ && \
    mkdir -p /go/src/k8s.io/ && \
    cd /go/src/k8s.io/ && \
    git clone --depth=1 --branch v1.27.3 https://github.com/kubernetes/kubernetes.git && \
    cd ./kubernetes && \
    make WHAT=cmd/kubectl && \
    mv /go/src/k8s.io/kubernetes/_output/bin/kubectl /usr/bin/ && \
    rm -rf /go/src/k8s.io/ && \
    rm -rf /tmp/*
