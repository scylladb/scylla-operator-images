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
        x86_64) architecture="amd64" checksum="5213abec3208bc9af330c870e67c08ef4b336f6e07d119a62081dace5805478550a74e67bcc926d30f9f642a3543699936f397e123c6587e7519411d6e3648f9" ;; \
        aarch64) architecture="arm64" checksum="2e24226d24617fad92f747d0a881fe8ccf7843de11b4984bae43e9892e52a9e7cf1e050ffca25523db324a96b3edea6f623d5133dda8a966326e9b103bee3797" ;; \
        *) exit 42;; \
    esac && \
    /tmp/download-file.sh "https://go.dev/dl/go1.22.7.linux-${architecture}.tar.gz" "${checksum}" | tar -C /usr/local -xzf - && \
    go install -v golang.org/x/vuln/cmd/govulncheck@latest && \
    go install -v github.com/mikefarah/yq/v4@v4.44.3 && \
    go install -v helm.sh/helm/v3/cmd/helm@1e210a2 && echo "installed helm v3.12.2" && \
    mv "$( go env GOPATH )/bin/yq" /usr/local/bin/ && \
    rm -rf /tmp/*
