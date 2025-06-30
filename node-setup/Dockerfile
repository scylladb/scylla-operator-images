FROM to-be-replaced-by-local-ref/base:ubi-9.4-minimal

RUN microdnf update -y && \
    microdnf install -y xfsprogs mdadm nc procps-ng --nodocs --enablerepo almalinux-base-9 && \
    microdnf clean all && \
    rm -rf /var/cache/dnf/*
