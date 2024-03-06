FROM quay.io/buildah/stable:v1.33

RUN set -euExo pipefail && shopt -s inherit_errexit && \
    dnf install -y git && \
    dnf clean all && \
    git config --global --add safe.directory '*'
