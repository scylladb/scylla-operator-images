FROM quay.io/podman/stable:v4.5

RUN set -euExo pipefail && shopt -s inherit_errexit && \
    dnf install -y rsync git make tar gzip golang && \
    dnf clean all && \
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
