#!/usr/bin/env bash

set -euExo pipefail
shopt -s inherit_errexit

function resolve-arch {
  case "${1}" in
    x86_64) echo "amd64";;
    aarch64) echo "arm64";;
    *) exit 42;;
  esac
}

function get-url {
  echo "https://go.dev/dl/go${1}.linux-${2}.tar.gz"
}

function install-golang {
  url="$( get-url "${1}" "${2}" )"
  f="$( basename "${url}" )"
  tmpdir="$(mktemp -d)"
  curl --fail --retry 5 --retry-all-errors -L "${url}" > "/${tmpdir}/${f}"
  cat "${tmpdir}/${f}" | sha512sum -c "/checksums/${f}.sum"
  tar -C /usr/local -xzf "${tmpdir}/${f}"
}

function install-golangci-lint {
  version="${1}"
  arch="${2}"
  url="https://github.com/golangci/golangci-lint/releases/download/v${version}/golangci-lint-${version}-linux-${arch}.tar.gz"
  f="$( basename "${url}" )"
  tmpdir="$(mktemp -d)"
  curl --fail --retry 5 --retry-all-errors -L "${url}" > "${tmpdir}/${f}"
  cat "${tmpdir}/${f}" | sha512sum -c "/checksums/${f}.sum"
  tar -C "${tmpdir}" -xzf "${tmpdir}/${f}"
  mv "${tmpdir}/golangci-lint-${version}-linux-${arch}/golangci-lint" /usr/local/bin/
  chmod +x /usr/local/bin/golangci-lint
}
