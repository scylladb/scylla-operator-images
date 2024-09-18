FROM registry.access.redhat.com/ubi9/podman:9.4-14@sha256:48aff9f0d4918e6db059d8041881fd4a0f3cbfb2bacb27aee0c25acc7c136052

ENV GOPATH=/go \
    GOROOT=/usr/local/go

COPY ./download-file.sh /tmp/

RUN set -euExo pipefail && shopt -s inherit_errexit && \
    dnf install -y rsync git make tar gzip skopeo jq && \
    dnf clean all && \
    case $(arch) in \
        x86_64) architecture="amd64" checksum="5213abec3208bc9af330c870e67c08ef4b336f6e07d119a62081dace5805478550a74e67bcc926d30f9f642a3543699936f397e123c6587e7519411d6e3648f9" ;; \
        aarch64) architecture="arm64" checksum="2e24226d24617fad92f747d0a881fe8ccf7843de11b4984bae43e9892e52a9e7cf1e050ffca25523db324a96b3edea6f623d5133dda8a966326e9b103bee3797" ;; \
        *) exit 42;; \
    esac && \
    /tmp/download-file.sh "https://go.dev/dl/go1.22.7.linux-${architecture}.tar.gz" "${checksum}" | tar -C /usr/local -xzf - && \
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
