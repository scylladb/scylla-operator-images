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
  curl --fail --retry 5 --retry-all-errors -L "${url}" > "/tmp/${f}"
  cat "/tmp/${f}" | sha512sum -c "/tmp/${f}.sum"
  tar -C /usr/local -xzf "/tmp/${f}"
}
