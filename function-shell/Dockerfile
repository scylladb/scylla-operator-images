FROM xpkg.upbound.io/crossplane-contrib/function-shell:v0.6.0

USER root

RUN set -eux && \
    # Checksum is the result of the following command: echo $( curl --fail -L "https://dl.k8s.io/release/v1.35.2/bin/linux/${architecture}/kubectl" | sha512sum | cut -d " " -f 1 )
    case $(uname -m) in \
      x86_64)  architecture="amd64"  checksum="b40382cca3af079069ffc0496398a765371a929f65cc9e6161bf7116499e7c27aadc9cdb8dfc26b85a6648ca2b25c3d3b2f32b7ef6d0a1cd8e9805e272b37d41" ;; \
      aarch64) architecture="arm64"  checksum="e8b0a21c2f025baf77d6cbb45bea33616fd3cdd2c99de403deb2564635bdb07b2fd2279430bc99481530346da922e851fc307cdd9cab925331702cbd1154cc15" ;; \
      *) exit 42 ;; \
    esac && \
    tmp="$(mktemp)" && \
    curl --fail --retry 5 --retry-all-errors -L \
      "https://dl.k8s.io/release/v1.35.2/bin/linux/${architecture}/kubectl" -o "${tmp}" && \
    echo "${checksum}  ${tmp}" | sha512sum -c - && \
    mv "${tmp}" /usr/local/bin/kubectl && \
    chmod 0755 /usr/local/bin/kubectl && \
    chown root:root /usr/local/bin/kubectl && \
    kubectl version --client

RUN pip install --no-cache-dir oci-cli==3.81.1 && \
    oci --version

USER nonroot:nonroot
