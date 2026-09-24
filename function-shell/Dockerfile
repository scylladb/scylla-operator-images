# renovate: datasource=docker packageName=xpkg.upbound.io/crossplane-contrib/function-shell versioning=semver
FROM xpkg.upbound.io/crossplane-contrib/function-shell:v0.6.0

USER root

RUN set -eux && \
    # Checksum is the result of the following command: echo $( curl --fail -L "https://dl.k8s.io/release/v1.36.5/bin/linux/${architecture}/kubectl" | sha512sum | cut -d " " -f 1 )
    case $(uname -m) in \
      x86_64)  architecture="amd64"  checksum="37b9a3952c0a6d1f0f5b356762810dd214879afc6f20b4f3bfea808ac7ac049cbb8dfb03e14b5c95e48256a9da17bc9f3900760ce990f885a62bbe55ac644eca" ;; \
      aarch64) architecture="arm64"  checksum="9dcdd5ef0e38287bdbab49163d746ab6db5917c2baf721165124145637e3c94e4e645de288fe4b29fb564ea2cbf69de780e65d5b42cdaa9692709735c5d86a97" ;; \
      *) exit 42 ;; \
    esac && \
    tmp="$(mktemp)" && \
    curl --fail --retry 5 --retry-all-errors -L \
      "https://dl.k8s.io/release/v1.36.5/bin/linux/${architecture}/kubectl" -o "${tmp}" && \
    echo "${checksum}  ${tmp}" | sha512sum -c - && \
    mv "${tmp}" /usr/local/bin/kubectl && \
    chmod 0755 /usr/local/bin/kubectl && \
    chown root:root /usr/local/bin/kubectl && \
    kubectl version --client

RUN pip install --no-cache-dir oci-cli==3.81.1 && \
    oci --version

USER nonroot:nonroot
