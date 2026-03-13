FROM to-be-replaced-by-local-ref/base:ubi-9.7-minimal

RUN set -euExo pipefail && shopt -s inherit_errexit && \
    microdnf update -y && \
    microdnf install -y make python3.12 git && \
    microdnf clean all && \
    rm -rf /var/cache/dnf/* && \
    # Checksum is the result of the following command: echo $( curl --fail --retry 5 --retry-all-errors -L "https://releases.astral.sh/github/uv/releases/download/0.10.9/uv-$(arch)-unknown-linux-gnu.tar.gz" | sha512sum | cut -d " " -f 1 ) \
    case $(arch) in \
      x86_64) architecture="x86_64" checksum="8e71c5b7af203336d4f7210d34afdf56b8a8a466c7fe1118a3729938ffebbe71a7db01d58089f715ba45d2e740145047a249fcd058d82be8d3d8789d45c37220" ;; \
      aarch64) architecture="aarch64" checksum="a8436f38d8e322ab3dcf90a229a29c8aa9861e97fdedb43ccc1b7903dd54e7d95a338f6ae6c0a7a1aee0d0c1091c8cf48004970887e7a6e1e8ba844eabbc6215" ;; \
      *) exit 42;; \
    esac && \
    tmp="$( mktemp )" && \
    curl --fail --retry 5 --retry-all-errors -L "https://releases.astral.sh/github/uv/releases/download/0.10.9/uv-${architecture}-unknown-linux-gnu.tar.gz" -o "${tmp}" && \
    sha512sum -c <( echo "${checksum}  ${tmp}" ) && \
    tar -C /usr/local/bin -xzf "${tmp}" --strip-components=1 "uv-${architecture}-unknown-linux-gnu/uv" && \
    rm "${tmp}" && \
    uv --version
