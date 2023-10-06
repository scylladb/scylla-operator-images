FROM docker.io/library/ubuntu:22.04

SHELL ["/usr/bin/bash", "-euExo", "pipefail", "-O", "inherit_errexit", "-c"]

# Install a minimal subset of packages that *every* runtime image needs.
RUN echo 'APT::Acquire::Retries "5";' > /etc/apt/apt.conf.d/80-retries && \
    apt update && \
    apt upgrade -y && \
    apt install -y --no-install-recommends curl ca-certificates jq && \
    apt clean all && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT []
CMD ["/usr/bin/bash"]
