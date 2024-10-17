FROM to-be-replaced-by-local-ref/base:ubi-9.4-minimal

SHELL ["/usr/bin/bash",	"-euExo", "pipefail", "-O", "inherit_errexit", "-c"]

ENV GOPATH=/go \
    GOROOT=/usr/local/go \
    GOTOOLCHAIN=local
ENV PATH=${PATH}:${GOROOT}/bin:${GOPATH}/bin

COPY ./version.sh ./lib.sh /tmp/
COPY *.sum /tmp/

RUN set -euExo pipefail && shopt -s inherit_errexit && \
    microdnf update -y && \
    microdnf install -y git make tar gzip gcc g++ findutils && \
    microdnf install -y dbus-x11 --enablerepo=almalinux-appstream-9 && \
    microdnf clean all && \
    rm -rf /var/cache/dnf/* && \
    source /tmp/lib.sh && \
    architecture="$( resolve-arch "$(arch)" )" && \
    source /tmp/version.sh && \
    install-golang "${VERSION}" "${architecture}" && \
    go install golang.org/x/vuln/cmd/govulncheck@latest && \
    go install github.com/mikefarah/yq/v4@v4.44.3 && \
    go install helm.sh/helm/v3/cmd/helm@1e210a2 && echo "installed helm v3.12.2" && \
    mv "$( go env GOPATH )/bin/yq" /usr/local/bin/ && \
    rm -rf /tmp/*
