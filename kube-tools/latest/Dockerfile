FROM registry.access.redhat.com/ubi9/podman:9.4-14@sha256:48aff9f0d4918e6db059d8041881fd4a0f3cbfb2bacb27aee0c25acc7c136052

ENV GOPATH=/go \
    GOROOT=/usr/local/go

COPY ./download-file.sh /tmp/

RUN set -euExo pipefail && shopt -s inherit_errexit && \
    dnf install -y rsync git make tar gzip skopeo jq procps-ng && \
    dnf clean all && \
    case $(arch) in \
        x86_64) architecture="amd64" checksum="ca792b934f4f569d3d7b17ef7c34878e08a4b9edf4bba5588c2b63d99995f948a8d20405ec6a5a95b7af294b1def4550f43d942d3003f1c770e9463a54fa0a94" ;; \
        aarch64) architecture="arm64" checksum="6df4f263b5e7f2486a5cf9277baefd52394b2df908f8902af5af47bb5d270a27cddd9048dee69f3b544504ba7ce0324f99b6213cf367a52dba17fc748d594d8b" ;; \
        *) exit 42;; \
    esac && \
    /tmp/download-file.sh "https://go.dev/dl/go1.23.5.linux-${architecture}.tar.gz" "${checksum}" | tar -C /usr/local -xzf - && \
    ln -s /usr/local/go/bin/go /usr/local/bin/go && \
    go install github.com/mikefarah/yq/v4@v4.44.3 && \
    mv "$( go env GOPATH )/bin/yq" /usr/local/bin/ && \
    mkdir -p /go/src/k8s.io/ && \
    cd /go/src/k8s.io/ && \
    git clone --depth=1 --branch v1.31.1 https://github.com/kubernetes/kubernetes.git && \
    cd ./kubernetes && \
    make WHAT=cmd/kubectl && \
    mv /go/src/k8s.io/kubernetes/_output/bin/kubectl /usr/bin/ && \
    rm -rf /go/src/k8s.io/ && \
    rm -rf /tmp/*
