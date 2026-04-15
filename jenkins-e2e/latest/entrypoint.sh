#!/usr/bin/bash
set -euEo pipefail

if [[ -z "${SCYLLADB_IMAGE_REF:-}" ]]; then
  echo "error: SCYLLADB_IMAGE_REF is not set or empty" >&2
  exit 1
fi

if [[ -z "${PROWJOB_NAME:-}" ]]; then
  echo "error: PROWJOB_NAME is not set or empty" >&2
  exit 1
fi

tmpfile=$(mktemp)
trap "rm -f '${tmpfile}'" EXIT

sed "s|__SCYLLADB_IMAGE_REF__|${SCYLLADB_IMAGE_REF}|; s|__PROWJOB_NAME__|${PROWJOB_NAME}|" \
  /etc/prow/job.yaml > "${tmpfile}"

mkpj \
  --config-path=/etc/prow/config.yaml \
  --job-config-path="${tmpfile}" \
  --job="${PROWJOB_NAME}" \
| kubectl create -n prow-workspace -f -
