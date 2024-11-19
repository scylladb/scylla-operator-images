FROM registry.access.redhat.com/ubi9/ubi-minimal:9.5

SHELL ["/usr/bin/bash", "-euExo", "pipefail", "-O", "inherit_errexit", "-c"]

# Install a minimal subset of packages that *every* runtime image needs.
RUN microdnf update -y && \
    microdnf install -y jq tar findutils util-linux-core && \
    microdnf clean all && \
    rm -rf /var/cache/dnf/* && \
    curl -L https://repo.almalinux.org/almalinux/9/BaseOS/x86_64/os/RPM-GPG-KEY-AlmaLinux-9 -o /etc/pki/rpm-gpg/RPM-GPG-KEY-AlmaLinux

COPY almalinux.repo /etc/yum.repos.d/almalinux.repo
COPY almalinux-appstream.repo /etc/yum.repos.d/almalinux-appstream.repo

ENTRYPOINT []
CMD ["/usr/bin/bash"]
