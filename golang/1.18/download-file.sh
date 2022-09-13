#!/usr/bin/env bash

set -euExo pipefail
shopt -s inherit_errexit

if [ "$#" != "2" ]; then
	echo "Usage: $0 <URL> <SHA>" > /dev/stderr
	exit 1
fi

url="$1"
sha="$2"

tmp="$( mktemp )"
trap 'rm -f ${tmp}' EXIT

curl --fail --retry 5 -L "${url}" > "${tmp}"

sha512sum -c <( echo "${sha}  ${tmp}" ) > /dev/stderr

cat "${tmp}"
