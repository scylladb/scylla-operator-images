FROM to-be-replaced-by-local-ref/base:ubi-9.4-minimal

ENV GOPATH=/go \
    GOROOT=/usr/local/go \
    GOTOOLCHAIN=local
ENV PATH=${PATH}:${GOROOT}/bin:${GOPATH}/bin

COPY ./download-file.sh /tmp/

RUN microdnf update -y && \
    microdnf install -y git make tar gzip gcc g++ findutils && \
    microdnf install -y dbus-x11 --enablerepo=almalinux-appstream-9 && \
    microdnf clean all && \
    rm -rf /var/cache/dnf/* && \
    case $(arch) in \
        x86_64) architecture="amd64" checksum="7bc978aad1dcfed937c4b1d18e43c7eb3fc836ffbf359548bfd4bb5f77814c4994eaee18a7ceefa8e7d4c5a2fb97e26bc4d2f5a7c54dd5ee437f08b74a06f111" ;; \
        aarch64) architecture="arm64" checksum="17a1152545b623321c33cc10fb08d95701f24e6a2c371da20aac44a8aba5101b069fecd62c27acd8c0fca030e78466244ed86f02560312560088fd7af2eb87ac" ;; \
        *) exit 42;; \
    esac && \
    /tmp/download-file.sh "https://go.dev/dl/go1.22.5.linux-${architecture}.tar.gz" "${checksum}" | tar -C /usr/local -xzf - && \
    go install golang.org/x/vuln/cmd/govulncheck@latest && \
    go install github.com/mikefarah/yq/v4@v4.34.1 && \
    go install helm.sh/helm/v3/cmd/helm@1e210a2 && echo "installed helm v3.12.2" && \
    mv "$( go env GOPATH )/bin/yq" /usr/local/bin/ && \
    rm -rf /tmp/*
