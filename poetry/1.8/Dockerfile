FROM to-be-replaced-by-local-ref/base:ubi-9.4-minimal

RUN set -euExo pipefail && shopt -s inherit_errexit && \
    microdnf update -y && \
    microdnf install -y make python3.11 git && \
    microdnf clean all && \
    rm -rf /var/cache/dnf/* && \
    poetry_version=1.8.3 && \
    installer_checksum="1be64f74ed0a7075331eeb27190aee77c2df37b368b6d7e7523923d178ed125e81f2fb6a13b809344dd56a233c2eeee30321d0a5828b87663336b2f97c1d53bc" && \
    poetry_installer="$( mktemp )" && \
    curl --fail --retry 5 --retry-all-errors -L "https://raw.githubusercontent.com/python-poetry/install.python-poetry.org/fcd759d6feb9142736a19f8a753be975a120be87/install-poetry.py" -o "${poetry_installer}" && \
    sha512sum -c <( echo "${installer_checksum}  ${poetry_installer}" ) && \
    python3.11 "${poetry_installer}" --version "${poetry_version}" -y && \
    rm "${poetry_installer}" && \
    ln -s ~/.local/bin/poetry /usr/local/bin/poetry && \
    poetry --version
