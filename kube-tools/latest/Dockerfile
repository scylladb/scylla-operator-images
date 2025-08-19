FROM registry.access.redhat.com/ubi9/podman:9.4-14@sha256:48aff9f0d4918e6db059d8041881fd4a0f3cbfb2bacb27aee0c25acc7c136052

ENV GOPATH=/go \
    GOROOT=/usr/local/go

COPY ./download-file.sh /tmp/

RUN set -euExo pipefail && shopt -s inherit_errexit && \
    dnf install -y rsync git make tar gzip skopeo jq procps-ng && \
    dnf clean all && \
    case $(arch) in \
        x86_64) architecture="amd64" checksum="0442a8072c79c48f87ff1068ba2a40feda4c07b76ecd4ea0f6a6e9ae30020c39d06bd17ea0ebcedf48992526ecb7ddce8989119a5caca69d04364f5b7fca489b" ;; \
        aarch64) architecture="arm64" checksum="ccc64f89547ddf04dfd806319750c0e692f7e3980f2d8a06ea0161da8c86495487128af21347b5d65d760f9798855165d3509cd80050842e4d0693cdc9a7f08c" ;; \
        *) exit 42;; \
    esac && \
    /tmp/download-file.sh "https://go.dev/dl/go1.24.6.linux-${architecture}.tar.gz" "${checksum}" | tar -C /usr/local -xzf - && \
    ln -s /usr/local/go/bin/go /usr/local/bin/go && \
    go install github.com/mikefarah/yq/v4@v4.44.3 && \
    mv "$( go env GOPATH )/bin/yq" /usr/local/bin/ && \
    go install github.com/redhat-openshift-ecosystem/openshift-preflight/cmd/preflight@v1.14.1 && \
    mv "$( go env GOPATH )/bin/preflight" /usr/local/bin/ && \
    mkdir -p /go/src/k8s.io/ && \
    cd /go/src/k8s.io/ && \
    git clone --depth=1 --branch v1.33.3 https://github.com/kubernetes/kubernetes.git && \
    cd ./kubernetes && \
    make WHAT=cmd/kubectl && \
    mv /go/src/k8s.io/kubernetes/_output/bin/kubectl /usr/bin/ && \
    case $(arch) in \
        x86_64) architecture="amd64" checksum="835a5540974781620a8a31f91758bbcfbbf32eccf2f1fc4e4a690b52b0287176141225c3b8bc5010a22a1e0af1783d76747ff10d8e299c8cd304f6f9cdbb6776" ;; \
        aarch64) architecture="arm64" checksum="e6dc9265fdddf0a939ca6cacd5a7164396caf32478bc8960b93d2017044d58bc1594bef83546f22f698d9f7707a1ad25fe698c0280556fa6b3f6e3005fdee2da" ;; \
        *) exit 42;; \
    esac && \
    /tmp/download-file.sh "https://github.com/operator-framework/operator-registry/releases/download/v1.56.0/linux-${architecture}-opm" "${checksum}" | cat >/usr/local/bin/opm  && \
    chmod +x /usr/local/bin/opm && \
    go clean -modcache && \
    go clean -cache && \
    rm -rf /go/src/ && \
    rm -rf /tmp/*
