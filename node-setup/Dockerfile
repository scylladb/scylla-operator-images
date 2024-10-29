FROM to-be-replaced-by-local-ref/base:ubi-9.4-minimal

RUN microdnf update -y && \
    microdnf install -y xfsprogs mdadm nc --nodocs --enablerepo almalinux-base-9 && \
    microdnf clean all && \
    rm -rf /var/cache/dnf/*
