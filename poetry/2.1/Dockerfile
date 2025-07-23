FROM to-be-replaced-by-local-ref/base:ubi-9.5-minimal

RUN set -euExo pipefail && shopt -s inherit_errexit && \
    microdnf update -y && \
    microdnf install -y make python3.12 git && \
    microdnf clean all && \
    rm -rf /var/cache/dnf/* && \
    poetry_version=2.1.3 && \
    # Checksum is the result of the following command: echo $( curl --fail --retry 5 --retry-all-errors -L "https://raw.githubusercontent.com/python-poetry/install.python-poetry.org/329cc8d004808d48a4776e753cf6356702646f22/install-poetry.py" | sha512sum | cut -d " " -f 1 )
    installer_checksum="cc7eefe934874184da5cf5048f61abec737b8fcb0657c11c10e10a4e6266ca214d64aa730fb75465c3dbcc088e936604405f8be3f0efb3b15c7293c88a0c15bf" && \
    poetry_installer="$( mktemp )" && \
    curl --fail --retry 5 --retry-all-errors -L "https://raw.githubusercontent.com/python-poetry/install.python-poetry.org/329cc8d004808d48a4776e753cf6356702646f22/install-poetry.py" -o "${poetry_installer}" && \
    sha512sum -c <( echo "${installer_checksum}  ${poetry_installer}" ) && \
    python3.12 "${poetry_installer}" --version "${poetry_version}" -y && \
    rm "${poetry_installer}" && \
    ln -s ~/.local/bin/poetry /usr/local/bin/poetry && \
    poetry --version
