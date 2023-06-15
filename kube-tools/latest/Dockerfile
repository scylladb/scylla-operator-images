FROM to-be-replaced-by-local-ref/golang:1.20

RUN set -euExo pipefail && shopt -s inherit_errexit && \
    apt-get update && \
    apt-get install -y --no-install-recommends rsync && \
    apt-get clean && \
    mkdir -p /go/src/k8s.io/ && \
    cd /go/src/k8s.io/ && \
    git clone --depth=1 --branch v1.27.3 https://github.com/kubernetes/kubernetes.git && \
    cd ./kubernetes && \
    make WHAT=cmd/kubectl && \
    mv /go/src/k8s.io/kubernetes/_output/bin/kubectl /usr/bin/ && \
    rm -rf /go/src/k8s.io/ && \
    rm -rf /tmp/*
