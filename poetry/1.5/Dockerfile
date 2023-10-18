FROM registry.access.redhat.com/ubi9/ubi:latest

RUN set -euExo pipefail && shopt -s inherit_errexit && \
    dnf install -y make python3.9 git && \
    dnf clean all && \
    poetry_version=1.5.1 && \
    installer_checksum="b77d439f2eed8b4efdf26177d43617f8fba4b0a4e262b6b45313d7bc0c6e61706a111a7a8a896f24cb67cebbb7ad7b4ef118dc51b3ce3ea4515b8dc137434c3e" && \
    poetry_installer="$( mktemp )" && \
    curl --fail --retry 5 --retry-all-errors -L "https://raw.githubusercontent.com/python-poetry/poetry/${poetry_version}/install-poetry.py" -o "${poetry_installer}" && \
    sha512sum -c <( echo "${installer_checksum}  ${poetry_installer}" ) && \
    python3 "${poetry_installer}" --version "${poetry_version}" -y && \
    rm "${poetry_installer}" && \
    ln -s ~/.local/bin/poetry /usr/local/bin/poetry && \
    poetry --version
