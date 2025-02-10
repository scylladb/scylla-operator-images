#!/usr/bin/env bash

set -euExo pipefail
shopt -s inherit_errexit

source "$( dirname "${BASH_SOURCE[0]}" )/lib.sh"

# Fetch the latest versions
version_info="$( curl --fail --retry 5 --retry-all-errors -L  https://go.dev/dl/?mode=json )"

function get-latest-version {
  echo "${version_info}" | jq -r '.[] | select( .version | test("'"${1}"'") ) | .version | sub("^go"; "")'
}

for version_regex in 'go1\\.23($|\\.[0-9]+)'; do
  version=$( get-latest-version "${version_regex}" )
  short_version="${version%.*}"
  find "${short_version}" -name '*.sum' -delete

  for architecture in 'amd64' 'arm64' ; do
    url="$( get-url "${version}" "${architecture}" )"
    echo "VERSION=${version}" > "${short_version}/version.sh"
    curl --fail --retry 5 --retry-all-errors -L "${url}" | sha512sum > "${short_version}/${url##*/}.sum"
  done
done
