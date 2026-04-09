FROM quay.io/buildah/stable:v1.37

RUN set -euExo pipefail && shopt -s inherit_errexit && \
    dnf install -y git && \
    dnf clean all && \
    git config --system --add safe.directory '*'

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash"]
