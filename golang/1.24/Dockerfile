FROM to-be-replaced-by-local-ref/base:ubi-9.5-minimal

SHELL ["/usr/bin/bash",	"-euExo", "pipefail", "-O", "inherit_errexit", "-c"]

ENV GOPATH=/go \
    GOROOT=/usr/local/go \
    GOTOOLCHAIN=local
ENV PATH=${PATH}:${GOROOT}/bin:${GOPATH}/bin

COPY ./versions.sh ./lib.sh /scripts/
COPY /checksums/*.sum /checksums/

RUN set -euExo pipefail && shopt -s inherit_errexit && \
    microdnf update -y && \
    microdnf install -y git make tar gzip gcc g++ findutils diffutils file && \
    microdnf install -y dbus-x11 --enablerepo=almalinux-appstream-9 && \
    microdnf clean all && \
    rm -rf /var/cache/dnf/* && \
    source /scripts/lib.sh && \
    architecture="$( resolve-arch "$(arch)" )" && \
    source /scripts/versions.sh && \
    install-golang "${GOLANG_VERSION}" "${architecture}" && \
    install-golangci-lint "${GOLANGCI_LINT_VERSION}" "${architecture}" && \
    go install golang.org/x/vuln/cmd/govulncheck@latest && \
    go install github.com/mikefarah/yq/v4@v4.44.3 && \
    go install helm.sh/helm/v3/cmd/helm@1e210a2 && echo "installed helm v3.12.2" && \
    mv "$( go env GOPATH )/bin/yq" /usr/local/bin/ && \
    mkdir -p /go/src/github.com/operator-framework && \
    cd /go/src/github.com/operator-framework && \
    # TODO: replace to upstream once https://github.com/operator-framework/operator-sdk/pull/6978 is released \
    git clone --depth=1 --branch support-aggregated-clusterroles https://github.com/zimnx/operator-sdk.git && \
    cd ./operator-sdk && \
    make build && \
    mv /go/src/github.com/operator-framework/operator-sdk/build/operator-sdk /usr/bin/ && \
    go clean -modcache && \
    go clean -cache && \
    rm -rf /go/src/ && \
    rm -rf /checksums /scripts
