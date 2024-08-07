FROM registry.access.redhat.com/ubi9/ubi-minimal:9.4-1194

SHELL ["/usr/bin/bash", "-euExo", "pipefail", "-O", "inherit_errexit", "-c"]

# Install a minimal subset of packages that *every* runtime image needs.
RUN microdnf update -y && \
    microdnf install -y jq && \
    microdnf clean all && \
    rm -rf /var/cache/dnf/*

ENTRYPOINT []
CMD ["/usr/bin/bash"]
